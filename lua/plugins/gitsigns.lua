return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame = false,
        current_line_blame_opts = {
            delay = 300,
        },
        on_attach = function(bufnr)
            require("config.keymaps").gitsigns_attach(bufnr)
        end,
    },
}