#!/usr/bin/env sh

tmpdir=$(mktemp -t reddit.XXXXX)
trap "rm $tmpdir -R" INT QUIT TERM EXIT

while read subreddit; do
    echo "Reading posts from /$subreddit."
    for post in $($(dirname $0)/scripts/get_posts_urls.sh $subreddit -s hot); do
        ($(dirname $0)/scripts/get_comments.sh $post \
            > $tmpdir/$(basename $post) &)
    done
done < "$(dirname $0)/sublist"
echo "Working..."
wait

for tmp in $tmpdir/*; do
    jq --stream -nrfc \
        "$(dirname $0)/scripts/flatten_comment_lists_streaming.jq" "$tmp" \
        >> "$(dirname $0)/data/$(date +%m_%d_%Y_test.json)"
done
echo "Done."

