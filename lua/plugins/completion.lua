return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts = {
        keymap = { preset = "default" },
        completion = {
            documentation = { auto_show = true },
            menu = {
                auto_show = function(ctx)
                    return ctx.mode ~= "default"
                end,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = { enabled = true },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
