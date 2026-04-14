---
name: fetch
description: "Fetch web page content from URLs. Read articles, documentation, and web pages with privacy-aware tool selection. URL取得、ページ読み込み、コンテンツ取得、Webページ、記事取得、ドキュメント取得、fetch、read page、get content"
---

# scout:fetch v1.0 — URL Content Retrieval

## Purpose

Retrieve content from a URL and return it in an LLM-friendly format (Markdown / text).
Automatically select the appropriate tool based on privacy sensitivity, protecting pages that should not be sent to external services.

## Usage

Explicit invocation:
```
/scout:fetch URL
```

Delegation from scout:search: When the Execute/Assess steps need to deep-dive into URL content, follow this skill's workflow.

## Privacy Classification

Before fetching, classify the URL's privacy level based on domain and context.

| Level | Definition | Examples |
|---|---|---|
| **Public** | Pages accessible to anyone | Blogs, news sites, official docs, GitHub public repos |
| **Confidential** | Non-public pages fetchable via fetch-page.py (local Playwright) | Internal wikis, admin panels, dashboards, BASIC auth sites |
| **Authenticated** | Pages accessible only via browser sessions (cookies). fetch-page.py cannot reach them | Post-OAuth pages (Google, Notion, Slack, etc.), SaaS settings |

Classification hints:
- `localhost`, `*.internal`, `*.local`, corporate domains → Confidential
- `console.*`, `admin.*`, `dashboard.*`, paths containing `/settings`, `/admin` → Confidential
- Paths containing `/api/` → Confidential (except public API docs on `docs.*` or `developer.*` subdomains)
- `*.notion.so`, `*.slack.com`, `*.figma.com`, `*.atlassian.net`, `mail.google.com` → Authenticated
- Known login wall → Try Confidential (fetch-page.py) first; reclassify as Authenticated on failure
- Unknown domain → **Confidential** (err on the safe side; classify as Public only when certain)

## Retrieval Flow

```
Receive URL
  ↓
Classify privacy level
  ↓
Public (Jina MCP available = API key configured)
  ↓
Jina MCP (500 RPM)
  ├─ [402] → r.jina.ai (keyless) + notice 「⚠ Jina token limit reached — falling back to free tier (20/min). Top up: https://jina.ai/」
  ├─ [401] → r.jina.ai (keyless) + notice 「⚠ Jina API key rejected — falling back to free tier. Re-run setup: bash tools/setup.sh」
  ├─ [429/5xx/403/408/connection failure] → r.jina.ai (keyless) silently
  └─ [OK] → done
  ※ If 402/401 already occurred in this session, skip MCP and omit notice
  ※ All r.jina.ai fallbacks share the same failure chain:
       r.jina.ai fails → fetch-page.py (if installed) → WebFetch (direct) → report failure

Public (no Jina MCP = no API key)
  ↓
WebFetch via r.jina.ai (keyless, 20 RPM)
  ├─ [429] → fetch-page.py + notice
  │          「⚠ Jina rate limit hit (20/min). Free API key unlocks 500/min: https://jina.ai/?newKey」
  ├─ [other errors] → fetch-page.py silently
  └─ [OK] → done
       └─ [fetch-page.py fails or unavailable] → WebFetch (direct)
            └─ [fails] → report failure

Confidential → fetch-page.py only → report failure (external APIs prohibited)
Authenticated → browser-control.py only → report failure
```

### Tool Details

**MCP availability**: If Jina Reader MCP tools (e.g. `read_url`) are available in the current session, use MCP. Otherwise, use WebFetch via `r.jina.ai`.

**Jina MCP** (for API key users): Same quality as `r.jina.ai` (Markdown, boilerplate removal, JS rendering) but authenticated via MCP headers. 500 RPM, consumes Jina token pool.
- Available when `jina-reader` is configured in `.mcp.json` (set up via `bash tools/setup.sh`)
- Falls back to `r.jina.ai` (keyless) on any error

**WebFetch via r.jina.ai** (primary for public pages): Strips page boilerplate so less noise fills the context. No API key, no MCP, no token depletion.
- Usage: `WebFetch(url="https://r.jina.ai/{target_url}", prompt="...")`
- Rate: 20 req/min (free, no quota)
- Falls back to direct WebFetch on any error

**WebFetch** (built-in): URL → text. Built into Claude Code. Fetched via Anthropic infrastructure. Not shared with third-party services (Jina, Exa, etc.), but the URL is sent to Anthropic servers.
- Fallback for public pages only. Do not use for confidential pages.

**fetch-page.py** (local Playwright): URL → HTML/text. All processing is local.
- Default tool for confidential pages
- Existence check: use if `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python` exists; if not, skip to WebFetch (direct)
- `${CLAUDE_PLUGIN_ROOT}` is set automatically by Claude Code's plugin system. If unexpectedly empty, treat fetch-page.py as unavailable.
- Execution: `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python ${CLAUDE_PLUGIN_ROOT}/tools/fetch-page.py URL --text`
- Any non-zero exit code → report `Local fetch failed`

**markitdown CLI**: HTML → Markdown conversion. Local processing.
- Used as post-processing when fetch-page.py returns HTML
- Execution: `markitdown` (reads from stdin or file argument)
- Example: `echo "$html" | markitdown` or `markitdown file.html`
- If markitdown is not installed, skip (does not affect core functionality)

**browser-control.py** (Playwright CDP): Connects to the user's running Chrome via CDP. Uses the browser's current session (cookies, logins).
- For authenticated pages only
- **Prerequisite**: Chrome must be running in debug mode with a separate user-data-dir:
  - macOS: `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug`
  - Linux: `google-chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug`
  - Note: Chrome 146+ requires `--user-data-dir` (non-default) for CDP. First launch requires re-login.
- Existence check: use if `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python` exists
- Execution: `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python ${CLAUDE_PLUGIN_ROOT}/tools/browser-control.py list-pages` (verify connection) → `snapshot [INDEX|SUBSTR]` (get content)
- Exit code 2 → Chrome not reachable. Instruct user to start Chrome in debug mode (see above)
- Exit code 1 → No matching tab or empty content

### Notices

- Actionable errors only: 402 (top up), 401 (fix key), keyless 429 (get free key)
- Transient errors: silent (429 with key, 5xx, 403, 408, connection failure)
- Notices appear inline after successful retrieval, one line
- Never block, never ask questions
- Session memory: if the same error already occurred, skip MCP and omit notice; if forgotten, the notice may repeat harmlessly

## Size Control

Handling oversized content:

1. **Pre-estimation**: WebFetch (with or without r.jina.ai) typically returns reasonable sizes. fetch-page.py returns full page content — use with caution.
2. **Post-fetch check**: If the result is clearly oversized (guideline: >50,000 characters):
   - Convert HTML → Markdown via `markitdown` CLI (removes navigation, footers, etc.)
   - If still too large → Extract only the needed sections (via CSS selector or text search)
3. **Multi-page fetching**: Fetch pages sequentially, one at a time. No parallel fetching (to avoid rate limits).

## Privacy Rules

These are operational rules based on LLM judgment, not system-enforced guarantees.

- Do not send confidential page URLs to external APIs (Jina, Exa, WebFetch, etc.). **Even if the user explicitly requests external API fetching, do not send URLs classified as confidential** (explain the reason and suggest local alternatives).
- Confidential URLs must never fall back to external APIs regardless of fetch-page.py's exit code. Any non-zero exit is reported as `Local fetch failed`.
- For authenticated pages where browser-control.py cannot connect, report the limitation rather than attempting alternative retrieval.
- In environments where fetch-page.py does not exist, report confidential pages as `Cannot fetch` and guide the user to set up Playwright.
- Notify the user of the classification result, e.g. `This URL is classified as confidential. Fetching locally.`

## Setup

Follow this section for first-time use or when additional configuration is needed.

### Language
- Present setup instructions to the user in their system language
- The English original is authoritative. If translations diverge from the original, the English version takes precedence.

### Steps
**Important**: The setup script is interactive (prompts for input). Do NOT run it via the Bash tool — it will hang. Instead, instruct the user to run it in their terminal:

```bash
bash tools/setup.sh
```

The script guides the user through 3 optional steps:
1. [1/3] Exa — Semantic search engine: Enter API key (skippable)
2. [2/3] Jina Reader — API key for faster fetching: Enter key or skip for free tier (skippable)
3. [3/3] Playwright — Local browser for JS-heavy pages: Install Chromium (skippable)

After setup completes, the user must restart Claude Code (or run `/mcp`) for new MCP servers to take effect.
