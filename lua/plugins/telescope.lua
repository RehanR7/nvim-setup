return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },

    cmd = "Telescope",

    opts = {
      defaults = {
        file_ignore_patterns = {},
      },

      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      },

      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
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