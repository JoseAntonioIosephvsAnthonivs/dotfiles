#!/bin/bash

INTERFACE=$(ip route | awk '/default/ {print $5; exit}')

RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

sleep 1

RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

RX=$((RX2 - RX1))
TX=$((TX2 - TX1))

RX_KB=$((RX / 1024))
TX_KB=$((TX / 1024))

echo " ${RX_KB} KB/s   ${TX_KB} KB/s"
