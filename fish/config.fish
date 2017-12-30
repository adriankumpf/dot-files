set fish_greeting
set fish_color_command white --bold

set -g fish_user_paths "/usr/local/opt/bison/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/flex/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths

set -gx BROWSER "firefox"
set -gx EDITOR "nvim"
set -gx ERL_AFLAGS "-kernel shell_history enabled"
