local utils = require 'config.utils' local map = utils.map 

if vim.g.neovide then
  vim.g.gui_font_face = "FiraCode Nerd Font:h12"

  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_cursor_trail_length = 0.15

  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 1.0
  vim.g.neovide_background_color = '#292929'
 
  vim.g.neovide_input_use_logo=true
  vim.g.neovide_input_macos_alt_is_meta = true

  vim.g.neovide_cursor_vfx_mode = "railgun"
  map('', '<D-v>', '+p<CR>', { silent = true})
  map('!', '<D-v>', '<C-R>+', { silent = true})
  map('t', '<D-v>', '<C-R>+', { silent = true})
  map('v', '<D-v>', '<C-R>+', { silent = true})

  RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
  end

  ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
  end

  ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
  end

  -- Call function on startup to set default value
  ResetGuiFont()

  -- Keymaps
  local opts = { noremap = true, silent = true }
  vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
  vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)
end
