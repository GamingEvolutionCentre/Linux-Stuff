#!/usr/bin/env bash

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Plugins folder will be created beside this script
PLUGINS="$SCRIPT_DIR/plugins"

mkdir -p "$PLUGINS"

# Move into the plugins directory
cd "$PLUGINS" || exit 1

echo "Downloading Neovim plugins..."
echo "Plugins directory: $PLUGINS"
echo

download_plugin() {
    NAME="$1"
    URL="$2"
    BRANCH="${3:-}"

    echo "-> $NAME"

    # Don't try to clone it again if it already exists
    if [[ -d "$NAME" ]]; then
        echo "   $NAME already exists - skipping."
        echo
        return
    fi

    if [[ -n "$BRANCH" ]]; then
        git clone --depth 1 --branch "$BRANCH" "$URL" "$NAME"
    else
        git clone --depth 1 "$URL" "$NAME"
    fi

    # Remove Git history so only the actual plugin files remain
    rm -rf "$NAME/.git"

    echo "   Done."
    echo
}

download_plugin \
    "alpha-nvim" \
    "https://github.com/goolord/alpha-nvim.git"

download_plugin \
    "mini.icons" \
    "https://github.com/nvim-mini/mini.icons.git"

download_plugin \
    "nvim-lspconfig" \
    "https://github.com/neovim/nvim-lspconfig.git"

download_plugin \
    "blink.cmp" \
    "https://github.com/saghen/blink.cmp.git" \
    "v1"

download_plugin \
    "LuaSnip" \
    "https://github.com/L3MON4D3/LuaSnip.git"

download_plugin \
    "conform.nvim" \
    "https://github.com/stevearc/conform.nvim.git"

download_plugin \
    "nordic.nvim" \
    "https://github.com/AlexvZyl/nordic.nvim.git"

download_plugin \
    "synthwave84.nvim" \
    "https://github.com/LunarVim/synthwave84.nvim.git"

download_plugin \
    "bufferline.nvim" \
    "https://github.com/akinsho/bufferline.nvim.git"

download_plugin \
    "mini.nvim" \
    "https://github.com/nvim-mini/mini.nvim.git"

download_plugin \
    "which-key.nvim" \
    "https://github.com/folke/which-key.nvim.git"

download_plugin \
    "todo-comments.nvim" \
    "https://github.com/folke/todo-comments.nvim.git"

download_plugin \
    "nvim-highlight-colors" \
    "https://github.com/brenoprata10/nvim-highlight-colors.git"

download_plugin \
    "snacks.nvim" \
    "https://github.com/folke/snacks.nvim.git"

download_plugin \
    "oil.nvim" \
    "https://github.com/stevearc/oil.nvim.git"

download_plugin \
    "aerial.nvim" \
    "https://github.com/stevearc/aerial.nvim.git"

download_plugin \
    "trouble.nvim" \
    "https://github.com/folke/trouble.nvim.git"

download_plugin \
    "nvim-treesitter" \
    "https://github.com/nvim-treesitter/nvim-treesitter.git"

download_plugin \
    "guess-indent.nvim" \
    "https://github.com/NMAC427/guess-indent.nvim.git"

download_plugin \
    "vim-visual-multi" \
    "https://github.com/mg979/vim-visual-multi.git"

download_plugin \
    "undotree" \
    "https://github.com/mbbill/undotree.git"

download_plugin \
    "Comment.nvim" \
    "https://github.com/numToStr/Comment.nvim.git"

download_plugin \
    "toggleterm.nvim" \
    "https://github.com/akinsho/toggleterm.nvim.git"

download_plugin \
    "auto-save.nvim" \
    "https://github.com/Pocco81/auto-save.nvim.git"

download_plugin \
    "suda.vim" \
    "https://github.com/lambdalisue/suda.vim.git"

download_plugin \
    "copilot.lua" \
    "https://github.com/zbirenbaum/copilot.lua.git"

download_plugin \
    "CopilotChat.nvim" \
    "https://github.com/CopilotC-Nvim/CopilotChat.nvim.git"

download_plugin \
    "img-clip.nvim" \
    "https://github.com/HakonHarnes/img-clip.nvim.git"

echo
echo "========================================"
echo "All Neovim plugins downloaded."
echo "========================================"
echo
echo "Location:"
echo "$PLUGINS"