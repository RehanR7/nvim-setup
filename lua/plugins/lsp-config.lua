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

            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    -- Navigation
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                        buffer = event.buf,
                        desc = "Go to definition",
                    })

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
                        buffer = event.buf,
                        desc = "Go to declaration",
                    })

                    vim.keymap.set("n", "gr", vim.lsp.buf.references, {
                        buffer = event.buf,
                        desc = "Find references",
                    })

                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
                        buffer = event.buf,
                        desc = "Go to implementation",
                    })

                    -- Information
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
                        buffer = event.buf,
                        desc = "Hover documentation",
                    })

                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
                        buffer = event.buf,
                        desc = "Signature help",
                    })

                    -- Code actions
                    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
                        buffer = event.buf,
                        desc = "Code action",
                    })

                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {
                        buffer = event.buf,
                        desc = "Rename symbol",
                    })

                    -- Diagnostics
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {
                        buffer = event.buf,
                        desc = "Show diagnostic",
                    })

                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
                        buffer = event.buf,
                        desc = "Next diagnostic",
                    })

                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
                        buffer = event.buf,
                        desc = "Previous diagnostic",
                    })
                end,
            })
        end,
    },
}
