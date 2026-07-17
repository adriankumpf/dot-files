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
	["markdown-preview.nvim"] = { on = { install = true, update = true }, run = function(ev)
		ensure_loaded(ev)
		vim.fn["mkdp#util#install"]()
	end },
}

local pack_group = vim.api.nvim_create_augroup("pack_hooks", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
	group = pack_group,
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
require("filetypes")
