local function toggle_quickfix_list()
  local list = vim.fn.getqflist({ winid = 0 })

  if list.winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

-- Tabs
vim.keymap.set("n", "<c-h>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<c-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<c-n>", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<c-q>", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Quickfix list
vim.keymap.set("n", "<leader>q", toggle_quickfix_list, { desc = "Toggle quickfix list" })

-- Replace
vim.keymap.set("v", "R", '"_dp', { desc = "Replace selection with yanked text" })
vim.keymap.set("v", "<leader>R", '"_d"+p', { desc = "Replace selection with system clipboard" })

-- Misc
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear highlight", silent = true })

-- Disabled
vim.keymap.set("n", "q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "U", "<nop>", { desc = "Disable undo line changes" })
