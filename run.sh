#!/bin/bash

PIDS=()

cleanup() {
    for pid in "${PIDS[@]}"; do
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid" &>/dev/null
        fi
    done
    wait
    exit 0
}

trap cleanup SIGINT

rcsoccersim &> /dev/null &
SERVER_PID=$!
PIDS+=("$SERVER_PID")

sleep 2

./helios-base/src/start.sh &> /dev/null &
PIDS+=("$!")

./helios-base/src/start2.sh &> /dev/null &
PIDS+=("$!")


wait
