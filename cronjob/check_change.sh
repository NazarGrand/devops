#!/bin/bash

LOG_FILE="/var/log/my-app.log"

REDIS_KEY="my_app_info"

if [ -f "$LOG_FILE" ]; then
    FILE_SIZE=$(stat -c %s "$LOG_FILE")
    LAST_MODIFIED=$(stat -c %Y "$LOG_FILE")

    PREVIOUS_SIZE=$(redis-cli HGET "$REDIS_KEY" size 2>/dev/null)
    PREVIOUS_MODIFIED=$(redis-cli HGET "$REDIS_KEY" last_modified 2>/dev/null)

    if [ "$FILE_SIZE" -ne "$PREVIOUS_SIZE" ] || [ "$LAST_MODIFIED" -ne "$PREVIOUS_MODIFIED" ]; then
        echo "Зміни виявлені:"
        echo "Старий розмір: $PREVIOUS_SIZE, Новий розмір: $FILE_SIZE"
        
        OLD_TIME=$(date -d @$PREVIOUS_MODIFIED +"%T")
        NEW_TIME=$(date -d @$LAST_MODIFIED +"%T")
        echo "Старий час останньої зміни: $OLD_TIME, Новий час останньої зміни: $NEW_TIME"

        redis-cli HMSET "$REDIS_KEY" size "$FILE_SIZE" last_modified "$LAST_MODIFIED"

        echo "Інформація записана в Redis."
    else
        echo "Файл не змінився."
    fi
else
    echo "Файл не існує."
fi
