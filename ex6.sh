#!/bin/bash

#Report file generator
FILENAME="$(echo "report$(date).txt" | tr -d ' ' | tee)"
CPU_NUM=$(lscpu | grep -m1 'CPU(s)' | tr -d ' ' | cut -d':' -f2)
FREE_RAM=$(grep 'MemFree:' /proc/meminfo | awk '{print $2 / 1024}')
TOTAL_RAM=$(grep 'MemTotal:' /proc/meminfo | awk '{print $2 / 1024}')
CPU_FREQ=$(lscpu | grep 'MHz' | tr -d ' ' | cut -d':' -f2)
echo "User: $(whoami)" >> "$FILENAME"

echo "Date: $(date)" >> "$FILENAME"

echo "Internal IP: $(hostname -I)" >> "$FILENAME"

echo "Hostname: $(hostname) " >> "$FILENAME"

echo "External IP: $(curl -s ifconfig.me ) " >> "$FILENAME"

echo "Linux version and distribution: $(uname -vs)" >> "$FILENAME"

echo "Uptime: $(uptime | cut -d ',' -f1)" >> "$FILENAME"

echo "CPU number: $CPU_NUM" >> "$FILENAME"
echo "CPU frequency: "$CPU_FREQ" " >> "$FILENAME"


echo "Total RAM: "$TOTAL_RAM" , Free RAM: "$FREE_RAM" " >> "$FILENAME"

