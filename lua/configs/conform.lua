local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "eslint_d" },
    typescript = { "biome" },
    astro = { "biome" },
    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    vue = { "biome" },
    python = { "ruff-format" },
  },
}

require("conform").setup(options)
