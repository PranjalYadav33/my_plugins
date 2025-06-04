-- C:\Users\ankit\AppData\Local\nvim\init.lua

--------------------------------------------------------------------------------
-- LAZY.NVIM BOOTSTRAPPING (Plugin Manager Setup)
-- This section MUST come first to ensure lazy.nvim is installed and available.
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Use the latest stable release of lazy.nvim
    lazypath,
  })
  print("lazy.nvim cloned successfully.")
end
vim.opt.rtp:prepend(lazypath)
print("lazy.nvim path added to runtime.")

--------------------------------------------------------------------------------
-- GLOBAL SETTINGS & OPTIONS
-- It's good practice to set these before loading plugins that might use them.
--------------------------------------------------------------------------------

-- Set leader key
-- The leader key is a prefix for many custom shortcuts. Space is a common choice.
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- Or use "\\" for a different local leader if preferred

-- Essential Neovim options
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show line numbers relative to the cursor
vim.opt.mouse = "a"           -- Enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste (requires +clipboard support)
                               -- On Windows, 'unnamedplus' usually works well.
                               -- On Linux with X11, you might need `xclip` or `xsel` installed.

-- Search behavior
vim.opt.ignorecase = true     -- Ignore case when searching
vim.opt.smartcase = true      -- If search pattern contains uppercase, become case-sensitive
vim.opt.hlsearch = true       -- Highlight all search matches
vim.opt.incsearch = true      -- Show matches incrementally as you type

-- Indentation
vim.opt.tabstop = 4           -- Number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4       -- Number of spaces that <Tab> key in insert mode will move cursor
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.autoindent = true     -- Copy indent from current line when starting a new line
vim.opt.smartindent = true    -- Smart autoindenting for C-like programs

-- UI & Behavior
vim.opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.sidescrolloff = 8     -- Keep 8 columns visible left/right of cursor when scrolling
vim.opt.wrap = false          -- Disable line wrapping (true to enable)
vim.opt.termguicolors = true  -- Enable 24-bit RGB color in the TUI
vim.opt.signcolumn = "yes"    -- Always show the sign column, otherwise it would shift text
vim.opt.updatetime = 250      -- Faster update time for CursorHold events (e.g., for LSP hover)
vim.opt.timeoutlen = 300      -- Time in ms to wait for a mapped sequence to complete
vim.opt.splitright = true     -- New vertical splits to the right
vim.opt.splitbelow = true     -- New horizontal splits below
vim.opt.showmode = false      -- Don't show "-- INSERT --" in the command line

-- File handling
vim.opt.undofile = true       -- Enable persistent undo (requires nvim-data directory)
vim.opt.backup = false        -- Do not create backup files
vim.opt.writebackup = false   -- If a backup is made, don't keep it after successful write
vim.opt.swapfile = false      -- Do not create swap files

--------------------------------------------------------------------------------
-- LOAD PLUGIN CONFIGURATION (via lazy.nvim)
-- Now that lazy.nvim is bootstrapped and basic options are set,
-- we load the lazy.nvim setup which in turn loads all other plugins.
--------------------------------------------------------------------------------
-- This line assumes you have a file at:
-- C:\Users\ankit\AppData\Local\nvim\lua\config\lazy.lua
-- That file will contain the `require("lazy").setup({...})` call.
require("config.lazy")

--------------------------------------------------------------------------------
-- OPTIONAL: Custom Keymaps (if not handled by plugins)
-- You can define your own keymaps here or require a separate keymaps file.
-- Example:
-- vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = "Save file" })
-- vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = "Quit" })
--------------------------------------------------------------------------------
-- For a more organized setup, you might create a lua/core/keymaps.lua file
-- and then `require("core.keymaps")` here.

-- Confirmation message (optional, good for debugging)
print("Neovim configuration (init.lua) loaded successfully!")