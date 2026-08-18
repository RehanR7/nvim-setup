return {
    "folke/which-key.nvim",

    event = "VeryLazy",

    opts = {
        preset = "modern",

        delay = 300,

        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
            mappings = true,
        },

        win = {
            border = "rounded",
        },

        layout = {
            width = {
                min = 20,
                max = 50,
            },
            spacing = 3,
        },

        spec = {
            {
                "<leader>l",
                group = "LSP",
            },
            {
                "<leader>d",
                group = "Diagnostics",
            },
            {
                "<leader>e",
                group = "Explorer",
            },
            {
                "<leader>f",
                group = "Find",
            },
            {
                "<leader>g",
                group = "Git",
            },
            {
                "<leader>b",
                group = "Buffer",
            },
            {
                "<leader>s",
                group = "Flash/Search",
            },
        },
    },
}
