return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>lf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      desc = "Format buffer",
    },
  },
}
