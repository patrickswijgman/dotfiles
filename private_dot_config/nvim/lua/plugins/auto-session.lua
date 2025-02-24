-- For a better experience with the plugin overall using this config for sessionoptions is recommended:
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup({
	use_git_branch = true,
	session_lens = {
		load_on_setup = false, -- Initialize on startup (requires Telescope)
	},
})
