fromstream(1|truncate_stream(inputs)) | recurse(.data.replies? | select(type == "object") | .data.children[]) | select(.kind == "t1") | .data | del(.replies)
