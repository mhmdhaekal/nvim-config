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
  "denols",
  "zls",
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

local function is_deno_project(fname)
  return util.root_pattern("deno.json", "deno.jsonc")(fname) ~= nil
end

on_attach = function(client, bufnr)
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if is_deno_project(buf_name) then
    if client.name == "ts_ls" or client.name == "volar" then
      client.stop()
    end
  end
end

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  root_dir = function(fname)
    if is_deno_project(fname) or util.root_pattern "vue.config.js"(fname) then
      return nil
    end
    return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(
      fname
    )
  end,
  filetypes = { "javascript", "typescript" },
}

lspconfig.denols.setup {
  on_attach = on_attach,
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  filetypes = { "javascript", "typescript" },
}

local function get_typescript_server_path(root_dir)
  local global_ts = "/Users/haekal/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup {
  on_attach = on_attach,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk =
      get_typescript_server_path(new_root_dir)
  end,
  root_dir = util.root_pattern(
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    "vue.config.js"
  ),
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}

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
