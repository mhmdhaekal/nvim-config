-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ayu_dark",
  transparency = false,
}

M.ui = {
  telescope = { style = "borderless" },
  statusline = { theme = "minimal", separator_style = "round" },
  cmp = {
    icons = false,
  },
}

return M
