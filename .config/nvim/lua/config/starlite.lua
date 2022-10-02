vim.keymap.set("n", "*", [[<cmd> lua require'starlite'.star()<cr>]], { silent = true })
vim.keymap.set("n", "g*", [[<cmd> lua require'starlite'.g_star()<cr>]], { silent = true })
vim.keymap.set("n", "#", [[<cmd> lua require'starlite'.hash()<cr>]], { silent = true })
vim.keymap.set("n", "g#", [[<cmd> lua require'starlite'.g_hash()<cr>]], { silent = true })
