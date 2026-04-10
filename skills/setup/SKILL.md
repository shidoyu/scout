---
name: setup
description: "Guided interactive setup for scout's search engines and fetching tools. Covers Context7, Jina Reader, Exa, and Playwright. Triggers when setting up scout, configuring API keys, adding search engines, troubleshooting fetch failures, or improving search quality."
---

# scout:setup — Guided Configuration

## Purpose

Walk the user through configuring scout's optional search and fetching tools via interactive dialogue. Each step explains what the tool adds and lets the user decide.

## Core Principle

**"scout already works. These options make it stronger. The user chooses."**

## Transparency Protocol

Every configuration change must be visible before it happens. This builds trust and lets the user understand what scout is doing to their environment.

1. **Show the diff before writing** — Before editing `.mcp.json` or any config file, display the exact JSON block that will be added. Format: "Adding this to `[file path]`:" → fenced JSON block → then write. No extra confirmation needed — the step-level consent ("Install") already covers it.

2. **Echo commands before running** — Before executing shell commands (e.g., `npx playwright install chromium`, `claude mcp add ...`, `pip install ...`), display the command first. Format: "Running:" → fenced command block → then execute. Do NOT ask for separate confirmation here — the step-level consent already covers it.

3. **State the footprint** — For installs that add significant disk usage (e.g., Playwright ~200MB), state the approximate size before the user consents.

These rules apply to every step below. They do not add extra confirmation prompts — they make the existing prompts more informative.

## Interaction Rules

- **Respond in the user's language** — check the `locale:` line from the pre-check output (e.g. `ja_JP` → Japanese, `es_ES` → Spanish, `en_US` → English). ALL dialogue, explanations, step titles, and option descriptions MUST be in that language. The English templates below are for content guidance only — NEVER output them as-is. Only URLs and CLI commands stay in English.
- Frame each tool as an upgrade, not a missing piece
- Every step is skippable — do not ask why if the user declines
- State facts about what each tool adds, not what's lost without it
- No excessive celebration on completion. A simple confirmation is enough
- Never install or configure anything without explicit consent

## Pre-check

Before starting, diagnose the current state:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
VENV_DIR="$PLUGIN_ROOT/tools/.venv"

echo "=== scout setup status ==="

# System locale for language detection
echo "locale: $(defaults read -g AppleLocale 2>/dev/null || echo "${LANG:-en_US}")"

# Context7 (user-scoped MCP — check via claude CLI or config file)
if command -v claude >/dev/null 2>&1 && claude mcp list 2>/dev/null | grep -q context7; then
  echo "context7: configured"
elif [ -f "$HOME/.claude.json" ] && jq -e '.mcpServers.context7' "$HOME/.claude.json" > /dev/null 2>&1; then
  echo "context7: configured"
else
  echo "context7: not configured"
fi

# Jina Reader
if [ -f "$MCP_JSON" ] && jq -e '.mcpServers["jina-reader"].headers.Authorization // empty | length > 0' "$MCP_JSON" > /dev/null 2>&1; then
  echo "jina: configured"
else
  echo "jina: not configured"
fi

# Exa (paid)
if [ -f "$MCP_JSON" ] && jq -e '.mcpServers.exa' "$MCP_JSON" > /dev/null 2>&1; then
  echo "exa: configured"
else
  echo "exa: not configured"
fi

# Playwright
if [ -f "$VENV_DIR/bin/python" ] && "$VENV_DIR/bin/python" -c "import playwright" 2>/dev/null; then
  echo "playwright: installed"
else
  echo "playwright: not installed"
fi
```

Run this check first. Present ALL four steps in order. For already-configured items, show them as a one-line confirmation (e.g. "Step 1/4 — Library & framework docs ✓ configured") and immediately move to the next step. Do not ask the user to act on configured items. If everything is already configured, tell the user and end setup.

## Interaction Flow

CRITICAL: This is a multi-turn dialogue. You MUST present only ONE step per response, then STOP and wait for the user's reply. Do NOT mention, preview, or summarize upcoming steps.

The flow is:

1. Run pre-check
2. Present Step 1 (Context7). If already configured, show "Step 1/4 — ... ✓ configured" as a one-liner, then immediately present Step 2 in the SAME response. If unconfigured, present the full step and STOP.
3. User responds (provides key, says "skip", "private", asks a question, etc.)
4. Handle the response (configure, skip, or show manual instructions). Then present the NEXT step — again, if configured show one-liner and continue to the next unconfigured step. Then STOP.
5. Repeat until all items are addressed.
6. Run "After Setup" once.

### "private" response handling

If the user says "private" for any API key step (Jina or Exa), show them the file path and the JSON to add, so they can edit it themselves without the key passing through the conversation:

```
File: ${CLAUDE_PLUGIN_ROOT}/.mcp.json

# For Jina Reader, add this to mcpServers:
"jina-reader": {
  "type": "http",
  "url": "https://mcp.jina.ai/v1",
  "headers": { "Authorization": "Bearer YOUR_KEY_HERE" }
}

# For Exa, add this to mcpServers:
"exa": {
  "type": "http",
  "url": "https://mcp.exa.ai/mcp?exaApiKey=YOUR_KEY_HERE&tools=web_search_advanced_exa,crawling_exa,company_research_exa,people_search_exa,deep_researcher_start,deep_researcher_check"
}
```

Tell the user to edit the file, then say "done" when finished. Confirm by re-running the pre-check for that item.

### Tone guidance

Write as if you're a colleague helping someone set up their tools — casual, brief, no marketing speak. Do NOT translate English templates literally. Adapt naturally to the user's language and culture. Always output the numbered options as a numbered list — do NOT merge them into a paragraph.

### Framing rules

- **Always use gain framing** — state what the user GETS, not what they AVOID. "key stays in your environment" is correct; "key won't appear in the conversation" is loss-avoidance framing and MUST NOT be used.
- **No unverifiable claims** — "more accurate" or "better results" without a concrete mechanism is overclaiming. Instead, describe what changes observably: "returns just the content as clean text, so the model often has fewer tokens to process."
- **"Already works" must come first** — every step must open by stating what scout already does. The tool strengthens this.
- **Honest delta — describe mechanism, not outcome** — state what the tool concretely adds ("searches by meaning, not just keywords") instead of evaluating the result ("better search"). Additive language ("adds", "extends") is fine. Banned: "unlocks", "lets you...", "〜できるようになります", "〜に対応しています" — these imply current capabilities are locked.
- **Skip option must be procedural, not evaluative** — state what happens ("scout uses its built-in search"), not how good it is ("works fine without it"). The latter triggers the "protesting too much" effect. Add reversibility: "you can add this later."

### Japanese translation pitfalls (check your output against these)

| NG pattern | Why | OK alternative |
|---|---|---|
| 「ただし」「しかし」+ negative | Loss framing via adversative conjunction | Omit conjunction, state fact directly |
| 「そのままだと〜されます」 | Implies current state is a problem | 「scoutがページを取得するとき、広告も含まれます」(neutral fact) |
| 「〜を追加すると〜できる」 | Capability-gating (banned) | 「Exa は意味ベースで検索します」(describe what it IS) |
| 「十分に〜できます」 | Condescending evaluation ("adequate") | 「scoutは Web を検索します」(plain fact) |
| 「なくても問題ありません」 | Overprotesting triggers doubt | 「あとで追加できます」(reversibility) |

### Product name introduction rule

When mentioning a product/service name for the FIRST time, anchor the name to a known category. The order differs by language:
- **Japanese/Korean/Chinese**: category BEFORE the name — e.g. "ページ読み取りサービスの Jina Reader", "セマンティック検索サービスの Exa"
- **English/European**: name first, then context — e.g. "Jina Reader, a page-reading service", "Exa, a semantic search service"

On subsequent mentions, use the name alone.

### What to say for each item

**Step 1 — Context7** (present first if unconfigured):

Convey this (adapt to user's language, do NOT copy verbatim):

> **Step 1/4 — Library & framework docs**
> scout searches the web for technical questions. Context7, a documentation index, adds a direct path to official library and framework docs (React, Prisma, Next.js, etc.) — less time digging through SEO pages, more time on the actual API docs. The indexed content matches the latest published version. No API key needed.
>
> 1. Install — one command, done in seconds
> 2. Skip — you can add this later

If user consents, run:

```bash
claude mcp add -s user context7 -- npx -y @upstash/context7-mcp
```

If the command fails (e.g. `claude` not in PATH), show the manual alternative:
```
Run this in your terminal:
claude mcp add -s user context7 -- npx -y @upstash/context7-mcp
```

Confirm briefly, then move to next item.

---

**Step 2 — Jina Reader** (present if unconfigured):

Convey this (adapt to user's language, do NOT copy verbatim):

> **Step 2/4 — Cleaner web page reading**
> scout fetches web pages as-is, including ads and navigation. Jina Reader, a page-reading service, strips those out and returns just the content as clean text, which often means less text reaches the model and fewer tokens are used. It works without a key for lighter usage. Add a key if you want higher rate limits: https://jina.ai/?newKey
>
> 1. Paste a key — I'll handle the rest
> 2. Set it up myself — I'll show you the file to edit (key stays in your environment only)
> 3. Skip — you can add this later

If user provides a key, configure it:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
MCP_DIST="$PLUGIN_ROOT/.mcp.json.dist"

if [ ! -f "$MCP_JSON" ]; then
  cp "$MCP_DIST" "$MCP_JSON"
fi

jq --arg key "JINA_KEY" \
  '.mcpServers["jina-reader"] = {
    "type": "http",
    "url": "https://mcp.jina.ai/v1",
    "headers": { "Authorization": ("Bearer " + $key) }
  }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
chmod 600 "$MCP_JSON"
```

Confirm briefly, then move to next item.

---

**Step 3 — Exa** (present if unconfigured):

Convey this (adapt to user's language, do NOT copy verbatim):

> **Step 3/4 — Meaning-based web search**
> scout searches the web without any extra keys. Exa, a semantic search service, searches by meaning, not just keywords — useful when you're not sure of the exact terms and want relevant niche sources sooner. Key here: https://exa.ai
>
> 1. Paste a key — I'll handle the rest
> 2. Set it up myself — I'll show you the file to edit (key stays in your environment only)
> 3. Skip — you can add this later

Japanese example (use as reference, adapt naturally):
> ステップ 3/4 — 意味ベースのウェブ検索
> scout はキーなしでもウェブ検索できます。セマンティック検索サービスの Exa は、キーワードではなく意味で検索します。正確な言葉が分からないときに有効です。キーはこちら: https://exa.ai
>
> 1. キーを貼り付ける — あとはこちらで設定します
> 2. 自分で設定する — 編集先のファイルを案内します（キーは手元の環境にのみ保存されます）
> 3. スキップ — あとで追加できます

If user provides a key, configure it:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
MCP_DIST="$PLUGIN_ROOT/.mcp.json.dist"

if [ ! -f "$MCP_JSON" ]; then
  cp "$MCP_DIST" "$MCP_JSON"
fi

jq --arg key "EXA_KEY" \
  '.mcpServers.exa = {
    "type": "http",
    "url": ("https://mcp.exa.ai/mcp?exaApiKey=" + $key + "&tools=web_search_advanced_exa,crawling_exa,company_research_exa,people_search_exa,deep_researcher_start,deep_researcher_check")
  }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
chmod 600 "$MCP_JSON"
```

Confirm briefly, then move to next item.

---

**Step 4 — Playwright** (present last if not installed):

Convey this (adapt to user's language, do NOT copy verbatim):

> **Step 4/4 — Handling interactive pages**
> scout fetches pages via API. Playwright runs a real browser locally — it handles JavaScript-rendered content (SPAs, dashboards) and keeps confidential URLs on your machine, so private pages stay local. Needs ~200MB for Chromium.
>
> 1. Install
> 2. Skip

If user consents:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
VENV_DIR="$PLUGIN_ROOT/tools/.venv"
python3 -m venv "$VENV_DIR" && \
  "$VENV_DIR/bin/pip" install --quiet playwright && \
  "$VENV_DIR/bin/playwright" install chromium
```

If the install fails, show the manual commands and move on. Do not retry.

## After Setup

1. Run `/mcp` to reload MCP servers so the new configurations take effect. Do this yourself — do not ask the user to do it. If `/mcp` cannot be executed programmatically, tell the user to type `/mcp` to complete the setup.

2. Write the setup status flag:

```bash
STATE_DIR="${CLAUDE_PLUGIN_DATA:-${XDG_STATE_HOME:-$HOME/.local/state}/scout}"
mkdir -p "$STATE_DIR"
cat > "$STATE_DIR/setup-status.json" << 'STATUSEOF'
{"complete": true}
STATUSEOF
```

3. Show a brief summary of what was configured.

4. Propose a demo search to try out the configured tools. Suggest one of these queries that showcase scout's strength — where query redesign makes a clear difference:
   - "I want something like Git blame but for design decisions" — scout translates this concept into the right term (ADR) and reaches primary sources, while a plain keyword search returns git blame tutorials
   - "What should I actually migrate to from Terraform — not the sponsored lists, real migration stories" — scout filters past SEO noise to find real experience reports
   
   Let the user pick one, or suggest their own topic. If they decline, move on.
