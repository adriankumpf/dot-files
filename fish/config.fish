set fish_greeting

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if [ "$ITERM_PROFILE" = "light" ]
  set fish_color_command black --bold
else
  set fish_color_command white --bold
end

set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/bin" $PATH

if type -q cargo
  set -x PATH "$HOME/.cargo/bin" $PATH
end

if type -q pip3
  set -x PATH "$HOME/Library/Python/3.7/bin" $PATH
end

if type -q fd
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
end

if type -q cabal
  set -x PATH "$HOME/Library/Haskell/bin" $PATH
end


if test -d /usr/local/opt/llvm/bin
  set -x PATH "/usr/local/opt/llvm/bin" $PATH
end

if test -d ~/.cargo/bin
  set -x PATH "$HOME/.cargo/bin" $PATH
end

set -gx EDITOR "nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx LANG en_US.UTF-8
