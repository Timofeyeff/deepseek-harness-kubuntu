#!/usr/bin/env bash
# Синхронизация форка deepseek-harness-kubuntu с апстримом deepseek-ai/deepseek-harness.
# Быстрый ff; если у форка есть свои коммиты — merge-коммит «sync: ...».
set -uo pipefail
cd "$(dirname "$0")"
BR=$(git branch --show-current)
git fetch upstream --tags || { echo "fetch upstream не удался (сеть?)"; exit 1; }
UP=$(git rev-parse --verify -q upstream/master || git rev-parse upstream/main)
BEHIND=$(git rev-list --count "$BR".."$UP")
if [ "$BEHIND" -eq 0 ]; then echo "апстрим не уходил вперёд — ничего делать не нужно"; exit 0; fi
echo "апстрим вперёд на $BEHIND коммитов"
if ! git merge --ff-only "$UP"; then
  git merge -m "sync: upstream $(git rev-parse --short "$UP")" "$UP" || { echo "КОНФЛИКТ — разрешить вручную"; exit 2; }
fi
git push origin "$BR" --tags && echo "СИНХРОНИЗИРОВАНО: $(git log --oneline -1)"
