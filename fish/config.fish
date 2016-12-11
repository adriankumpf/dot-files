set fish_greeting

### Program defaults ###

set -x PATH $HOME/.node/bin $PATH
set -x PATH /usr/local/bin $PATH

set -gx BROWSER open
set -gx VISUAL nvim
set -gx EDITOR nvim

set fish_color_command green --bold

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
