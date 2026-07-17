local M = {}

M.colorscheme = vim.env.ITERM_PROFILE == "light" and "github_light" or "gruvbox"

-- vim.pack.add without the confirmation prompt
M.pack_add = function(specs)
	vim.pack.add(specs, { confirm = false })
end

-- Avoid shelling out to git; walk upward until a .git directory is found.
M.is_git_repo = function(path)
	local root = vim.fs.root(path or vim.uv.cwd() or vim.fn.getcwd(), ".git")
	return root ~= nil
end

return M
