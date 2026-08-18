return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },

    cmd = "Telescope",

    opts = {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- Keep the selector compact
            winblend = 0,
          }),
        },
      },
    },

    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)

      telescope.load_extension("ui-select")
    end,
  },
}
