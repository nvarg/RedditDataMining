#!/usr/bin/env sh

set -e

requires() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error: $0 requires $1, but it is not installed." >&2
        echo "Error: Aborting." >&2
        exit 1
    fi
}

usage() {
    echo "Usage: $0 (http[s]://)reddit.com/r/<subreddit>/comments/<article>/<title>"
    exit 1
}

requires curl >/dev/null
requires jq >/dev/null

echo $1 | grep -E '(http[s]?:\/\/)?(www.)?reddit.com/r/\w+/comments/\w+/\w+/?' >/dev/null || usage

curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" $1/.json |
        jq -r  '.[1] | .data.children[]'

