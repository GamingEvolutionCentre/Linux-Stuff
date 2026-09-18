-- ============================================================================
-- Neovim Configuration
-- ============================================================================

-- ============================================================================
-- Plugins
-- ============================================================================

-- All plugins are stored locally in:
-- ~/.config/nvim/plugins/
--
-- Each plugin should have its own folder, for example:
--
-- ~/.config/nvim/plugins/
-- ├── alpha-nvim/
-- ├── mini.icons/
-- ├── nvim-lspconfig/
-- ├── blink.cmp/
-- ├── LuaSnip/
-- ├── conform.nvim/
-- └── etc...
--
-- Neovim will automatically add every folder inside plugins/ to runtimepath.

local plugin_root = vim.fn.stdpath("config") .. "/plugins"

-- Make sure the plugins directory exists
vim.fn.mkdir(plugin_root, "p")

-- Add every plugin directory to Neovim's runtimepath
if vim.fn.isdirectory(plugin_root) == 1 then
    for name, type in vim.fs.dir(plugin_root) do
        if type == "directory" and name:sub(1, 1) ~= "." then
            vim.opt.runtimepath:prepend(plugin_root .. "/" .. name)
        end
    end
end


-- ============================================================================
-- Options
-- ============================================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- General
vim.opt.mouse = "a"

-- Clipboard
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)


-- ============================================================================
-- Fonts
-- ============================================================================

if vim.g.neovide then
    local neovide_font_size = 12

    local font_candidates = {
        "MesloLGS NF",
        "JetBrainsMono Nerd Font",
        "JetBrainsMonoNL Nerd Font",
        "FiraCode Nerd Font",
        "Hack Nerd Font",
        "Noto Sans Mono",
        "Monospace",
    }

    local selected_font = font_candidates[#font_candidates]

    if vim.fn.executable("fc-list") == 1 then
        local out = vim.fn.system({ "fc-list", ":", "family" })

        for _, font_name in ipairs(font_candidates) do
            if out:find(font_name, 1, true) then
                selected_font = font_name
                break
            end
        end
    else
        selected_font = font_candidates[1]
    end

    vim.o.guifont = string.format("%s:h%d", selected_font, neovide_font_size)
end


-- ============================================================================
-- Autocommands
-- ============================================================================

local highlight_group =
    vim.api.nvim_create_augroup("highlight-yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = highlight_group,

    callback = function()
        vim.hl.on_yank()
    end,
})


-- ============================================================================
-- Alpha Dashboard
-- ============================================================================

local alpha_ok, alpha = pcall(require, "alpha")

if alpha_ok then
    local startify_ok, startify = pcall(require, "alpha.themes.startify")

    if startify_ok then
        alpha.setup(startify.config)
    end
end


-- ============================================================================
-- Mini Icons
-- ============================================================================

local mini_icons_ok, mini_icons = pcall(require, "mini.icons")

if mini_icons_ok then
    mini_icons.setup()
end


-- ============================================================================
-- Keymaps
-- ============================================================================

-- All keybindings are stored in:
-- ~/.config/nvim/keymaps.lua

require("keymaps")


-- ============================================================================
-- Plugin Update Command
-- ============================================================================

-- If ~/.config/nvim/plugins itself is a Git repository,
-- :PluginsUpdate will pull the latest version from YOUR GitHub repository.

vim.api.nvim_create_user_command("PluginsUpdate", function()

    local git_directory = plugin_root .. "/.git"

    if vim.fn.isdirectory(git_directory) == 0 then
        vim.notify(
            plugin_root .. " is not a Git repository",
            vim.log.levels.ERROR
        )

        return
    end

    vim.notify("Updating Neovim plugins from GitHub...")

    local output = vim.fn.system({
        "git",
        "-C",
        plugin_root,
        "pull",
        "--ff-only",
    })

    if vim.v.shell_error == 0 then
        vim.notify(
            "Plugins updated successfully.\nRestart Neovim to load the updates.",
            vim.log.levels.INFO
        )
    else
        vim.notify(
            "Plugin update failed:\n" .. output,
            vim.log.levels.ERROR
        )
    end
end, {
    desc = "Update plugins from your GitHub repository",
})