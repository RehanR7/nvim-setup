return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        -- Use trouble's todo integration over TodoTelescope: reuses the same
        -- window as the diagnostics mappings and needs no telescope extension.
        {
            "<leader>ft",
            "<cmd>Trouble todo toggle<cr>",
            desc = "Todo Search",
        },
    },
    opts = {},
}