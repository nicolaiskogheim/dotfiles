#### AV-specific stuff

# Load the Google Cloud SDK and its completions.
gcloud_sdk_dir="$HOME/bin/google-cloud-sdk"

if [[ -f "$gcloud_sdk_dir/path.zsh.inc" ]]; then
    source "$gcloud_sdk_dir/path.zsh.inc"
fi

if [[ -f "$gcloud_sdk_dir/completion.zsh.inc" ]]; then
    source "$gcloud_sdk_dir/completion.zsh.inc"
fi

unset gcloud_sdk_dir

eval "$(direnv hook zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C vault vault
