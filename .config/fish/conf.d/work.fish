fish_add_path -g /opt/workbrew/bin

if test -d "$__fish_brew_prefix/share/google-cloud-sdk/bin"
    set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
    fish_add_path -g "$__fish_brew_prefix/share/google-cloud-sdk/bin"
end

if status is-interactive; and not set -q AWS_PROFILE
    set -gx AWS_PROFILE sts
end
