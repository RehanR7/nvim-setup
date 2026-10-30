return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },

    cmd = "Telescope",

    -- opts is a function so telescope.themes is required only when telescope
    -- actually loads (a plain table would load telescope at startup, which
    -- defeats `cmd = "Telescope"` lazy-loading).
    opts = function()
      return {
        defaults = {
          -- Hidden and gitignored files are searchable (see find_files below),
          -- but never list the contents of .git/ itself.
          file_ignore_patterns = { "^%.git/", "/%.git/" },
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
      }
    end,

    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)

      telescope.load_extension("ui-select")
    end,
  },
}