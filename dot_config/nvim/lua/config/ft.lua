vim.filetype.add({
  pattern = {
    [".*/config"] = { "config", { priority = 10 } },
    ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
  },
})
