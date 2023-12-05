#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Використання: $0 <шлях_до_директорії> <текст>"
    exit 1
fi

directory="$1"
text="$2"

if [ ! -d "$directory" ]; then
    echo "Директорія не існує: $directory"
    exit 1
fi

grep -rl "$text" "$directory"
