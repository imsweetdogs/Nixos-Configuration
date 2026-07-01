#!/usr/bin/env bash
set -e
for host in "$(dirname "$0")"/*/; do
    host=$(basename "$host")
    for test in "$(dirname "$0")/$host"/test_*/default.nix; do
        [ -f "$test" ] || continue
        name="$host/$(basename "$(dirname "$test")")"
        echo "=== $name ==="
        nix eval --impure -f "$test" 2>&1
        echo
    done
done
