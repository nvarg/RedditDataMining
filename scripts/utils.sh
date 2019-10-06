#!/usr/bin/env sh

requires() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error: $0 requires $1, but it is not installed." >&2
        echo "Error: Aborting." >&2
        exit 1
    fi
}

