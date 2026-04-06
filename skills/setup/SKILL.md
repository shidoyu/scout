---
name: setup
description: "Guided interactive setup for scout's search engines and fetching tools. Covers Jina Reader, Exa, and Playwright. Triggers when setting up scout, configuring API keys, adding search engines, troubleshooting fetch failures, or improving search quality."
---

# scout:setup — Guided Configuration

## Purpose

Walk the user through configuring scout's optional search and fetching tools via interactive dialogue. Each step explains what the tool adds and lets the user decide.

## Core Principle

**"scout already works. These options make it stronger. The user chooses."**

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

## Setup Steps

Present steps in this order (immediate value first):

### Step 1: Jina Reader

**What it adds**: Web pages are fetched as clean Markdown text instead of raw HTML. Improves the quality of every URL fetch.

**How to set up**:
1. Tell the user: "Jina Reader fetches web pages as clean Markdown. A free API key is available at https://jina.ai/?newKey"
2. Wait for the user to provide a key
3. If provided, configure it:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
MCP_DIST="$PLUGIN_ROOT/.mcp.json.dist"

# Ensure .mcp.json exists
if [ ! -f "$MCP_JSON" ]; then
  cp "$MCP_DIST" "$MCP_JSON"
fi

# Write Jina Reader config (replace JINA_KEY with the actual key)
jq --arg key "JINA_KEY" \
  '.mcpServers["jina-reader"] = {
    "type": "http",
    "url": "https://mcp.jina.ai/v1",
    "headers": { "Authorization": ("Bearer " + $key) }
  }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
chmod 600 "$MCP_JSON"
```

4. Confirm: "Jina Reader configured."

### Step 2: Exa (API key)

**What it adds**: Semantic search that finds pages by meaning, not just keywords. Especially effective for conceptual queries where you can't name what you're looking for.

**How to set up**:
1. Tell the user: "Exa adds meaning-based search. It excels at finding things when you don't have the right keywords yet. Get an API key at https://exa.ai"
2. Note: The free `exa-free` MCP server is already included and works without a key. This step adds the paid `exa` tools for advanced features (company research, deep research, etc.)
3. Wait for the user to provide a key
4. If provided, configure it:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
MCP_DIST="$PLUGIN_ROOT/.mcp.json.dist"

# Ensure .mcp.json exists
if [ ! -f "$MCP_JSON" ]; then
  cp "$MCP_DIST" "$MCP_JSON"
fi

# Write Exa config (replace EXA_KEY with the actual key)
jq --arg key "EXA_KEY" \
  '.mcpServers.exa = {
    "type": "http",
    "url": ("https://mcp.exa.ai/mcp?exaApiKey=" + $key + "&tools=web_search_advanced_exa,crawling_exa,company_research_exa,people_search_exa,deep_researcher_start,deep_researcher_check")
  }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
chmod 600 "$MCP_JSON"
```

5. Confirm: "Exa configured."

### Step 3: Playwright

**What it adds**: Reads JavaScript-rendered pages (SPAs, dashboards) that other tools can't access. Also handles confidential URLs locally without sending them to external APIs.

**How to set up**:
1. Tell the user: "Playwright lets scout read JavaScript-rendered pages locally. It downloads Chromium (~200MB)."
2. Wait for explicit consent before proceeding
3. If consented:

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
VENV_DIR="$PLUGIN_ROOT/tools/.venv"
python3 -m venv "$VENV_DIR" && \
  "$VENV_DIR/bin/pip" install --quiet playwright && \
  "$VENV_DIR/bin/playwright" install chromium
```

4. If the install fails, show the manual commands and move on. Do not retry.
5. Confirm: "Playwright installed."

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

3. Show a summary of what was configured.

4. Propose a demo search to try out the configured tools. Suggest one of these queries that showcase scout's strength — where query redesign makes a clear difference:
   - "I want something like Git blame but for design decisions" — scout translates this concept into the right term (ADR) and reaches primary sources, while a plain keyword search returns git blame tutorials
   - "What should I actually migrate to from Terraform — not the sponsored lists, real migration stories" — scout filters past SEO noise to find real experience reports
   
   Let the user pick one, or suggest their own topic. If they decline, move on.
