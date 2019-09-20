#!/usr/bin/env sh

set -e

subreddit="$1"
limit=50


reddit_api()
{
    curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" https://www.reddit.com/$1/$2/.json |
        jq -r --argjson limit $3 '.data | .children[:$limit] | .[].data.url'
}

usage()
{
    echo "Usage: $0 r/<subreddit> [-l <limit>] [-s <sort_by>]"
    exit 1
}


requires() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error: $0 requires $1, but it is not installed." >&2
        echo "Error: Aborting." >&2
        exit 1
    fi
}

requires curl >/dev/null
requires jq >/dev/null

echo "$subreddit" | grep -E 'r\/\w+' >/dev/null || usage

shift
while getopts "s:l:" opts; do
    case "${opts}" in
        s)
            sort="$OPTARG"
            ;;
        l)
            limit="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

reddit_api "$subreddit" "$sort" "$limit"

