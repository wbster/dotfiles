[[ -s ~/.bash_functions.local ]] && . ~/.bash_functions.local
mkcd() {
    mkdir -p "$1" && cd "$1"
}

tmpcd() {
    local tmpdir=$(mktemp -d)
    cd "$tmpdir"
}

notify() {
    local title="${1:-System}"
    local msg="${2:-Task done}"
    local urgency="${3:-normal}"

    if command -v notify-send >/dev/null; then
        notify-send -u "$urgency" -a "Terminal" "$title" "$msg"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        notify-send "$title" "$msg"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e "display notification \"$msg\" with title \"$title\""
    else
        echo "$title: $msg" # fallback
    fi
}