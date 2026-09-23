#!/usr/bin/env bash
# # ======================================================
#  SDDM Theme
#  Project URL: https://github.com/GamingEvolutionCentre
# ========================================================
# Legacy startup hook for layout keybind initialization.
# Runtime keybind behavior is now resolved per keypress based on active workspace layout.

set -euo pipefail

scripts_dir="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/scripts"

# Keep compatibility with existing startup entries while avoiding global rebinding.
if [[ -x "${scripts_dir}/ChangeLayout.sh" ]]; then
  "${scripts_dir}/ChangeLayout.sh" --quiet init >/dev/null 2>&1 || true
fi
