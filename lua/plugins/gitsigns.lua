return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame = false, -- toggle on demand with <leader>gb
        current_line_blame_opts = {
            delay = 300,
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(gs.next_hunk)
                return "<Ignore>"
            end, "Next hunk")
            map("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(gs.prev_hunk)
                return "<Ignore>"
            end, "Prev hunk")

            -- Staging
            map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
            map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

            -- Inspection
            map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
            map("n", "<leader>gd", gs.diffthis, "Diff this")

            -- Text object: `ih` selects a hunk
            map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        end,
    },
}
