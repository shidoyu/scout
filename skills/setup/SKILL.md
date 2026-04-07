---
name: setup
description: "Guided interactive setup for scout's search engines and fetching tools. Covers Jina Reader, Exa, and Playwright. Triggers when setting up scout, configuring API keys, adding search engines, troubleshooting fetch failures, or improving search quality."
---

# scout:setup — Guided Configuration

## Purpose

Walk the user through configuring scout's optional search and fetching tools via interactive dialogue. Each step explains what the tool adds and lets the user decide.

## Core Principle

**"scout already works. These options make it stronger. The user chooses."**

- **Respond in the user's language** — detect from conversation context or system locale. All dialogue, explanations, and confirmations must be in the user's language. Only URLs and CLI commands stay in English.
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

Run this check first. Only present steps for tools that are not yet configured. If everything is already configured, tell the user and skip setup.

## Interaction Flow

CRITICAL: This is a multi-turn dialogue. You MUST present only ONE step per response, then STOP and wait for the user's reply. Do NOT mention, preview, or summarize upcoming steps.

The flow is:

1. Run pre-check
2. Present the FIRST unconfigured item (see step details below). Then STOP.
3. User responds (provides key, says "skip", asks a question, etc.)
4. Handle the response (configure or skip). Then present the NEXT unconfigured item. Then STOP.
5. Repeat until all items are addressed.
6. Run "After Setup" once.

### What to say for each item

**Jina Reader** (present first if unconfigured):

Say: Jina Reader fetches web pages as clean Markdown instead of raw HTML. Improves every URL fetch. A free API key is available at https://jina.ai/?newKey — paste it here, or say "skip".

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

**Exa** (present second if unconfigured):

Say: Exa adds meaning-based search — it finds pages by concept, not just keywords. The free exa-free tools are already included; this adds advanced features (company research, deep research). Get an API key at https://exa.ai — paste it here, or say "skip".

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

**Playwright** (present last if not installed):

Say: Playwright lets scout read JavaScript-rendered pages (SPAs, dashboards) locally. Also handles confidential URLs without sending them to external APIs. Downloads Chromium (~200MB). Install it? Or say "skip".

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
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/scout"
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
