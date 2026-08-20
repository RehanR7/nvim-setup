-- Every keybinding lives here so it's easy to see and audit in one place.
-- which-key discovers all of these automatically via their `desc`.
local M = {}
local map = vim.keymap.set
local gmap = vim.g

-- ============================================================================
--  LEADER KEYS
-- ============================================================================
gmap.mapleader = " "      -- Sets the main leader key to <Space>
gmap.maplocalleader = " " -- Sets the local leader key to <Space> (applies to filetypes)

-- ============================================================================
--  EXPLORER
-- ============================================================================
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- ============================================================================
--  FIND (Telescope + Trouble todo search)
-- ============================================================================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>ft", "<cmd>Trouble todo toggle<cr>", { desc = "Todo Search" })

-- ============================================================================
--  GIT (Neogit + Diffview)
-- ============================================================================
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
map("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (working tree)" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history (this file)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "File history (repo)" })

-- ============================================================================
--  DIAGNOSTICS (Trouble)
-- ============================================================================
map("n", "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>dD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>dq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })

-- ============================================================================
--  FORMATTING (conform.nvim; loaded on BufReadPre, see plugins/conform.lua)
-- ============================================================================
map("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- ============================================================================
--  FLASH (loaded on VeryLazy, safe to require directly here)
-- ============================================================================
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })

-- ============================================================================
--  EDITING
-- ============================================================================
-- Move lines up/down in visual selection, reselecting and re-indenting after
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })

-- Indent/unindent and keep the visual selection active
map("v", "<", "<gv", { desc = "Unindent and keep selection" })
map("v", ">", ">gv", { desc = "Indent and keep selection" })

-- Join lines without moving the cursor
map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Half-page scrolling with cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

-- Search navigation with cursor centered
map("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

-- Replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word curs" })

-- Make current file executable
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Restart Neovim
map("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)" })

-- Escape insert mode
map("i", "<C-c>", "<Esc>")

-- Clear search highlighting
map("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

-- Paste over selection without losing yanked text
map("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

-- Delete text without saving it to any register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- AI Completion (NeoCodeium, insert mode only — deliberately not on <Tab>,
-- see plugins/neocodeium.lua for rationale)
map("i", "<A-f>", function() require("neocodeium").accept() end, { desc = "Accept AI suggestion" })
map("i", "<A-w>", function() require("neocodeium").accept_word() end, { desc = "Accept AI suggestion (word)" })
map("i", "<A-a>", function() require("neocodeium").accept_line() end, { desc = "Accept AI suggestion (line)" })
map("i", "<A-e>", function() require("neocodeium").cycle_or_complete() end, { desc = "Next AI suggestion" })
map("i", "<A-r>", function() require("neocodeium").cycle_or_complete(-1) end, { desc = "Previous AI suggestion" })
map("i", "<A-c>", function() require("neocodeium").clear() end, { desc = "Dismiss AI suggestion" })

-- ---------------------------------------------------------------------
-- Gitsigns: buffer-local (only meaningful once gitsigns attaches to a
-- buffer). Definitions live here; plugins/gitsigns.lua just calls this
-- from on_attach.
-- ---------------------------------------------------------------------
function M.gitsigns_attach(bufnr)
    local gs = require("gitsigns")
    local function bmap(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    -- NOTE: gs.next_hunk()/gs.prev_hunk() are deprecated in favor of
    -- gs.nav_hunk("next"/"prev").
    bmap("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.nav_hunk("next") end)
        return "<Ignore>"
    end, "Next hunk")
    bmap("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.nav_hunk("prev") end)
        return "<Ignore>"
    end, "Prev hunk")

    -- Staging
    bmap("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
    bmap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
    bmap("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
    bmap("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
    bmap("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
    -- NOTE: gs.undo_stage_hunk() is deprecated with no direct replacement;
    -- gitsigns now toggles staged state, so calling stage_hunk() again on an
    -- already-staged hunk unstages it.
    bmap("n", "<leader>gu", gs.stage_hunk, "Undo stage hunk")

    -- Inspection
    bmap("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    bmap("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
    bmap("n", "<leader>gd", gs.diffthis, "Diff this")

    -- Text object
    bmap({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
end

-- ---------------------------------------------------------------------
-- LSP: buffer-local (only meaningful once a server attaches). Wired up
-- from plugins/lsp-config.lua's LspAttach autocmd.
-- ---------------------------------------------------------------------
function M.lsp_attach(event)
    local function bmap(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    -- Navigation
    bmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    bmap("n", "gr", vim.lsp.buf.references, "Find references")
    bmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")

    -- Information
    bmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
    bmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Code actions
    bmap("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
    bmap("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")

    -- Diagnostics
    bmap("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic")
    -- NOTE: vim.diagnostic.goto_next/goto_prev are deprecated in favor of
    -- vim.diagnostic.jump({ count = ... }).
    bmap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    bmap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
end

-- which-key group labels (breadcrumbs for leader prefixes)
M.wk_groups = {
    { "<leader>l", group = "LSP" },
    { "<leader>d", group = "Diagnostics" },
    { "<leader>e", group = "Explorer" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>b", group = "Buffer" },
}

return M
