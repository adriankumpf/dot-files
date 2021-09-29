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

fish_add_path "/usr/local/sbin"
fish_add_path "$HOME/bin"

if type -q cargo
  fish_add_path "$HOME/.cargo/bin"
end

if type -q pip3
  fish_add_path "$HOME/Library/Python/3.9/bin"
end

if type -q rg
  set -x RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
end

if type -q fd
  set -gx FZF_DEFAULT_COMMAND "fish -c 'begin; git ls-tree -r --name-only HEAD; git ls-files --others --exclude-standard; git diff --name-only --staged; end | sort -u || fd --type f --type l --hidden --follow --exclude .git' 2> /dev/null"
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -gx FZF_DEFAULT_OPTS "--no-mouse -1 --multi --info=inline"
end

set -gx EDITOR "nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx LANG en_US.UTF-8

if type -q zoxide
  zoxide init fish | source
end

if type -q mix
  fish_add_path "$HOME/.mix/escripts"
end

if type -q go
  set -gx GOPATH $HOME/go
  set -gx GOROOT /usr/local/opt/go/libexec
  fish_add_path $GOPATH/bin
  fish_add_path $GOROOT/bin
end

set -gx DYLD_FALLBACK_LIBRARY_PATH (xcode-select --print-path)/usr/lib/
set -g fish_user_paths "/usr/local/opt/node@14/bin" $fish_user_paths
