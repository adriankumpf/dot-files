# Fish shell configuration
# Loaded on every shell launch (login and non-login).
# Plugin functions live in functions/, per-plugin config in conf.d/.

# Disable the default welcome message
set fish_greeting

# --- Interactive-only setup ---
if status is-interactive
    # Bootstrap the fisher plugin manager on first launch. Downloading to a temp
    # file first keeps an HTTP error page from landing in functions/.
    if not functions -q fisher
        set -l tmp (mktemp)
        if curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o $tmp
            mkdir -p $__fish_config_dir/functions
            mv $tmp $__fish_config_dir/functions/fisher.fish
            source $__fish_config_dir/functions/fisher.fish
            fisher update
        else
            rm -f $tmp
            echo "fisher: download failed" >&2
        end
    end

    if test "$ITERM_PROFILE" = light
        set fish_color_command black --bold
        set -gx BAT_THEME light
    else
        set fish_color_command white --bold
        set -gx BAT_THEME dark
    end

    # Use bat as a cat replacement
    abbr --add cat bat
end

# --- Brew prefix cache + config ---
# Cache brew --prefix in a universal variable to avoid ~200ms startup cost.
# Re-resolves if the cached directory no longer exists.
if not set -q __fish_brew_prefix; or not test -d "$__fish_brew_prefix"
    if command -q brew
        set -l prefix (brew --prefix)
        test -n "$prefix"; and set -U __fish_brew_prefix $prefix
    end
end

if set -q __fish_brew_prefix
    fish_add_path -g "$__fish_brew_prefix/sbin"
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS 1
    set -gx HOMEBREW_PREFIX $__fish_brew_prefix
end

# --- PATH additions ---
fish_add_path -g "$HOME/.local/bin" /usr/local/sbin "$HOME/bin" "$HOME/.cargo/bin" "$HOME/.mix/escripts"

# python3 -m site --user-base costs ~73ms. Cache it until the binary changes.
if command -q python3
    set -l mtime (path mtime (command -s python3))
    if test "$mtime" != "$__fish_python_user_base_mtime"
        set -U __fish_python_user_base (python3 -m site --user-base)
        set -U __fish_python_user_base_mtime $mtime
    end
    fish_add_path -g "$__fish_python_user_base/bin"
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
    fish_add_path -g "$HOME/.local/share/mise/shims"
end

# --- PostgreSQL ---
# Add the highest installed PostgreSQL version to PATH.
# Glob sorts naturally, so the last element gives the highest version.
if set -q __fish_brew_prefix
    set -l pg_dirs $__fish_brew_prefix/opt/postgresql@*/bin
    if set -q pg_dirs[1]
        fish_add_path -g $pg_dirs[-1]
    end
end
