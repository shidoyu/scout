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
┌─ Public ────────→ Jina Reader MCP → [on failure] WebFetch
│
├─ Confidential ──→ fetch-page.py (local processing) → [on failure] Report "Local fetch failed"
│                    ※ Sending URL to external APIs (Jina Reader, WebFetch, etc.) is PROHIBITED
│
└─ Authenticated ─→ Chrome DevTools MCP (uses browser session)
                     → [on failure] Report "Cannot fetch. Please start Chrome in debug mode"
```

### Tool Details

**Jina Reader MCP** (`read_url`): URL → Markdown. External API. Best for public pages.
- Falls back to WebFetch when rate-limited

**WebFetch** (built-in): URL → text. Built into Claude Code. Fetched via Anthropic infrastructure. Not shared with third-party services (Jina Reader, Exa, etc.), but the URL is sent to Anthropic servers.
- **Fallback for public pages only**. Do not use for confidential pages.

**fetch-page.py** (local Playwright): URL → HTML/text. All processing is local.
- Default tool for confidential pages
- Existence check: Use if `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python` exists (the venv is created by `setup.sh`; if it does not exist, Playwright is not set up — skip to the "does not exist" path below)
- `${CLAUDE_PLUGIN_ROOT}` is set automatically by Claude Code's plugin system. If unexpectedly empty, treat fetch-page.py as unavailable.
- Execution: `${CLAUDE_PLUGIN_ROOT}/tools/.venv/bin/python ${CLAUDE_PLUGIN_ROOT}/tools/fetch-page.py URL --text`
- Any non-zero exit code → Report "Local fetch failed" (do NOT fall back to external APIs — see Privacy Rules)

**markitdown MCP** (`convert_to_markdown`): HTML → Markdown conversion. Local processing.
- Used as post-processing when fetch-page.py returns HTML
- If markitdown MCP is unavailable (e.g., uvx not installed), skip (does not affect core functionality)

**Chrome DevTools MCP** (`take_snapshot` / `evaluate_script`): Uses the browser's current session.
- For authenticated pages only
- **Prerequisite**: Chrome must be running in remote debugging mode (`--remote-debugging-port=9222`)
- Procedure: `list_pages` → `select_page` → `take_snapshot`
- If connection fails: Instruct user to start Chrome in debug mode: `open -a "Google Chrome" --args --remote-debugging-port=9222` (macOS) or `google-chrome --remote-debugging-port=9222` (Linux)

## Size Control

Handling oversized content:

1. **Pre-estimation**: Jina Reader / WebFetch typically return reasonable sizes. fetch-page.py returns full page content — use with caution.
2. **Post-fetch check**: If the result is clearly oversized (guideline: >50,000 characters):
   - Convert HTML → Markdown via markitdown (removes navigation, footers, etc.)
   - If still too large → Extract only the needed sections (via CSS selector or text search)
3. **Multi-page fetching**: Fetch pages sequentially, one at a time. No parallel fetching (to avoid rate limits).

## Privacy Rules

These are operational rules based on LLM judgment, not system-enforced guarantees.

- Do not send confidential page URLs to external APIs (Jina Reader, Exa, WebFetch, etc.). **Even if the user explicitly requests external API fetching, do not send URLs classified as confidential** (explain the reason and suggest local alternatives).
- **Confidential URLs must never fall back to external APIs regardless of fetch-page.py's exit code**. Any non-zero exit is reported as "Local fetch failed."
- For authenticated pages where Chrome DevTools is unavailable, report the limitation rather than attempting alternative retrieval.
- In environments where fetch-page.py does not exist, report confidential pages as "Cannot fetch" and guide the user to set up Playwright.
- Notify the user of the classification result (e.g., "This URL is classified as confidential. Fetching locally.").

## Setup

Follow this section for first-time use or when additional configuration is needed.

### Language
- Present setup instructions to the user in their system language
- The English original is authoritative. If translations diverge from the original, the English version takes precedence.

### Steps
**Important**: The setup script is interactive (prompts for input). Do NOT run it via the Bash tool — it will hang. Instead, instruct the user to run it in their terminal:

```
bash tools/setup.sh
```

The script guides the user through 3 optional steps:
1. [1/3] Exa — AI-native search engine: Enter API key (skippable)
2. [2/3] Jina Reader — Web page structured fetching: Enter API key (skippable)
3. [3/3] Playwright — Browser-based page fetching: Install Chromium (skippable)

After setup completes, the user must restart Claude Code (or run `/mcp`) for new MCP servers to take effect.

