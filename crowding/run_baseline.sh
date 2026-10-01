#!/usr/bin/env bash
# Crowding baseline (RESEARCH_PROTOCOL.md §6.6): what off-the-shelf models tell an ordinary user.
# Runs each prompt through each CLI from an empty temp dir so no repo context, memory or CLAUDE.md leaks in.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date -u +%Y%m%dT%H%MZ)"
OUT="$HERE/runs/$STAMP"; mkdir -p "$OUT"
WORK="$(mktemp -d)"; cd "$WORK"
# Codex keeps memories/hooks in its home; point it at a clean home holding only auth.json.
: "${CLEAN_CODEX_HOME:?set CLEAN_CODEX_HOME to a dir containing only auth.json}"
i=0
while IFS= read -r p; do
  i=$((i+1))
  for m in sonnet opus; do
    ( timeout 600 claude -p --model "$m" "$p" < /dev/null > "$OUT/claude_${m}_p$i.md" 2>&1 ) &
  done
  ( CODEX_HOME="$CLEAN_CODEX_HOME" timeout 900 codex exec --skip-git-repo-check "$p" < /dev/null > "$OUT/codex_p$i.md" 2>&1 ) &
  wait
done < "$HERE/prompts.txt"
echo "$OUT"
