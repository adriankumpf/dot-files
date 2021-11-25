local map = require('config.utils').map

local fzf = require('fzf-lua')
fzf.setup {
  winopts = {
    preview = {
      default = 'bat',
    },
  },
  files = {
    git_icons = false,
    file_icons = false,
  },
   git = {
    files = {
      cmd = 'git ls-files --exclude-standard --cached --others',
    }
  },
  previewers = {
    bat = {
      args = "--style=numbers,changes --color always",
    },
  },
}

function _G.project_files()
  if fzf.path.is_git_repo(vim.loop.cwd(), true) then
    fzf.git_files()
  else
    fzf.files()
  end
end

map("n", "<leader>f", [[<cmd>lua project_files()<cr>]])
map("n", "<leader>r", [[<cmd>FzfLua live_grep_native<cr>]])
map("n", "<leader>la", [[<cmd>FzfLua lsp_code_actions<cr>]])
map("n", "<leader>lr", [[<cmd>FzfLua lsp_references<cr>]])

map("n", ",S", [[<cmd>FzfLua grep_cword<cr>]])
