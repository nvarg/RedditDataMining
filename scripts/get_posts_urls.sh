#!/usr/bin/env sh

set -e
. ./utils.sh

subreddit="$1"
sortby="hot"
limit=50

reddit_api()
{
    curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" "https://www.reddit.com/$1/$2/.json" |
        jq -r --argjson limit $3 '.data.children[:$limit] | .[] | select(.kind=="t3") | .data.permalink'
}

usage()
{
    echo "Usage: $0 [-l <limit>] [-s <sort_by>]"
}

requires curl >/dev/null
requires jq >/dev/null
echo "$subreddit" | grep -E 'r\/\w+' >/dev/null || usage

shift
while getopts "s:l:" opts; do
    case "${opts}" in
        s)
            sortby="$OPTARG"
            ;;
        l)
            limit="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

reddit_api "$subreddit" "$sortby" "$limit"

