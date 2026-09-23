#!/usr/bin/env bash
# # ======================================================
#  SDDM Theme
#  Project URL: https://github.com/GamingEvolutionCentre
# ========================================================
# Helper for Lua-config sessions where legacy `hyprctl dispatch fullscreen 1`
# is parsed as Lua and fails.

setsid -f sh -c 'sleep 0.2; hyprctl dispatch "hl.dsp.window.fullscreen({ mode = 1 })"' >/dev/null 2>&1
