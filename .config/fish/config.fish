# Fish shell configuration
# Loaded on every shell launch (login and non-login).
# Plugin functions live in functions/, per-plugin config in conf.d/.

# Disable the default welcome message
set fish_greeting

# --- Interactive-only setup ---
if status is-interactive
    # Auto-install Fisher plugin manager on first launch
    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        fish -c fisher
    end

    # Override command color for readability in light/dark iTerm profiles
    if [ "$ITERM_PROFILE" = light ]
        set fish_color_command black --bold
    else
        set fish_color_command white --bold
    end

    # Use bat as a cat replacement
    abbr --add cat bat
end

# --- Brew prefix cache + config ---
# Cache brew --prefix in a universal variable to avoid ~200ms startup cost.
# Re-resolves if the cached directory no longer exists.
if not set -q __fish_brew_prefix; or not test -d "$__fish_brew_prefix"
    if type -q brew
        set -U __fish_brew_prefix (brew --prefix)
    end
end

if set -q __fish_brew_prefix
    fish_add_path "$__fish_brew_prefix/sbin"
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_PREFIX $__fish_brew_prefix
end

# --- PATH additions ---
fish_add_path "$HOME/.local/bin" /usr/local/sbin "$HOME/bin"

if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end

# Cache python3 user-base path (~73ms to compute) in a universal variable.
# Invalidated when python3 binary's mtime changes (e.g. brew upgrade).
if type -q pip3
    set -l py_bin (command -s python3)
    if not set -q __fish_python_user_base; or test (path mtime $py_bin) -gt (set -q __fish_python_user_base_mtime; and echo $__fish_python_user_base_mtime; or echo 0)
        set -U __fish_python_user_base (python3 -m site --user-base)
        set -U __fish_python_user_base_mtime (path mtime $py_bin)
    end
    fish_add_path "$__fish_python_user_base/bin"
end

# --- Environment variables ---
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
set -gx PSQL_PAGER "pspg -s 16"
set -gx EDITOR nvim
set -gx ERL_AFLAGS "-kernel shell_history enabled" # Enable arrow-key history recall in the Erlang shell
set -gx LANG en_US.UTF-8

# --- Zoxide ---
if type -q zoxide
    zoxide init fish | source
end

# --- Mise ---
# Strip the eager __mise_env_eval call from the activation script — it's
# already registered on fish_prompt, so deferring it to first-prompt time
# saves ~60ms.  Mise tools stay available during config via shims PATH.
if type -q mise
    mise activate fish | string match -v -r '^__mise_env_eval$' | source
    fish_add_path "$HOME/.local/share/mise/shims"
end

# --- Mix escripts ---
if type -q mix
    fish_add_path "$HOME/.mix/escripts"
end

# --- PostgreSQL ---
# Add the highest installed PostgreSQL version to PATH.
# Glob sorts naturally, so the last element gives the highest version.
if set -q __fish_brew_prefix
    set -l pg_dirs $__fish_brew_prefix/opt/postgresql@*/bin
    if set -q pg_dirs[1]
        fish_add_path $pg_dirs[-1]
    end
end

# --- Bat light theme (interactive-only) ---
# Placed after env vars section since it overrides BAT_CONFIG_PATH.
if status is-interactive; and test "$ITERM_PROFILE" = light
    set -gx BAT_CONFIG_PATH ~/.config/bat/config_theme_light
end
