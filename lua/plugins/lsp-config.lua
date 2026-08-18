return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "bashls",
                "jsonls",
                "cssls",
                "sqlls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",

        event = {
            "BufReadPre",
            "BufNewFile",
        },

        config = function()
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "bashls",
                "jsonls",
                "cssls",
                "sqlls",
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    require("config.keymaps").lsp_attach(event)
                end,
            })
        end,
    },
}
