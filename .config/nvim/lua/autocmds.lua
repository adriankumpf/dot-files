local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Force transparent sign column regardless of colorscheme
autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "SignColumn", {})
	end,
})

autocmd("VimResized", {
	callback = function()
		vim.cmd.wincmd("=")
	end,
})

-- Show cmdheight while recording macros (otherwise invisible with cmdheight=0)
local recording_timer = vim.uv.new_timer()

autocmd("RecordingEnter", {
	callback = function()
		vim.opt_local.cmdheight = 1
	end,
})

autocmd("RecordingLeave", {
	callback = function()
		-- Delay hiding cmdheight until after the macro has fully ended
		recording_timer:start(
			50,
			0,
			vim.schedule_wrap(function()
				vim.opt_local.cmdheight = 0
			end)
		)
	end,
})
