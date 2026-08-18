return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>dd",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>dD",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer diagnostics",
        },
        {
            "<leader>dq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix (Trouble)",
        },
    },
    opts = {},
}