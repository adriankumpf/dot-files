if test -d /opt/workbrew/bin
    fish_add_path /opt/workbrew/bin
end

if set -q __fish_brew_prefix; and test -d "$__fish_brew_prefix/share/google-cloud-sdk/bin"
    set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
    fish_add_path "$__fish_brew_prefix/share/google-cloud-sdk/bin"
end

if status is-interactive; and not set -q AWS_PROFILE
    set -gx AWS_PROFILE sts
end
