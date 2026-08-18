return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "<leader>ss", mode = { "n", "x" }, function() require("flash").jump() end,       desc = "Flash Jump" },
        { "<leader>sS", mode = { "n", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "s",          mode = "o",          function() require("flash").jump() end,       desc = "Flash (operator)" },
        { "r",          mode = "o",          function() require("flash").remote() end,     desc = "Remote Flash" },
    },
}
