#!/usr/bin/env sh

set -e

. "$(dirname $0)/utils.sh"

usage() {
    echo "Usage: $0 /r/<subreddit>/comments/<article>/<title>/"
    exit 1
}

requires curl >/dev/null
requires jq >/dev/null
echo $1 | grep -E '/r/\w+/comments/\w+/\w+/' >/dev/null || usage

curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" "https://www.reddit.com$1.json" | jq -r '.[1] | .data.children[]'

