vim.g.mapleader = " "      -- Sets the main leader key to <Space>
vim.g.maplocalleader = " " -- Sets the local leader key to <Space> (applies to filetypes)

local opt = vim.opt        -- Aliases 'vim.opt' to 'opt' to save typing later

-- Indentation
opt.expandtab = true -- Replaces Tab keystrokes with spaces
opt.tabstop = 4      -- An existing Tab character appears as 4 spaces wide
opt.softtabstop = 4  -- Pressing Tab inserts 4 spaces; Backspace deletes 4 spaces
opt.shiftwidth = 4   -- Auto-indentation (>>) uses 4 spaces

-- UI
opt.number = true         -- Shows absolute line numbers on the left
opt.relativenumber = true -- Shows relative distances from the cursor line
opt.cursorline = true     -- Highlights the current row the cursor is on
opt.signcolumn = "yes"    -- Reserves a left-hand column for diagnostic/git icons
opt.termguicolors = true  -- Enables 24-bit RGB true color support
opt.scrolloff = 8         -- Keeps cursor 8 lines away from top/bottom edges
opt.wrap = false          -- Disables line wrapping; long lines scroll off-screen

-- Splits
opt.splitright = true -- New vertical splits open to the right
opt.splitbelow = true -- New horizontal splits open below

-- Search
opt.ignorecase = true -- Ignores case when typing search patterns
opt.smartcase = true  -- Automatically switches to case-sensitive if you use a capital letter

-- Files & undo
opt.undofile = true  -- Saves undo history persistently to disk
opt.swapfile = false -- Disables creation of annoying .swp recovery files
opt.updatetime = 250 -- Wait 250ms before writing swap/undo history (makes auto-saves feel snappier)

-- Clipboard & mouse
opt.clipboard = "unnamedplus" -- Uses the system clipboard for yank/paste
opt.mouse = "a"               -- Enables mouse interaction in all modes

-- Folding (treesitter-based, defined in treesitter.lua)
opt.foldlevel = 99     -- Prevents automatic folding so code is expanded by default
opt.foldenable = true  -- Enables the code-folding feature globally

require("config.lazy") -- Bootstraps and calls the main Lazy.nvim plugin manager file
