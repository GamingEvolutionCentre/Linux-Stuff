#!/usr/bin/env bash

## SDDM Themes Installer
## Based on original by GamingEvolutionCentre https://github.com/GamingEvolutionCentre/SDDM-themes
## Copyright (C) 2019-2026, Gaming Evolution Centre

# Script works in Arch, Debian.

set -euo pipefail

readonly THEME_REPO="https://github.com/GamingEvolutionCentre/SDDM-Themes.git"
readonly THEME_NAME="SDDM-Themes"
readonly THEMES_DIR="/usr/share/sddm/themes"
readonly PATH_TO_GIT_CLONE="$HOME/$THEME_NAME"
readonly DATE=$(date +%s)

readonly -a THEMES=(
    "cyberpunk" "hacker" "leaves"
)

# Logging with gum fallback
info() {
    if command -v gum &>/dev/null; then
        gum style --foreground 10 "✅ $*"
    else
        echo -e "\e[32m✅ $*\e[0m"
    fi
}

warn() {
    if command -v gum &>/dev/null; then
        gum style --foreground 11 "⚠  $*"
    else
        echo -e "\e[33m⚠  $*\e[0m"
    fi
}

error() {
    if command -v gum &>/dev/null; then
        gum style --foreground 9 "❌ $*" >&2
    else
        echo -e "\e[31m❌ $*\e[0m" >&2
    fi
}

# UI functions
confirm() {
    if command -v gum &>/dev/null; then
        gum confirm "$1"
    else
        echo -n "$1 (y/n): "; read -r r; [[ "$r" =~ ^[Yy]$ ]]
    fi
}

choose() {
    if command -v gum &>/dev/null; then
        gum choose --cursor.foreground 12 --header="" --header.foreground 12 "$@"
    else
        select opt in "$@"; do [[ -n "$opt" ]] && { echo "$opt"; break; }; done
    fi
}

spin() {
    local title="$1"; shift
    if command -v gum &>/dev/null; then
        gum spin --spinner="dot" --title="$title" -- "$@"
    else
        echo "$title"; "$@"
    fi
}

# Install gum if missing
install_gum() {
    local mgr=$(for m in pacman apt; do command -v $m &>/dev/null && { echo $m; break; }; done)

    case $mgr in
        pacman) sudo pacman -S gum ;;
        # refrence https://github.com/basecamp/omakub/issues/222
        apt)
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
            echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
            sudo apt update && sudo apt install -y gum ;;
        *) error "Cannot install gum automatically"; return 1 ;;
    esac
}

# Check and install gum
check_gum() {
    if ! command -v gum &>/dev/null; then
        warn "Gum was not found - provides better UI experience"
        if confirm "Install gum?"; then
            install_gum && { info "Restarting with gum..."; main; } || warn "Using fallback UI"
        fi
    fi
}

# Install dependencies
install_deps() {
    local mgr=$(for m in pacman apt; do command -v $m &>/dev/null && { echo $m; break; }; done)
    info "Package manager: $mgr"

    case $mgr in
        pacman) sudo pacman --needed -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg ;;
        apt) sudo apt update && sudo apt install -y sddm qt6-svg-dev qml6-module-qtquick-virtualkeyboard qt6-multimedia-dev ;;
        *) error "Unsupported package manager"; return 1 ;;
    esac
    info "Dependencies installed"
}

# Clone repository
clone_repo() {
    [[ -d "$PATH_TO_GIT_CLONE" ]] && mv "$PATH_TO_GIT_CLONE" "${PATH_TO_GIT_CLONE}_$DATE"
    spin "Cloning repository..." git clone -b master --depth 1 "$THEME_REPO" "$PATH_TO_GIT_CLONE"
    info "Repository cloned to $PATH_TO_GIT_CLONE"
}

# Install theme
install_theme() {
    local src="$HOME/$THEME_NAME"
    local dst="$THEMES_DIR/$THEME_NAME"

    [[ ! -d "$src" ]] && { error "Clone repository first"; return 1;}

    # Backup and copy
    [[ -d "$dst" ]] && sudo mv "$dst" "${dst}_$DATE"
    sudo mkdir -p "$dst"
    spin "Installing theme files..." sudo cp -r "$src"/* "$dst"/

    # Install fonts
    [[ -d "$dst/Fonts" ]] && spin "Installing fonts..." sudo cp -r "$dst/Fonts"/* /usr/share/fonts/

    # Configure SDDM
    echo "[Theme]
    Current=$THEME_NAME" | sudo tee /etc/sddm.conf >/dev/null

    sudo mkdir -p /etc/sddm.conf.d
    echo "[General]
    InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf >/dev/null

    info "Theme installed"
}

# Select theme variant
select_theme() {
    [[ ! -f "$METADATA" ]] && { error "Install theme first"; return 1; }
    
    local theme=$(choose "${THEMES[@]}" || echo "cyberpunk")
    sudo sed -i "s|^ConfigFile=.*|ConfigFile=Themes/${theme}.conf|" "$METADATA"
    info "Selected theme: $theme"
}

# Enable SDDM
enable_sddm() {
    command -v systemctl &>/dev/null || { error "systemctl not found"; return 1; }

    sudo systemctl disable display-manager.service 2>/dev/null || true
    sudo systemctl enable sddm.service
    info "SDDM enabled"
    warn "Reboot required"
}


# Main menu
main() {
    [[ $EUID -eq 0 ]] && { error "Don't run as root"; exit 1; }
    command -v git &>/dev/null || { error "git required"; exit 1; }

    check_gum
    clear
    while true; do
        if command -v gum &>/dev/null; then
            gum style --bold --padding "0 2" --border double --border-foreground 12 "🚀 SDDM Themes Installer"
        else
            echo -e "\e[36m🚀 SDDM Themes Installer\e[0m"
        fi

        local choice=$(choose \
            "Complete Installation (recommended)" \
            "Install Dependencies" \
            "Clone Repository" \
            "Install Theme" \
            "Enable SDDM Service" \
            "Select Theme Variant" \
            "Exit")

        case "$choice" in
            "Complete Installation (recommended)") install_deps && clone_repo && install_theme && select_theme && enable_sddm && info "Everything done!" && exit 0;;
            "Install Dependencies") install_deps ;;
            "Clone Repository") clone_repo ;;
            "Install Theme") install_theme ;;
            "Enable SDDM Service") enable_sddm ;;
            "Select Theme Variant") select_theme ;;
            "Preview the set theme") preview_theme;;
            "Exit") info "Thank You Bye!"; exit 0 ;;
        esac

        echo; if command -v gum &>/dev/null; then
            gum input --placeholder="Press Enter to continue..."
        else
            echo -n "Press Enter to continue..."; read -r
        fi
    done
}

# trap 'echo; info "Cancelled"; exit 130' INT TERM
main "$@"
