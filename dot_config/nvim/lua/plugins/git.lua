require("neogit").setup({
	git_services = {
		["gitlab.wearespindle.com"] = "https://gitlab.wearespindle.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
	},
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit open" })

require("gitlinker").setup({
	mappings = "<leader>gy",
	callbacks = {
		["gitlab.wearespindle.com"] = require("gitlinker.hosts").get_gitlab_type_url,
	},
})

require("git-conflict").setup({})

vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous git conflict" })
vim.keymap.set("n", "[x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next git conflict" })

require("gitsigns").setup({})

vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous git hunk" })
vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "Open git blame" })
