vim.keymap.set('n', 's', function()
  require('leap').leap { target_windows = { vim.fn.win_getid() } }
end)
