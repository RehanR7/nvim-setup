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

-- Explorer
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- Find (Telescope + Trouble todo search)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>ft", "<cmd>Trouble todo toggle<cr>", { desc = "Todo Search" })

-- Git (Neogit + Diffview)
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
map("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Diff view (working tree)" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history (this file)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "File history (repo)" })

-- Diagnostics (Trouble)
map("n", "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>dD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>dq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })

-- Formatting (conform.nvim; loaded on BufReadPre, see plugins/conform.lua)
map("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Flash (loaded on VeryLazy, safe to require directly here)
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })

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
    bmap("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(gs.next_hunk)
        return "<Ignore>"
    end, "Next hunk")
    bmap("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(gs.prev_hunk)
        return "<Ignore>"
    end, "Prev hunk")

    -- Staging
    bmap("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
    bmap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
    bmap("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
    bmap("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
    bmap("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
    bmap("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

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
    bmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    bmap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
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

