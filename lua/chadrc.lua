-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = false,
}

M.ui = {
  telescope = { style = "borderless" },
  statusline = { theme = "minimal", separator_style = "round" },
  cmp = {
    icons = true,
  },
}

M.nvdash = {
  load_on_startup = true,
}


return M
