vim.g.mapleader = " "

-- Ensure the plugin is loaded before running post-install commands
local function ensure_loaded(ev)
	if not ev.data.active then
		vim.cmd.packadd(ev.data.spec.name)
	end
end

-- PackChanged hooks must be registered before any vim.pack.add() call
-- (plugin/ files are sourced after init.lua)
local pack_hooks = {
	["nvim-treesitter"] = { on = { install = true, update = true }, run = function(ev)
		ensure_loaded(ev)
		vim.cmd.TSUpdate()
	end },
	["blink.cmp"] = { on = { install = true, update = true }, run = function()
		-- blink.cmp ships a Rust fuzzy matcher that must be compiled locally
		local dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
		vim.system({ "cargo", "build", "--release" }, { cwd = dir }, function(result)
			if result.code ~= 0 then
				vim.schedule(function()
					vim.notify("blink.cmp: cargo build failed", vim.log.levels.ERROR)
				end)
			end
		end)
	end },
	["markdown-preview.nvim"] = { on = { install = true }, run = function(ev)
		ensure_loaded(ev)
		vim.fn["mkdp#util#install"]()
	end },
}

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local hook = pack_hooks[ev.data.spec.name]
		if hook and hook.on[ev.data.kind] then
			hook.run(ev)
		end
	end,
})

require("options")
require("mappings")
require("autocmds")
