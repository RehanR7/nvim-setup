return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  cmd = "Neotree",

  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",

    filesystem = {
      follow_current_file = {
        enabled = true,
      },

      hijack_netrw_behavior = "open_default",

      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },

    window = {
      width = 32,
      mappings = {
        -- <Space> is the leader key; neo-tree's default <Space> (toggle_node)
        -- would add a delay to every <leader> mapping pressed in the tree.
        -- Use <CR> to expand/collapse folders instead.
        ["<space>"] = "none",
      },
    },

    default_component_configs = {
    },
  },
}
