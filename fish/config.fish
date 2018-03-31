set fish_greeting

set fish_color_command white --bold

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/bin" $fish_user_paths

if type -q cargo
  set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
end

if test -x go
  set -gx GOPATH (go env GOPATH)
  set -g fish_user_paths "$GOPATH/bin" $fish_user_paths
  set -g fish_user_paths "/usr/local/opt/go/libexec/bin" $fish_user_paths
end

if type -q fd
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
end

if type -q cabal
  set -g fish_user_paths "$HOME/Library/Haskell/bin" $fish_user_paths
end


set -gx BROWSER "firefox"
set -gx EDITOR "nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"

alias nvim="env MIX_ENV=test nvim"
