require("neogit").setup({})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit open" })

require("gitlinker").setup({
	mappings = "<leader>gy",
	callbacks = {
		["gitlab.wearespindle.com"] = require("gitlinker.hosts").get_gitlab_type_url,
	},
})

require("git-conflict").setup({})

require("gitsigns").setup({})

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Git blame" })
