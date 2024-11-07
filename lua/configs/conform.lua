local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "eslint_d" },
    typescript = { "biome" },
    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    vue = { "prettier" },
    python = { "ruff-format" },
    java = { "google-java-format" },
  },

  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
