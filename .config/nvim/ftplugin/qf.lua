vim.opt_local.buflisted = false

vim.keymap.set("n", ">", function()
	require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
end, { buffer = true, desc = "Expand quickfix context" })

vim.keymap.set("n", "<", function()
	require("quicker").collapse()
end, { buffer = true, desc = "Collapse quickfix context" })
