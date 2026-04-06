#!/bin/bash
# scout SessionStart hook — setup guidance and welcome
# Checks setup state and injects appropriate context for Claude

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/scout"
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
scout plugin is installed and basic search works now.

Tell the user scout is ready. Mention that connecting additional search sources expands coverage and improves fetch quality — and offer to walk them through it. It takes a few minutes and every step is optional.

If the user agrees, follow the scout:setup skill workflow.
If the user declines, do not bring it up again this session. Proceed with their request.
EOF
