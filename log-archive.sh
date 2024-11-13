#!/bin/bash

# Check if log director argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

# Variables
LOG_DIR="$1"
ARCHIVE_DIR="archive"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
ARCHIVE_NAME="log_archive_$TIMESTAMP.tar.gz"
LOG_FILE="archive_log.txt"

# Check if the specified log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: directory $LOG_DIR does not exist."
    exit 1
fi

# Create the archive directory if it doesn't exists
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir "$ARCHIVE_DIR"
    echo "Created directory: $ARCHIVE_DIR"
fi

# Compress the logs into the archive
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .
if [ $? -eq 0 ]; then
    echo "Log archived at: $ARCHIVE_DIR/$ARCHIVE_NAME"
else
    echo "Error: Failed to create archive."
    exit 1
fi

echo "$(date "+%Y-%m-%d %H-%M-%S") - Archive created: $ARCHIVE_DIR/$ARCHIVE_NAME" >> "$LOG_FILE"
echo "Archive details logged in: $LOG_FILE"
