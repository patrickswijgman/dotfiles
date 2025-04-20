require("blink.cmp").setup({
  completion = {
    menu = {
      border = "rounded",
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 50,
      window = {
        border = "rounded",
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
})
