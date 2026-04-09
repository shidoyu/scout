#!/bin/bash
# scout hook — setup guidance and welcome
# Fires on SessionStart (context injection) and UserPromptSubmit (reinforcement)
# SessionStart injects context; LLM uses it when user sends first message

STATE_DIR="${CLAUDE_PLUGIN_DATA:-${XDG_STATE_HOME:-$HOME/.local/state}/scout}"
SETUP_STATUS="$STATE_DIR/setup-status.json"
DEMO_DONE="$STATE_DIR/demo-done"
SETUP_OFFERED="$STATE_DIR/setup-offered"

# State 3: Both setup and demo done → silent
if [ -f "$SETUP_STATUS" ] && [ -f "$DEMO_DONE" ]; then
  exit 0
fi

# State 2: Setup done, demo not done → propose demo (once)
if [ -f "$SETUP_STATUS" ]; then
  if [ -f "$DEMO_DONE" ]; then
    exit 0
  fi
  mkdir -p "$STATE_DIR" && touch "$DEMO_DONE" || exit 0
  cat <<'EOF'
scout is fully configured.

Propose a short demo search to show what scout can do. Suggest one of these:
- "I want something like Git blame but for design decisions"
- "What should I actually migrate to from Terraform — not the sponsored lists"

Or ask if the user has something they want to search. If they decline, move on to their request.
EOF
  exit 0
fi

# State 1: Setup not done → guide toward setup
# Re-offer after 7 days if previously offered and declined
if [ -f "$SETUP_OFFERED" ]; then
  if [ "$(find "$SETUP_OFFERED" -mtime -7 2>/dev/null)" ]; then
    exit 0
  fi
fi

mkdir -p "$STATE_DIR" && touch "$SETUP_OFFERED" || { echo "scout: cannot write state" >&2; exit 0; }

cat <<'EOF'
scout plugin is installed and ready to use.

Briefly tell the user scout is ready, then ask if they'd like to connect a couple of optional search tools — it takes a few minutes and every step is skippable. Keep it to one short sentence; do not list the tools or describe their benefits yet.

If the user agrees, run /scout:setup.
If the user declines, proceed with their request. Do not mention setup again this session.
EOF
