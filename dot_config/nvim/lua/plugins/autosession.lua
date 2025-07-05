require("auto-session").setup({
  git_use_branch_name = true,
  git_auto_restore_on_branch_change = true,
  session_lens = {
    load_on_setup = false,
  },
})
