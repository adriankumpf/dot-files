local M = {}

M.colorscheme = function()
	if vim.o.background == "light" then
		return "github_light"
	else
		return "gruvbox"
	end
end

M.is_work_machine = function()
	return string.find(vim.fn.hostname(), "^Remote") ~= nil
end

-- Cache the result of "git rev-parse" to avoid repeated shell-outs
local is_inside_work_tree = {}

M.is_git_repo = function()
	local cwd = vim.fn.getcwd()

	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	return is_inside_work_tree[cwd]
end

return M
