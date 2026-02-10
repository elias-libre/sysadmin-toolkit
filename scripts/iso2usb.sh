#!/bin/bash

# Verify root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Display available drives
lsblk -d -o NAME,SIZE,MODEL,TRAN | grep -v '^loop'
echo ""

# Get user input
read -p "Enter ISO file path: " iso_path
read -p "Enter target device (e.g. sdx): " target

# Validate inputs
if [ ! -f "$iso_path" ]; then
    echo "ISO file not found"
    exit 1
fi

if [[ ! "$target" =~ ^sd[a-z]$ ]]; then
    echo "Invalid device format"
    exit 1
fi

# Safety confirmation
read -p "WARNING: This will DESTROY ALL DATA on /dev/${target}. Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Unmount any partitions
for partition in /dev/${target}[0-9]*; do
    if mount | grep -q "$partition"; then
        umount "$partition" || true
    fi
done

# Write ISO with progress
echo "Writing ISO to device..."
dd if="$iso_path" of="/dev/${target}" bs=4M status=progress

# Sync and finish
sync
echo "Operation complete - safely remove device"