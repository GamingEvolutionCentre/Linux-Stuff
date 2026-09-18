-- ============================================================================
-- Neovim Configuration
-- ============================================================================

-- ============================================================================
-- Plugins
-- ============================================================================

-- Local plugin directory used by Neovim
local plugin_root = vim.fn.stdpath("config") .. "/plugins"

-- Your GitHub repository
local plugin_repo = "https://github.com/GamingEvolutionCentre/Linux-Stuff.git"

-- The plugins are stored inside this folder in the GitHub repository
local github_plugin_path = "neovim/plugins"

-- Local cached copy of your Linux-Stuff Git repository.
-- This is separate from ~/.config/nvim/plugins so Neovim only loads
-- the actual plugin folders.
local repo_cache = vim.fn.stdpath("data") .. "/GamingEvolutionCentre-Linux-Stuff"

local repo_plugins = repo_cache .. "/" .. github_plugin_path


-- ============================================================================
-- Helper: Run command
-- ============================================================================

local function run(command)
    local result = vim.system(command, {
        text = true,
    }):wait()

    return
        result.code == 0,
        vim.trim(result.stdout or ""),
        vim.trim(result.stderr or "")
end


-- ============================================================================
-- Helper: Copy updated plugins
-- ============================================================================

local function install_plugins()

    if vim.fn.isdirectory(repo_plugins) == 0 then
        vim.notify(
            "GitHub plugin directory was not found:\n" .. repo_plugins,
            vim.log.levels.ERROR
        )

        return false
    end

    local new_plugins = plugin_root .. ".new"
    local old_plugins = plugin_root .. ".old"

    -- Clean old temporary directories
    vim.fn.delete(new_plugins, "rf")
    vim.fn.delete(old_plugins, "rf")

    -- Create staging directory
    vim.fn.mkdir(new_plugins, "p")

    -- Copy the plugins from the GitHub repository cache
    local copy_ok, _, copy_error = run({
        "cp",
        "-a",
        repo_plugins .. "/.",
        new_plugins .. "/",
    })

    if not copy_ok then
        vim.fn.delete(new_plugins, "rf")

        vim.notify(
            "Failed to copy plugin update:\n" .. copy_error,
            vim.log.levels.ERROR
        )

        return false
    end

    -- Keep the current plugins as a temporary backup
    if vim.fn.isdirectory(plugin_root) == 1 then

        if vim.fn.rename(plugin_root, old_plugins) ~= 0 then
            vim.fn.delete(new_plugins, "rf")

            vim.notify(
                "Failed to replace the current plugin directory.",
                vim.log.levels.ERROR
            )

            return false
        end
    end

    -- Put the new plugins into place
    if vim.fn.rename(new_plugins, plugin_root) ~= 0 then

        -- Restore the old plugins if something went wrong
        if vim.fn.isdirectory(old_plugins) == 1 then
            vim.fn.rename(old_plugins, plugin_root)
        end

        vim.fn.delete(new_plugins, "rf")

        vim.notify(
            "Failed to install the new plugins.",
            vim.log.levels.ERROR
        )

        return false
    end

    -- Update succeeded, remove the backup
    vim.fn.delete(old_plugins, "rf")

    return true
end


-- ============================================================================
-- Download repository for the first time
-- ============================================================================

if vim.fn.isdirectory(repo_cache .. "/.git") == 0 then

    vim.notify(
        "Downloading Neovim plugins from GamingEvolutionCentre/Linux-Stuff..."
    )

    vim.fn.mkdir(vim.fn.stdpath("data"), "p")

    -- Clone using sparse checkout so we do not need the entire repository
    local clone_ok, _, clone_error = run({
        "git",
        "clone",
        "--filter=blob:none",
        "--sparse",
        plugin_repo,
        repo_cache,
    })

    if clone_ok then

        local sparse_ok, _, sparse_error = run({
            "git",
            "-C",
            repo_cache,
            "sparse-checkout",
            "set",
            github_plugin_path,
        })

        if sparse_ok then

            if install_plugins() then
                vim.notify(
                    "Neovim plugins installed from GitHub."
                )
            end

        else

            vim.notify(
                "Failed to configure plugin download:\n" .. sparse_error,
                vim.log.levels.ERROR
            )
        end

    else

        vim.notify(
            "Failed to clone Linux-Stuff:\n" .. clone_error,
            vim.log.levels.ERROR
        )
    end


-- ============================================================================
-- Check GitHub for plugin updates
-- ============================================================================

else

    -- Make sure sparse checkout is still set to the plugin directory
    run({
        "git",
        "-C",
        repo_cache,
        "sparse-checkout",
        "set",
        github_plugin_path,
    })

    -- Check GitHub for new commits
    local fetch_ok, _, fetch_error = run({
        "git",
        "-C",
        repo_cache,
        "fetch",
        "--quiet",
        "origin",
    })

    if fetch_ok then

        -- Find the repository's default GitHub branch
        local branch_ok, remote_branch = run({
            "git",
            "-C",
            repo_cache,
            "symbolic-ref",
            "--quiet",
            "--short",
            "refs/remotes/origin/HEAD",
        })

        -- Fall back to main if Git cannot determine it
        if not branch_ok or remote_branch == "" then
            remote_branch = "origin/main"
        end

        -- Get the Git tree hash for the CURRENT plugin directory
        local local_ok, local_plugin_version = run({
            "git",
            "-C",
            repo_cache,
            "rev-parse",
            "HEAD:" .. github_plugin_path,
        })

        -- Get the Git tree hash for the GitHub plugin directory
        local remote_ok, remote_plugin_version = run({
            "git",
            "-C",
            repo_cache,
            "rev-parse",
            remote_branch .. ":" .. github_plugin_path,
        })

        if local_ok and remote_ok then

            -- Only update if neovim/plugins itself changed
            if local_plugin_version ~= remote_plugin_version then

                vim.notify(
                    "Neovim plugin update found. Updating..."
                )

                -- Update cached repository to GitHub version
                local update_ok, _, update_error = run({
                    "git",
                    "-C",
                    repo_cache,
                    "reset",
                    "--hard",
                    remote_branch,
                })

                if update_ok then

                    if install_plugins() then

                        vim.notify(
                            "Neovim plugins updated successfully."
                        )

                    end

                else

                    vim.notify(
                        "Plugin update failed:\n" .. update_error,
                        vim.log.levels.ERROR
                    )
                end

            elseif vim.fn.isdirectory(plugin_root) == 0 then

                -- Git cache exists but ~/.config/nvim/plugins does not.
                -- Reinstall it.
                install_plugins()

            end

            -- IMPORTANT:
            -- If there is NO update, nothing happens here.
            -- Neovim simply continues loading.

        end

    else

        -- If GitHub cannot be reached, keep using the existing plugins.
        -- Do not prevent Neovim from starting.
        vim.notify(
            "Could not check GitHub for plugin updates.\nUsing local plugins.",
            vim.log.levels.WARN
        )
    end
end


-- ============================================================================
-- Load plugins
-- ============================================================================

-- Add every folder inside ~/.config/nvim/plugins/
-- to Neovim's runtimepath.

if vim.fn.isdirectory(plugin_root) == 1 then

    for name, type in vim.fs.dir(plugin_root) do

        if type == "directory" and name:sub(1, 1) ~= "." then

            vim.opt.runtimepath:prepend(
                plugin_root .. "/" .. name
            )

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
local startify_ok, startify = pcall(require, "alpha.themes.startify")

if alpha_ok and startify_ok then
    alpha.setup(startify.config)
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