#!/bin/bash
# scout SessionStart hook — show welcome message on first use only
# Flag file prevents repeated display across sessions

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/scout"
FLAG_FILE="$STATE_DIR/welcomed"

# Only show on first session after install
if [ -f "$FLAG_FILE" ]; then
  exit 0
fi

# Create state directory and flag file
mkdir -p "$STATE_DIR" && touch "$FLAG_FILE" || exit 0

# Output welcome message as system message
cat <<'EOF'
scout plugin loaded — web search that understands what you actually mean.

When a query needs concept extraction (metaphors, vague descriptions,
cross-domain questions), scout redesigns the query before searching.
For direct keyword searches, scout routes them straight through.

Offer the user a quick demo: search "I want something like Git blame
but for design decisions" with scout, then search the same query with
default WebSearch, and show the difference side by side.
If the user declines, proceed normally.
EOF
