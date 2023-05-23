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

fish_add_path "$HOME/.local/bin"
fish_add_path "/usr/local/sbin"
fish_add_path "/opt/homebrew/sbin"
fish_add_path "$HOME/bin"

if test -d "$HOME/.cargo/bin"
  fish_add_path "$HOME/.cargo/bin"
end

if type -q pip3
  fish_add_path "$HOME/Library/Python/3.9/bin"
end

if type -q rg
  set -x RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
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

if type -q pspg
  set -x PSQL_PAGER "pspg -s 16"
end

if type -q go
  set -gx GOPATH $HOME/go
  set -gx GOROOT /usr/local/opt/go/libexec
  fish_add_path $GOPATH/bin
  fish_add_path $GOROOT/bin
end

if type -q brew
  set -gx HOMEBREW_NO_GOOGLE_ANALYTICS 1
end

if type -q xcode-select
  set -gx DYLD_FALLBACK_LIBRARY_PATH (xcode-select --print-path)/usr/lib/
end

if type -q bat and test "$ITERM_PROFILE" = "light"
  set -gx BAT_CONFIG_PATH ~/.config/bat/config_theme_light
end

if test -d "$(brew --prefix)/share/google-cloud-sdk"
  source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
  set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
end

if test -d "$(brew --prefix)/opt/asdf"
  # Instruct kerl to build Erlang documentation
  set -xg KERL_BUILD_DOCS yes
  set -xg KERL_INSTALL_HTMLDOCS no
  set -xg KERL_INSTALL_MANPAGES no
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end
