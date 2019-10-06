#!/usr/bin/env sh

set -e
. ./utils.sh

subreddit="$1"
<<<<<<< HEAD
sortby="hot"
=======
sort=hot
>>>>>>> 54ac0c0e2b4936fbca677ac380c503e85558cf96
limit=50

reddit_api()
{
    curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" "https://www.reddit.com/$1/$2/.json" |
        jq -r --argjson limit $3 '.data.children[:$limit] | .[] | select(.kind=="t3") | .data.permalink'
}

usage()
{
    echo "Usage: $0 r/<subreddit> [-l <limit>] [-s <sort_by>]"
    exit 1
}

requires curl >/dev/null
requires jq >/dev/null
echo "$subreddit" | grep -E 'r\/\w+' >/dev/null || usage

# shifts argument so now $1 points to the next argument
shift

# getopts allows you define options
# while s option with : argument
# 1: $opts = s, $OPTARG gets the option argument
# 2: $opts = l
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

