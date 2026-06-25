-- Fold import statements automatically.

local ok, parser = pcall(vim.treesitter.get_parser, 0)
if not ok or not parser then
  return
end

local root = parser:parse()[1]:root()
local first, last
for node in root:iter_children() do
  if node:type() == "import_statement" then
    local s = node:start()
    local e = node:end_()
    first = first or s + 1
    last = e + 1
  end
end

if first and last and last > first then
  vim.cmd(("%d,%dfold"):format(first, last))
end
