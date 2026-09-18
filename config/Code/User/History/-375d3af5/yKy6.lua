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
-- Fonts
===========================================================

if vim.g.neovide then
  local neovide_font_size = 12
  local font_candidates = {
    'MesloLGS NF',
    'JetBrainsMono Nerd Font',
    'JetBrainsMonoNL Nerd Font',
    'FiraCode Nerd Font',
    'Hack Nerd Font',
    'Noto Sans Mono',
    'Monospace',
  }

  local selected_font = font_candidates[#font_candidates]
  if vim.fn.executable 'fc-list' == 1 then
    local out = vim.fn.system({ 'fc-list', ':', 'family' })
    for _, font_name in ipairs(font_candidates) do
      if out:find(font_name, 1, true) then
        selected_font = font_name
        break
      end
    end
  else
    selected_font = font_candidates[1]
  end

  vim.o.guifont = string.format('%s:h%d', selected_font, neovide_font_size)
end

===========================================================
-- Alpha Dashboard
===========================================================

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")

alpha.setup(startify.config)

===========================================================
-- Plugins
===========================================================
-- Plugin files live in plugin/ and are sourced automatically by Neovim.
-- Run :lua vim.pack.update() to update all plugins.

vim.pack.add({
    "alpha-nvim",
    "mini.icons",

})


===========================================================
-- Keymaps
===========================================================
-- All keymaps live in lua/keymaps.lua (loaded after plugins below)

require 'keymaps'