local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-vitest"),
	},
})

local function run_test()
	neotest.run.run()
end

local function run_tests_in_file()
	neotest.run.run(vim.fn.expand("%"))
end

vim.keymap.set("n", "<leader>tr", run_test, { desc = "Run test" })
vim.keymap.set("n", "<leader>tf", run_tests_in_file, { desc = "Run tests in current file" })
vim.keymap.set("n", "<leader>tw", neotest.watch.watch, { desc = "Watch nearest test" })
vim.keymap.set("n", "<leader>ts", neotest.summary.open, { desc = "Open test summary" })
vim.keymap.set("n", "<leader>to", neotest.output_panel.open, { desc = "Open test output" })
