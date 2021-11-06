local map = require('config.utils').map

map("n", "*", [[<cmd> lua require'starlite'.star()<cr>]], { silent = true })
map("n", "g*", [[<cmd> lua require'starlite'.g_star()<cr>]], { silent = true })
map("n", "#", [[<cmd> lua require'starlite'.hash()<cr>]], { silent = true })
map("n", "g#", [[<cmd> lua require'starlite'.g_hash()<cr>]], { silent = true })
