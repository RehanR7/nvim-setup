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
                -- conform's default requires a .sqlfluff file in the project root
                -- ("Root directory not found"). The dialect is pinned above, so
                -- it works without one.
                require_cwd = false,
            },
        },
        format_on_save = {
            timeout_ms = 10000,
            lsp_format = "fallback",
        },
    },
}
