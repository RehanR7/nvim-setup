return {
    {
        "nvim-treesitter/nvim-treesitter",

        lazy = false,

        build = ":TSUpdate",

        config = function()
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            require("nvim-treesitter").install({
                "bash",
                "html",
                "css",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "query",
                "sql",
                "vim",
                "vimdoc",
                "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "html",
                    "css",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "query",
                    "sql",
                    "vim",
                    "vimdoc",
                    "yaml",
                },

                callback = function()
                    -- Syntax highlighting
                    vim.treesitter.start()

                    -- Folding
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldmethod = "expr"

                    -- Indentation
                    vim.bo.indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
