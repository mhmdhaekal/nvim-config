require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- neotree
map(
  "n",
  "<C-n>",
  "<cmd>Neotree toggle<CR>",
  { desc = "neotree toggle window" }
)

map("n", "<leader>pv", "<cmd>Neotree position=current<CR>", { desc = "Neotree filesystem window" })
map("n", "<leader>pb", "<cmd>Neotree source=buffers position=current<CR>", { desc = "Neotree buffers window" })
