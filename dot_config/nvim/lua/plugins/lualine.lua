require("lualine").setup({
  options = {
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = { "diagnostics", { "filename", path = 1 } },
    lualine_x = { "filetype", "location", "progress" },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
