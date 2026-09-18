#!/usr/bin/env bash

mkdir -p ~/Downloads/neovim-plugin-bundle-builder/plugins
cd ~/Downloads/neovim-plugin-bundle-builder/plugins

echo "Downloading Neovim plugins..."

echo "-> alpha-nvim"
git clone --depth 1 "https://github.com/goolord/alpha-nvim.git" "$PLUGINS/alpha-nvim"
rm -rf "$PLUGINS/alpha-nvim/.git"

echo "-> mini.icons"
git clone --depth 1 "https://github.com/nvim-mini/mini.icons.git" "$PLUGINS/mini.icons"
rm -rf "$PLUGINS/mini.icons/.git"

echo "-> nvim-lspconfig"
git clone --depth 1 "https://github.com/neovim/nvim-lspconfig.git" "$PLUGINS/nvim-lspconfig"
rm -rf "$PLUGINS/nvim-lspconfig/.git"

echo "-> blink.cmp (v1)"
git clone --depth 1 --branch v1 "https://github.com/saghen/blink.cmp.git" "$PLUGINS/blink.cmp"
rm -rf "$PLUGINS/blink.cmp/.git"

echo "-> LuaSnip"
git clone --depth 1 "https://github.com/L3MON4D3/LuaSnip.git" "$PLUGINS/LuaSnip"
rm -rf "$PLUGINS/LuaSnip/.git"

echo "-> conform.nvim"
git clone --depth 1 "https://github.com/stevearc/conform.nvim.git" "$PLUGINS/conform.nvim"
rm -rf "$PLUGINS/conform.nvim/.git"

echo "-> nordic.nvim"
git clone --depth 1 "https://github.com/AlexvZyl/nordic.nvim.git" "$PLUGINS/nordic.nvim"
rm -rf "$PLUGINS/nordic.nvim/.git"

echo "-> synthwave84.nvim"
git clone --depth 1 "https://github.com/LunarVim/synthwave84.nvim.git" "$PLUGINS/synthwave84.nvim"
rm -rf "$PLUGINS/synthwave84.nvim/.git"

echo "-> bufferline.nvim"
git clone --depth 1 "https://github.com/akinsho/bufferline.nvim.git" "$PLUGINS/bufferline.nvim"
rm -rf "$PLUGINS/bufferline.nvim/.git"

echo "-> mini.nvim"
git clone --depth 1 "https://github.com/nvim-mini/mini.nvim.git" "$PLUGINS/mini.nvim"
rm -rf "$PLUGINS/mini.nvim/.git"

echo "-> which-key.nvim"
git clone --depth 1 "https://github.com/folke/which-key.nvim.git" "$PLUGINS/which-key.nvim"
rm -rf "$PLUGINS/which-key.nvim/.git"

echo "-> todo-comments.nvim"
git clone --depth 1 "https://github.com/folke/todo-comments.nvim.git" "$PLUGINS/todo-comments.nvim"
rm -rf "$PLUGINS/todo-comments.nvim/.git"

echo "-> nvim-highlight-colors"
git clone --depth 1 "https://github.com/brenoprata10/nvim-highlight-colors.git" "$PLUGINS/nvim-highlight-colors"
rm -rf "$PLUGINS/nvim-highlight-colors/.git"

echo "-> snacks.nvim"
git clone --depth 1 "https://github.com/folke/snacks.nvim.git" "$PLUGINS/snacks.nvim"
rm -rf "$PLUGINS/snacks.nvim/.git"

echo "-> oil.nvim"
git clone --depth 1 "https://github.com/stevearc/oil.nvim.git" "$PLUGINS/oil.nvim"
rm -rf "$PLUGINS/oil.nvim/.git"

echo "-> aerial.nvim"
git clone --depth 1 "https://github.com/stevearc/aerial.nvim.git" "$PLUGINS/aerial.nvim"
rm -rf "$PLUGINS/aerial.nvim/.git"

echo "-> trouble.nvim"
git clone --depth 1 "https://github.com/folke/trouble.nvim.git" "$PLUGINS/trouble.nvim"
rm -rf "$PLUGINS/trouble.nvim/.git"

echo "-> nvim-treesitter"
git clone --depth 1 "https://github.com/nvim-treesitter/nvim-treesitter.git" "$PLUGINS/nvim-treesitter"
rm -rf "$PLUGINS/nvim-treesitter/.git"

echo "-> guess-indent.nvim"
git clone --depth 1 "https://github.com/NMAC427/guess-indent.nvim.git" "$PLUGINS/guess-indent.nvim"
rm -rf "$PLUGINS/guess-indent.nvim/.git"

echo "-> vim-visual-multi"
git clone --depth 1 "https://github.com/mg979/vim-visual-multi.git" "$PLUGINS/vim-visual-multi"
rm -rf "$PLUGINS/vim-visual-multi/.git"

echo "-> undotree"
git clone --depth 1 "https://github.com/mbbill/undotree.git" "$PLUGINS/undotree"
rm -rf "$PLUGINS/undotree/.git"

echo "-> Comment.nvim"
git clone --depth 1 "https://github.com/numToStr/Comment.nvim.git" "$PLUGINS/Comment.nvim"
rm -rf "$PLUGINS/Comment.nvim/.git"

echo "-> toggleterm.nvim"
git clone --depth 1 "https://github.com/akinsho/toggleterm.nvim.git" "$PLUGINS/toggleterm.nvim"
rm -rf "$PLUGINS/toggleterm.nvim/.git"

echo "-> auto-save.nvim"
git clone --depth 1 "https://github.com/Pocco81/auto-save.nvim.git" "$PLUGINS/auto-save.nvim"
rm -rf "$PLUGINS/auto-save.nvim/.git"

echo "-> suda.vim"
git clone --depth 1 "https://github.com/lambdalisue/suda.vim.git" "$PLUGINS/suda.vim"
rm -rf "$PLUGINS/suda.vim/.git"

echo "-> copilot.lua"
git clone --depth 1 "https://github.com/zbirenbaum/copilot.lua.git" "$PLUGINS/copilot.lua"
rm -rf "$PLUGINS/copilot.lua/.git"

echo "-> CopilotChat.nvim"
git clone --depth 1 "https://github.com/CopilotC-Nvim/CopilotChat.nvim.git" "$PLUGINS/CopilotChat.nvim"
rm -rf "$PLUGINS/CopilotChat.nvim/.git"

echo "-> img-clip.nvim"
git clone --depth 1 "https://github.com/HakonHarnes/img-clip.nvim.git" "$PLUGINS/img-clip.nvim"
rm -rf "$PLUGINS/img-clip.nvim/.git"
