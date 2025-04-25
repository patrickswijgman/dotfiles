require("vague").setup({
  style = {
    boolean = "bold",
    number = "none",
    float = "none",
    error = "bold",
    comments = "italic",
    conditionals = "none",
    functions = "none",
    headings = "bold",
    operators = "none",
    strings = "none",
    variables = "none",

    keywords = "none",
    keyword_return = "none",
    keywords_loop = "none",
    keywords_label = "none",
    keywords_exception = "none",

    builtin_constants = "none",
    builtin_functions = "none",
    builtin_types = "none",
    builtin_variables = "none",
  },
  plugins = {
    cmp = {
      match = "bold",
      match_fuzzy = "bold",
    },
    dashboard = {
      footer = "italic",
    },
    lsp = {
      diagnostic_error = "bold",
      diagnostic_warn = "bold",
      diagnostic_info = "none",
      diagnostic_hint = "none",
    },
    neotest = {
      focused = "bold",
      adapter_name = "bold",
    },
    telescope = {
      match = "bold",
    },
  },
})

vim.cmd.colorscheme("vague")
