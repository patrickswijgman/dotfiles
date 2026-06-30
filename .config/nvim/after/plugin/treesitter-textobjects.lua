require("nvim-treesitter-textobjects").setup({
  select = {
    -- Automatically jump forward to textobject
    lookahead = true,
  },
  move = {
    -- whether to set jumps in the jumplist
    set_jumps = true,
  },
})

-- Select

local select = require("nvim-treesitter-textobjects.select")

vim.keymap.set({ "x", "o" }, "af", function()
  select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  select.select_textobject("@function.inner", "textobjects")
end)

-- Move

local move = require("nvim-treesitter-textobjects.move")

vim.keymap.set({ "n", "x", "o" }, "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end)

-- Repeat

local repeatable_move = require("nvim-treesitter-textobjects.repeatable_move")

-- Repeat movement with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", repeatable_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", repeatable_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", repeatable_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", repeatable_move.builtin_T_expr, { expr = true })
