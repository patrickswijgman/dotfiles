local move = require("nvim-treesitter-textobjects.move")
local repeatable = require("nvim-treesitter-textobjects.repeatable_move")
local select = require("nvim-treesitter-textobjects.select")

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

local function select_or_move_to_textobject(char, textobject, opts)
  opts = opts or {}

  local select_around = ("a%s"):format(char)
  local select_inner = ("i%s"):format(char)
  local move_next = ("]%s"):format(char)
  local move_prev = ("[%s"):format(char)
  local outer = ("@%s.outer"):format(textobject)
  local inner = ("@%s.inner"):format(textobject)

  vim.keymap.set({ "x", "o" }, select_around, function()
    select.select_textobject(outer, "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, select_inner, function()
    select.select_textobject(inner, "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, move_next, function()
    move.goto_next_start(opts.move_inside and inner or outer, "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, move_prev, function()
    move.goto_previous_start(opts.move_inside and inner or outer, "textobjects")
  end)
end

select_or_move_to_textobject("f", "function")
select_or_move_to_textobject("p", "parameter", { move_inside = true })
select_or_move_to_textobject("c", "call")
select_or_move_to_textobject("k", "class")
select_or_move_to_textobject("i", "conditional")
select_or_move_to_textobject("l", "loop")
select_or_move_to_textobject("r", "return")
select_or_move_to_textobject("/", "comment")

-- Repeat movement with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", repeatable.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", repeatable.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", repeatable.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", repeatable.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", repeatable.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", repeatable.builtin_T_expr, { expr = true })
