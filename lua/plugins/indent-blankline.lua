return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        exclude = {
            filetypes = {
                "lspinfo", "packer", "checkhealth", "help", "man",
                "gitcommit", "TelescopePrompt", "TelescopeResults", "",
                "netrw",
            },
        },
    },
}