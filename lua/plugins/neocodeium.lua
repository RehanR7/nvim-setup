return {
    "monkoose/neocodeium",
    event = "InsertEnter",
    opts = {
        -- Don't show a ghost-text suggestion while blink.cmp's menu is open
        filter = function()
            return not require("blink.cmp").is_visible()
        end,
    },
    config = function(_, opts)
        require("neocodeium").setup(opts)

        -- Clear any visible suggestion the moment blink.cmp's menu opens,
        -- so the two never overlap on screen.
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                require("neocodeium").clear()
            end,
        })
    end,
}
