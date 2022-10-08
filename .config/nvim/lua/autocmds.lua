-- autocmds
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    require'vim.highlight'.on_yank()
  end,
})

autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'SignColumn', {})
  end,
})

autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd [[:wincmd =]]
  end,
})

autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"",false)
        end
    end
})

autocmd("BufWritePost", {
    pattern = {"plugins/init.lua"},
    callback = function()
     vim.cmd [[source <afile> | PackerCompile]]
    end
})

autocmd('RecordingEnter', {
    pattern = '*',
    callback = function()
        vim.opt_local.cmdheight = 1
    end,
})

autocmd('RecordingLeave', {
    pattern = '*',
    callback = function()
      local timer = vim.loop.new_timer()
      -- NOTE: Timer is here because we need to close cmdheight AFTER
      -- the macro is ended, not during the Leave event
      timer:start( 50, 0, vim.schedule_wrap(function()
        vim.opt_local.cmdheight = 0
      end)
      )
    end,
})
