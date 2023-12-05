#!/bin/bash

while getopts ":p:s:" opt; do
    case $opt in
    p) path="$OPTARG";;
    s) search_text="$OPTARG";;
    \?) echo "Невідомий ключ: -$OPTARG" >&2
        exit 1;;
    :) echo "Параметр відсутній для ключа: -$OPTARG" >&2
    exit 1;;
    esac
done

if [ -z "$path" ] || [ -z "$search_text" ]; then
    echo "Використання: $0 -p <шлях до директорії> -s <текст для пошуку>"
    exit 1
fi

if [ ! -d "$path" ]; then
    echo "Директорія не існує: $path"
    exit 1
fi

grep -rl "$search_text" "$path"
