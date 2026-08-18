return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "mason-org/mason.nvim",
    },
    event = "VeryLazy",
    opts = {
        ensure_installed = {
            "stylua",
            "ruff",
            "shfmt",
            "prettier",
            "sqlfluff",
        },
    },
}