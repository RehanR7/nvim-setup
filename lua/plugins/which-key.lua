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

        spec = require("config.keymaps").wk_groups,
    },
}
