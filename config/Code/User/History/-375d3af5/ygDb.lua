===========================================================
-- Neovim Configuration
===========================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Appearance
vim.opt.termguicolors = true

-- General
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

===========================================================
-- Alpha Dashboard
===========================================================

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")

alpha.setup(startify.config)

===========================================================
-- Plugins
===========================================================

vim.pack.add({
    "alpha-nvim",
    "mini.icons",

})


===========================================================
-- Keymaps
===========================================================