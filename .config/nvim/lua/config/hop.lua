local map = require('config.utils').map

require'hop'.setup {
  keys = 'etovxqpdygfblzhckisuran',
}

map('n', ',f', "<cmd>lua require'hop'.hint_char1({})<cr>", { silent = true })
