cat "$(dirname $0)/sublist" \
    | xargs -n1 -I'{}' "$(dirname $0)/scripts/get_posts_urls.sh" '{}' -s hot \
    | xargs -n1 "$(dirname $0)/scripts/get_comments.sh" \
    | jq --stream -nrfc "$(dirname $0)/scripts/flatten_comment_lists_streaming.jq" \
    > "$(dirname $0)/data/$(date +%m_%d_%Y.json)"

