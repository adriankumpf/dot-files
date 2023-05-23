local M = {}

function M.colorscheme()
  local iterm_profile = os.getenv("ITERM_PROFILE")

  if iterm_profile == "" then
    return "gruvbox"
  elseif iterm_profile == "light" then
    return "github_light"
  end
end

return M
