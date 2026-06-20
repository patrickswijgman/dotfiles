local function toggle_quickfix_list()
  local list = vim.fn.getqflist({ winid = 0 })

  if list.winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

vim.keymap.set("n", "<leader>e", ":Explorer<cr>", { desc = "Open explorer" })
vim.keymap.set("n", "<leader>f", ":Files ", { desc = "Search for files" })
vim.keymap.set("n", "<leader>g", ":Grep ", { desc = "Grep in files" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>q", toggle_quickfix_list, { desc = "Toggle quickfix list" })

vim.keymap.set("v", "R", '"_dP', { desc = "Replace selection with yanked text" })
vim.keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace selection with system clipboard" })

vim.keymap.set("n", "<esc>", ":nohl<cr>", { desc = "Clear highlight", silent = true })

vim.keymap.set("n", "q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "U", "<nop>", { desc = "Disable undo line changes" })
