local move = require("nvim-treesitter-textobjects.move")
local repeatable = require("nvim-treesitter-textobjects.repeatable_move")
local select = require("nvim-treesitter-textobjects.select")

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

local function set_keymap_for_textobject(char, textobject, opts)
  opts = opts or {}

  local outer = ("@%s.outer"):format(textobject)
  local inner = ("@%s.inner"):format(textobject)
  local select_around = ("a%s"):format(char)
  local select_inner = ("i%s"):format(char)
  local move_next = ("]%s"):format(char)
  local move_prev = ("[%s"):format(char)
  local move_target = opts.move_inside and inner or outer

  vim.keymap.set({ "x", "o" }, select_around, function()
    select.select_textobject(outer, "textobjects")
  end, {
    desc = ("Select around %s"):format(textobject),
  })

  vim.keymap.set({ "x", "o" }, select_inner, function()
    select.select_textobject(inner, "textobjects")
  end, {
    desc = ("Select inner %s"):format(textobject),
  })

  vim.keymap.set({ "n", "x", "o" }, move_next, function()
    move.goto_next_start(move_target, "textobjects")
  end, {
    desc = ("Move to next %s"):format(textobject),
  })

  vim.keymap.set({ "n", "x", "o" }, move_prev, function()
    move.goto_previous_start(move_target, "textobjects")
  end, {
    desc = ("Move to previous %s"):format(textobject),
  })
end

set_keymap_for_textobject("f", "function")
set_keymap_for_textobject("a", "parameter", { move_inside = true })
set_keymap_for_textobject("c", "call")
set_keymap_for_textobject("k", "class")
set_keymap_for_textobject("i", "conditional")
set_keymap_for_textobject("l", "loop")
set_keymap_for_textobject("r", "return")
set_keymap_for_textobject("/", "comment")

vim.keymap.set({ "n", "x", "o" }, ";", repeatable.repeat_last_move, { desc = "Repeat last move" })
vim.keymap.set({ "n", "x", "o" }, ",", repeatable.repeat_last_move_opposite, { desc = "Repeat last move (opposite)" })

vim.keymap.set({ "n", "x", "o" }, "f", repeatable.builtin_f_expr, { expr = true, desc = "Find" })
vim.keymap.set({ "n", "x", "o" }, "F", repeatable.builtin_F_expr, { expr = true, desc = "Find (opposite)" })
vim.keymap.set({ "n", "x", "o" }, "t", repeatable.builtin_t_expr, { expr = true, desc = "Find until" })
vim.keymap.set({ "n", "x", "o" }, "T", repeatable.builtin_T_expr, { expr = true, desc = "Find until (opposite)" })
