local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local repeatable = require("nvim-treesitter-textobjects.repeatable_move")

require("nvim-treesitter-textobjects").setup({
  select = {
    -- Automatically jump forward to textobject
    lookahead = true,
  },
  move = {
    -- Whether to set jumps in the jumplist
    set_jumps = true,
  },
})

-- Select textobjects
vim.keymap.set({ "x", "o" }, "af", function()
  select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  select.select_textobject("@function.inner", "textobjects")
end)

-- Move to textobjects
vim.keymap.set({ "n", "x", "o" }, "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end)

-- Repeat movement with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", repeatable.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", repeatable.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", repeatable.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", repeatable.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", repeatable.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", repeatable.builtin_T_expr, { expr = true })
