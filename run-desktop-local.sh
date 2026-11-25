#!/bin/sh
# DeepSeek Harness Desktop (dev launch on Linux) with local models from ~/.dsh/profiles/desktop/cordis.patch.yml.
# First run: ./run-desktop-local.sh --build   (pnpm run dev:desktop = build + launch)
# Later:     ./run-desktop-local.sh           (pnpm run start:desktop = launch the built artifacts)
cd "$(dirname "$0")" || exit 1
unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
export PATH="$HOME/.local/share/pnpm/bin:$PATH"       # Node 24 (pnpm env use --global 24)
export DSH_HOME="${DSH_HOME:-$HOME/.dsh}"             # shared with `dsh web`, instead of the disposable dev home
export LOCAL_LLM_API_KEY="${LOCAL_LLM_API_KEY:-local}"     # placeholder key for the local OpenAI-compatible servers
if [ "$1" = "--build" ]; then
  shift
  exec pnpm run dev:desktop "$@"
fi
exec pnpm run start:desktop "$@"
