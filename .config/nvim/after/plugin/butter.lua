require("butter").setup({
  show_hidden = true,
  no_ignore = true,
  exclude = { ".git", "node_modules", "dist" },
  auto_open = true,
})

vim.keymap.set("n", "<leader>e", "<cmd>Butter<cr>", { desc = "Open Butter" })
