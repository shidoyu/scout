#!/bin/bash
set -euo pipefail
umask 077

PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MCP_JSON="$PLUGIN_ROOT/.mcp.json"
MCP_DIST="$PLUGIN_ROOT/.mcp.json.dist"

# --- Prerequisite check ---
command -v jq >/dev/null 2>&1 || { echo "Error: jq is required. Install with: brew install jq / apt install jq"; exit 1; }

# Backup existing .mcp.json before modifying
[ -f "$MCP_JSON" ] && cp "$MCP_JSON" "$MCP_JSON.bak"
trap 'rm -f "$MCP_JSON.tmp"' EXIT

# If .mcp.json doesn't exist, copy from .mcp.json.dist
# If it exists, merge new entries from .mcp.json.dist (preserve user settings)
if [ ! -f "$MCP_JSON" ]; then
  if [ -f "$MCP_DIST" ]; then
    cp "$MCP_DIST" "$MCP_JSON"
  else
    echo "Error: .mcp.json.dist not found."; exit 1
  fi
elif [ -f "$MCP_DIST" ]; then
  # On upgrade: merge new entries from .mcp.json.dist into existing .mcp.json
  # Existing entries are NOT overwritten (preserves user-configured API keys etc.)
  jq -s '.[0] * { mcpServers: ((.[1].mcpServers // {}) * (.[0].mcpServers // {})) }' "$MCP_JSON" "$MCP_DIST" > "$MCP_JSON.tmp" \
    && mv "$MCP_JSON.tmp" "$MCP_JSON" 2>/dev/null \
    || echo "Warning: merge with .mcp.json.dist failed. Continuing with existing .mcp.json."
fi

# Validate JSON
jq empty "$MCP_JSON" 2>/dev/null || { echo "Error: .mcp.json is not valid JSON."; exit 1; }

# Check for uvx (needed for markitdown MCP; not required for core functionality)
if command -v uvx >/dev/null 2>&1; then
  if ! jq -e '.mcpServers.markitdown' "$MCP_JSON" > /dev/null 2>&1; then
    jq '.mcpServers.markitdown = {"command":"uvx","args":["markitdown-mcp"]}' \
      "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON" 2>/dev/null || true
  fi
else
  echo "Note: uvx not found. markitdown MCP (HTML→Markdown conversion) will not be available."
  echo "  Install: https://docs.astral.sh/uv/getting-started/installation/"
  echo ""
fi

echo "scout setup (3 optional steps, all skippable)"
echo "scout works out of the box. Additional setup extends search and fetch capabilities."
echo ""

# --- [1/3] Exa ---
echo "[1/3] Exa — AI-native search engine"
echo "  Strong for academic papers and niche technical articles."
echo "  Create account & get API key: https://exa.ai"

# Detect existing configuration on re-run
if jq -e '.mcpServers.exa' "$MCP_JSON" > /dev/null 2>&1; then
  echo "  ✓ Already configured (enter a new key to reconfigure)"
fi

read -rp "  API key (Enter to skip): " exa_key

if [ -n "$exa_key" ]; then
  if [[ ${#exa_key} -lt 10 ]]; then
    echo "  ⚠ Key too short. Skipping."
    exa_key=""
  else
    jq --arg key "$exa_key" \
      '.mcpServers.exa = {
        "type": "http",
        "url": ("https://mcp.exa.ai/mcp?exaApiKey=" + $key + "&tools=web_search_advanced_exa,crawling_exa,company_research_exa,people_search_exa,deep_researcher_start,deep_researcher_check")
      }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
    echo "  ✓ Exa configured."
  fi
fi
echo ""

# --- [2/3] Jina Reader ---
echo "[2/3] Jina Reader — Web page structured fetching"
echo "  Fetches web pages as high-quality Markdown text."
echo "  An API key is required for the MCP server to work."
echo "  Get a free API key (no sign-up required): https://jina.ai/?newKey"

# Detect existing API key on re-run
if jq -e '.mcpServers["jina-reader"].headers.Authorization // empty | length > 0' "$MCP_JSON" > /dev/null 2>&1; then
  echo "  ✓ API key already set (enter a new key to reconfigure)"
fi

read -rp "  API key (Enter to skip): " jina_key

if [ -n "$jina_key" ]; then
  if [[ ! "$jina_key" == jina_* ]] && [[ ${#jina_key} -lt 10 ]]; then
    echo "  ⚠ Invalid key format. Skipping."
    jina_key=""
  else
    jq --arg key "$jina_key" \
      '.mcpServers["jina-reader"] = {
        "type": "http",
        "url": "https://mcp.jina.ai/v1",
        "headers": { "Authorization": ("Bearer " + $key) }
      }' "$MCP_JSON" > "$MCP_JSON.tmp" && mv "$MCP_JSON.tmp" "$MCP_JSON"
    echo "  ✓ Jina Reader API key configured."
  fi
fi
echo ""

# --- [3/3] Playwright ---
echo "[3/3] Playwright — Browser-based page fetching"
echo "  Enables fetching content from JavaScript-rendered SPA sites."
echo "  Downloads Chromium browser (~200MB, may take a few minutes)."
echo "  Note: May fail on corporate networks or behind proxies."

VENV_DIR="$PLUGIN_ROOT/tools/.venv"
pw_installed=false

# Detect existing installation on re-run
if [ -f "$VENV_DIR/bin/python" ] \
   && "$VENV_DIR/bin/python" -c "import playwright" 2>/dev/null; then
  echo "  ✓ Already installed"
  pw_installed=true
fi

read -rp "  Set up Playwright? (y/N): " pw_answer

if [[ "$pw_answer" =~ ^[Yy]$ ]]; then
  echo "  Installing Playwright..."
  if python3 -m venv "$VENV_DIR" \
     && "$VENV_DIR/bin/pip" install --quiet playwright \
     && "$VENV_DIR/bin/playwright" install chromium; then
    pw_installed=true
    echo "  ✓ Playwright installed ($VENV_DIR)."
  else
    echo "  ⚠ Playwright setup failed. Skipping."
    echo "    Manual setup:"
    echo "      python3 -m venv $VENV_DIR"
    echo "      $VENV_DIR/bin/pip install playwright"
    echo "      $VENV_DIR/bin/playwright install chromium"
  fi
fi
echo ""

# --- Permissions ---
chmod 600 "$MCP_JSON"
[ -f "$MCP_JSON.bak" ] && chmod 600 "$MCP_JSON.bak"

# --- Summary ---
echo "✓ scout setup complete."

configured=()
not_configured=()

# Check all configurations (including pre-existing ones from previous runs)
exa_exists=false
jina_key_exists=false
jq -e '.mcpServers.exa' "$MCP_JSON" > /dev/null 2>&1 && exa_exists=true
jq -e '.mcpServers["jina-reader"].headers.Authorization // empty | length > 0' "$MCP_JSON" > /dev/null 2>&1 && jina_key_exists=true

([ -n "${exa_key:-}" ] || [ "$exa_exists" = true ]) && configured+=("Exa") || not_configured+=("Exa")
([ -n "${jina_key:-}" ] || [ "$jina_key_exists" = true ]) && configured+=("Jina Reader API key") || not_configured+=("Jina Reader API key")
[ "$pw_installed" = true ] && configured+=("Playwright") || not_configured+=("Playwright")

if [ ${#configured[@]} -gt 0 ]; then
  echo "  Configured: $(IFS=', '; echo "${configured[*]}")"
fi
if [ ${#not_configured[@]} -gt 0 ]; then
  echo "  Not configured: $(IFS=', '; echo "${not_configured[*]}")"
fi

echo ""
echo "  Available now:"
exa_active=""
([ -n "${exa_key:-}" ] || [ "$exa_exists" = true ]) && exa_active="yes"
echo "  - Web search (default${exa_active:+ + Exa} + WebSearch)"
jina_active=""
([ -n "${jina_key:-}" ] || [ "$jina_key_exists" = true ]) && jina_active="yes"
if [ -n "$jina_active" ]; then
  echo "  - URL content fetching (Jina Reader + WebFetch)"
else
  echo "  - URL content fetching (WebFetch only — add Jina Reader API key for better quality)"
fi
[ "$pw_installed" = true ] && echo "  - SPA/dynamic page fetching (Playwright)"
echo ""
echo "  Note: Restart Claude Code (or run /mcp) for new MCP servers to take effect."
echo ""
echo "  To reconfigure later:"
echo "    Tell Claude Code: \"set up scout\" or run: bash $PLUGIN_ROOT/tools/setup.sh"

