local map = require('config.utils').map

vim.g.bufferline = {
  auto_hide = true,
  tabpages = true,
  closable = false,
}

-- Move to previous/next
map('n', '<M-,>', ':BufferPrevious<CR>', { silent = true })
map('n', '<M-.>', ':BufferNext<CR>', { silent = true })

-- Re-order to previous/next
map('n', '<M-<>', ':BufferMovePrevious<CR>', { silent = true })
map('n', '<M->>', ' :BufferMoveNext<CR>', { silent = true })

-- Goto buffer in position...
map('n', '<M-1>', ':BufferGoto 1<CR>', { silent = true })
map('n', '<M-2>', ':BufferGoto 2<CR>', { silent = true })
map('n', '<M-3>', ':BufferGoto 3<CR>', { silent = true })
map('n', '<M-4>', ':BufferGoto 4<CR>', { silent = true })
map('n', '<M-5>', ':BufferGoto 5<CR>', { silent = true })
map('n', '<M-6>', ':BufferGoto 6<CR>', { silent = true })
map('n', '<M-7>', ':BufferGoto 7<CR>', { silent = true })
map('n', '<M-8>', ':BufferGoto 8<CR>', { silent = true })
map('n', '<M-9>', ':BufferGoto 9<CR>', { silent = true })
map('n', '<M-0>', ':BufferLast<CR>', { silent = true })

-- Close buffer
map('n', '<M-c>', ':BufferClose<CR>', { silent = true })

-- Wipeout buffer
--                 :BufferWipeout<CR>
--
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>

-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', { silent = true })

-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', { silent = true })
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', { silent = true })
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', { silent = true })
