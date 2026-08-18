return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- widened so <leader>lf works pre-save
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            sh = { "shfmt" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            css = { "prettier" },
            sql = { "sqlfluff" },
        },
        formatters = {
            sqlfluff = {
                args = { "format", "--dialect", "sqlite", "-" }, -- added: pin dialect to sqlite
            },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
