local M = {}

function M.colorscheme()
	local iterm_profile = os.getenv("ITERM_PROFILE")

	if iterm_profile == "light" then
		return "github_light"
	else
		return "gruvbox"
	end
end

return M
