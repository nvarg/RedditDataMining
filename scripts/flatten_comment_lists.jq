map(
    recurse(.data.replies?  | select(type == "object") | .data.children[])
    | select(.kind == "t1") | .data | del(.replies)
)

