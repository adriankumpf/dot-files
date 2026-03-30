local M = {}

M.colorscheme = vim.env.ITERM_PROFILE == "light" and "github_light" or "gruvbox"

-- Cache keyed by cwd; never invalidated (acceptable for session lifetime)
local git_cache = {}

M.is_git_repo = function()
	local cwd = vim.fn.getcwd()

	if git_cache[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		git_cache[cwd] = vim.v.shell_error == 0
	end

	return git_cache[cwd]
end

return M
