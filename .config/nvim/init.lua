vim.g.mapleader = " "

-- PackChanged hooks must be registered before any vim.pack.add() call
-- (plugin/ files are sourced after init.lua)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		elseif name == "blink.cmp" and (kind == "install" or kind == "update") then
			local dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
			vim.system({ "cargo", "build", "--release" }, { cwd = dir }, function(result)
				if result.code ~= 0 then
					vim.schedule(function()
						vim.notify("blink.cmp: cargo build failed", vim.log.levels.ERROR)
					end)
				end
			end)
		elseif name == "markdown-preview.nvim" and kind == "install" then
			if not ev.data.active then
				vim.cmd.packadd("markdown-preview.nvim")
			end
			vim.fn["mkdp#util#install"]()
		end
	end,
})

require("options")
require("mappings")
require("autocmds")
