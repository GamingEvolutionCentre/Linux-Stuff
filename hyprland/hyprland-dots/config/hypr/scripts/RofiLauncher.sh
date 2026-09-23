#!/usr/bin/env bash
# # ======================================================
#  SDDM Theme
#  Project URL: https://github.com/GamingEvolutionCentre
# ========================================================
# Rofi application launcher toggle script

if pidof rofi >/dev/null 2>&1; then
  pkill -x rofi 2>/dev/null || pkill rofi 2>/dev/null || true
  exit 0
fi

SCRIPTSDIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/scripts"
if [ -x "$SCRIPTSDIR/RofiFocusedWallpaperLink.sh" ]; then
  "$SCRIPTSDIR/RofiFocusedWallpaperLink.sh" >/dev/null 2>&1 || true
fi

exec rofi -show drun -modi drun,filebrowser,run,window -config "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/rofi/config.rasi"
