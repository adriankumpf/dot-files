local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("core", { clear = true })

autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Force transparent sign column regardless of colorscheme
autocmd("ColorScheme", {
	group = augroup,
	callback = function()
		vim.api.nvim_set_hl(0, "SignColumn", {})
	end,
})

autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd.wincmd("=")
	end,
})

-- Show cmdheight while recording macros (otherwise invisible with cmdheight=0)
autocmd("RecordingEnter", {
	group = augroup,
	callback = function()
		vim.o.cmdheight = 1
	end,
})

autocmd("RecordingLeave", {
	group = augroup,
	callback = function()
		-- Delay hiding cmdheight until after the macro has fully ended
		vim.defer_fn(function()
			vim.o.cmdheight = 0
		end, 50)
	end,
})
