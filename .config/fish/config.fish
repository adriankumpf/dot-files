# Loaded on every shell launch (login and non-login).
# Plugin functions live in functions/, per-plugin config in conf.d/.

set -g fish_greeting

# --- Homebrew ---

# brew --prefix costs ~200ms, so cache it. Re-resolves if the directory is gone.
if not set -q __fish_brew_prefix; or not test -d "$__fish_brew_prefix"
    if command -q brew
        set -l prefix (brew --prefix)
        test -n "$prefix"; and set -U __fish_brew_prefix $prefix
    end
end

if set -q __fish_brew_prefix
    set -gx HOMEBREW_PREFIX $__fish_brew_prefix
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS 1

    fish_add_path -g $__fish_brew_prefix/bin $__fish_brew_prefix/sbin

    # Highest installed PostgreSQL. Fish sorts globs naturally, so the last
    # match is the newest version.
    set -l pg_bins $__fish_brew_prefix/opt/postgresql@*/bin
    set -q pg_bins[1]; and fish_add_path -g $pg_bins[-1]
end

# --- PATH ---

# -g is deliberate: the default writes to the universal fish_user_paths, where
# entries removed from this file linger in PATH forever. fish_add_path already
# skips directories that don't exist, so these need no guards.
fish_add_path -g $HOME/.local/bin $HOME/bin $HOME/.cargo/bin $HOME/.mix/escripts /usr/local/sbin

# python3 -m site --user-base costs ~73ms. Cache it until the binary changes.
if command -q python3
    set -l mtime (path mtime (command -s python3))
    if test "$mtime" != "$__fish_python_user_base_mtime"
        set -U __fish_python_user_base (python3 -m site --user-base)
        set -U __fish_python_user_base_mtime $mtime
    end
    fish_add_path -g $__fish_python_user_base/bin
end

# --- Environment ---

set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx PSQL_PAGER "pspg -s 16"
set -gx ERL_AFLAGS "-kernel shell_history enabled" # arrow-key history in iex

# --- Tools ---

if command -q zoxide
    zoxide init fish | source
end

# Strip the eager __mise_env_eval call out of the activation script. It is
# already registered on fish_prompt, so deferring it to first-prompt time saves
# ~60ms; mise tools stay available during config via the shims on PATH.
if command -q mise
    mise activate fish | string match -v -r '^__mise_env_eval$' | source
    fish_add_path -g $HOME/.local/share/mise/shims
end

# --- Interactive ---

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

    abbr --add cat bat

    if test "$ITERM_PROFILE" = light
        set fish_color_command black --bold
        set -gx BAT_THEME light
    else
        set fish_color_command white --bold
        set -gx BAT_THEME dark
    end
end
