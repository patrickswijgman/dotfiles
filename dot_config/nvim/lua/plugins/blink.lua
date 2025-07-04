require("blink.cmp").setup({
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 50,
    },
  },
  signature = {
    enabled = true,
  },
})
