#!/bin/sh
echo -ne '\033c\033]0;GhostFish\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/smilewideclyde.x86_64" "$@"
