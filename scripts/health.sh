#! /bin/bash

echo "Disk Usage:"
df -h | grep -E '^(Filesystem|/dev/)'
echo

echo "Memory Usage:"
free -h
echo

echo "CPU Load:"
uptime
echo

echo "IP"
ip addr show
echo

echo "System Load Averages:"
cat /proc/loadavg