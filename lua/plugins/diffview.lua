return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
        { "<leader>gv", "<cmd>DiffviewOpen<cr>",          desc = "Diff view (working tree)" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (this file)" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "File history (repo)" },
    },
    opts = {},
}
