local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local layout = require("telescope.actions.layout")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<c-up>"] = actions.cycle_history_prev,
        ["<c-down>"] = actions.cycle_history_next,
        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,
        ["<m-p>"] = layout.toggle_preview,
        ["<esc>"] = actions.close,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--vimgrep",
      "--smart-case",
      "--trim",
      "--hidden",
      "--no-ignore",
      "--glob=!.git",
      "--glob=!node_modules",
      "--glob=!dist",
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type=file",
        "--hidden",
        "--no-ignore",
        "--exclude=.git",
        "--exclude=node_modules",
        "--exclude=dist",
      },
    },
  },
})

require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>s", builtin.git_status, { desc = "Telescope git status" })
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Telescope resume last picker" })

vim.keymap.set("n", "grd", builtin.lsp_definitions, { desc = "Telescope LSP definitions" })
vim.keymap.set("n", "gri", builtin.lsp_implementations, { desc = "Telescope LSP implementations" })
vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Telescope LSP references" })
vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { desc = "Telescope LSP type definitions" })
vim.keymap.set("n", "gre", builtin.diagnostics, { desc = "Telescope diagnostics" })
vim.keymap.set("n", "grO", builtin.lsp_workspace_symbols, { desc = "Telescope LSP workspace symbols" })
vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { desc = "Telescope LSP document symbols" })
