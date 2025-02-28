local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-vitest"),
	},
})

vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Neotest run nearest test" })
vim.keymap.set("n", "<leader>ts", neotest.summary.open, { desc = "Neotest open summary" })
vim.keymap.set("n", "<leader>to", neotest.output_panel.open, { desc = "Neotest open output" })
