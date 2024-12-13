local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "clangd",
  "tailwindcss",
  "ts_ls",
  "gopls",
  "rust_analyzer",
  "volar",
  "ruff",
  "biome",
  "lexical",
  "jdtls",
  "eslint",
  "pyright",
  "markdown_oxide",
  "zls",
  "fsautocomplete",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

on_attach = function(client, _)
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end
end

lspconfig.ruff.setup {
  on_attach = on_attach,
}

lspconfig.pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
}

local util = require "lspconfig.util"

local mason_registry = require "mason-registry"
local vue_language_server_path = mason_registry
  .get_package("vue-language-server")
  :get_install_path() .. "/node_modules/@vue/language-server"

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
}

lspconfig.volar.setup {}

lspconfig.tailwindcss.setup {
  root_dir = util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts"
  ),
}

lspconfig.cssls.setup {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
}
