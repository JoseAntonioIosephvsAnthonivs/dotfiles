#!/bin/bash

read -r cpu user nice system idle iowait irq softirq steal rest \
    < /proc/stat

TOTAL1=$((user + nice + system + idle + iowait + irq + softirq + steal))
IDLE1=$((idle + iowait))

sleep 0.5

read -r cpu user nice system idle iowait irq softirq steal rest \
    < /proc/stat

TOTAL2=$((user + nice + system + idle + iowait + irq + softirq + steal))
IDLE2=$((idle + iowait))

TOTAL=$((TOTAL2 - TOTAL1))
IDLE=$((IDLE2 - IDLE1))

if (( TOTAL > 0 )); then
    USAGE=$(( (TOTAL - IDLE) * 100 / TOTAL ))
else
    USAGE=0
fi

TEMP=$(sensors 2>/dev/null |
    awk '/Tctl:/ {gsub(/[+°C]/, "", $2); print $2; exit}')

if [[ -n "$TEMP" ]]; then
    printf ' %s%%   %s°C\n' "$USAGE" "$TEMP"
else
    printf ' %s%%   N/A\n' "$USAGE"
fi
