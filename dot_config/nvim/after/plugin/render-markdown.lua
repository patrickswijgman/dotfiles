require("render-markdown").setup({
  completions = {
    blink = {
      enabled = true,
    },
  },
  overrides = {
    buftype = {
      nofile = {
        -- Disable for buffers such as hover documentation.
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/383
        enabled = false,
      },
    },
  },
})
