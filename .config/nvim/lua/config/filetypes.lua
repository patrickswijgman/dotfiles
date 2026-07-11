vim.filetype.add({
  pattern = {
    [".*/config"] = { "config", { priority = 10 } },
    [".*/librewolf.overrides.cfg"] = "javascript",
  },
})
