return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    event = "VeryLazy",

    opts = {
        options = {
            theme = "dracula",
            globalstatus = true,
            disabled_filetypes = {
                statusline = {
                    "neo-tree",
                },
            },
        },

        sections = {
            lualine_b = {
                "branch",
                "diff",
                "diagnostics",
            },
            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },
        },
    },
}
