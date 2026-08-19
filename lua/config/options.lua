-- ============================================================================
--  ALIASES
-- ============================================================================
local opt = vim.opt -- Aliases 'vim.opt' to 'opt' to save typing later
local api = vim.api -- Aliases 'vim.api' to 'api' to save typing later (fixed typo)

-- ============================================================================
--  INDENTATION
-- ============================================================================
opt.expandtab = true -- Replaces Tab keystrokes with spaces
opt.tabstop = 4      -- An existing Tab character appears as 4 spaces wide
opt.softtabstop = 4  -- Pressing Tab inserts 4 spaces; Backspace deletes 4 spaces
opt.shiftwidth = 4   -- Auto-indentation (>>) uses 4 spaces

-- ============================================================================
--  UI / APPEARANCE
-- ============================================================================
opt.number = true         -- Shows absolute line numbers on the left
opt.relativenumber = true -- Shows relative distances from the cursor line
opt.guicursor = ""        -- Customizes cursor appearance (empty = default)
opt.cursorline = true     -- Highlights the current row the cursor is on
opt.signcolumn = "yes"    -- Reserves a left-hand column for diagnostic/git icons
opt.termguicolors = true  -- Enables 24-bit RGB true color support
opt.scrolloff = 8         -- Keeps cursor 8 lines away from top/bottom edges
opt.wrap = false          -- Disables line wrapping; long lines scroll off-screen

-- ============================================================================
--  SPLIT WINDOWS
-- ============================================================================
opt.splitright = true -- New vertical splits open to the right
opt.splitbelow = true -- New horizontal splits open below

-- ============================================================================
--  SEARCH BEHAVIOR
-- ============================================================================
opt.ignorecase = true    -- Ignores case when typing search patterns
opt.smartcase = true     -- Automatically switches to case-sensitive if you use a capital letter
opt.inccommand = "split" -- Shows live preview of substitutions in a split window

-- ============================================================================
--  FILES & UNDO HISTORY
-- ============================================================================
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Stores undo files in a dedicated directory
opt.undofile = true                                 -- Saves undo history persistently to disk
opt.swapfile = false                                -- Disables creation of annoying .swp recovery files
opt.backup = false                                  -- Disables backup file creation
opt.updatetime = 250                                -- Wait 250ms before writing swap/undo history (makes auto-saves feel snappier)

-- ============================================================================
--  CLIPBOARD & MOUSE
-- ============================================================================
opt.clipboard = "unnamedplus" -- Uses the system clipboard for yank/paste
opt.mouse = "a"               -- Enables mouse interaction in all modes

-- ============================================================================
--  AUTOCOMMANDS
-- ============================================================================
-- Highlights yanked text temporarily so you can see what was copied
api.nvim_create_autocmd(
    "TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        callback = function()
            vim.hl.on_yank()
        end,
    }
)

-- ============================================================================
--  FOLDING
-- ============================================================================
-- NOTE: Treesitter-based folding is defined in treesitter.lua
opt.foldlevel = 99    -- Prevents automatic folding so code is expanded by default
opt.foldenable = true -- Enables the code-folding feature globally

-- ============================================================================
--  NETRW (Built-in File Explorer)
-- ============================================================================
vim.g.netrw_banner = 0 -- Disables Vim's built-in file explorer plugin header
