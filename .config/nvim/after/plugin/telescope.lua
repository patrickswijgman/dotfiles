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

local function find_sibling_files()
  builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end

local function grep()
  local input = vim.fn.input({ prompt = "Grep > ", default = vim.fn.expand("<cWORD>") })
  if input ~= "" then
    builtin.grep_string({ search = input })
  end
end

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>.", find_sibling_files, { desc = "Telescope find sibling files " })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>G", grep, { desc = "Telescope grep string" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Telescope resume last picker" })
