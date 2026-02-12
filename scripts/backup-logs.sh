#!/bin/bash

# Log file backup script
# Usage: ./backup-logs.sh <destination_directory>

# Check if destination directory is provided
if [ $# -eq 0 ]; then
    echo "Error: No destination directory specified."
    echo "Usage: $0 <destination_directory>"
    exit 1
fi

DEST_DIR="$1"

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

# Define common log file locations
LOG_FILES=(
    "/var/log/syslog"
    "/var/log/messages"
    "/var/log/auth.log"
    "/var/log/dmesg"
    "/var/log/kern.log"
)

# Timestamp for backup files
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Counter for copied files
COPIED=0

# Copy log files to destination
for logfile in "${LOG_FILES[@]}"; do
    if [ -f "$logfile" ]; then
        filename=$(basename "$logfile")
        backup_name="${filename}_${TIMESTAMP}"
        
        if cp "$logfile" "${DEST_DIR}/${backup_name}"; then
            echo "✓ Copied: $logfile -> ${DEST_DIR}/${backup_name}"
            ((COPIED++))
        else
            echo "✗ Failed to copy: $logfile"
        fi
    fi
done

echo ""
echo "Backup complete: $COPIED log files copied to $DEST_DIR"
