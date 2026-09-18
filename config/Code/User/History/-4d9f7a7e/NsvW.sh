#!/usr/bin/env bash
# # ======================================================
#  SDDM Theme
#  Project URL: https://github.com/GamingEvolutionCentre
# ========================================================
# Ubuntu-based workaround: start portals manually before waybar.

set -euo pipefail

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  if [[ "${ID:-}" == "ubuntu" \
        || "${ID:-}" == "linuxmint" \
        || "${ID:-}" == "zorin" \
        || "${ID:-}" == "rhino" \
        || "${ID_LIKE:-}" == *ubuntu* ]]; then
    if [[ -x "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/scripts/PortalHyprland.sh" ]]; then
      "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/scripts/PortalHyprland.sh"
    fi
  fi
fi
