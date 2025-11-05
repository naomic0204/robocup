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

for i in {1..11}; do
    echo "(init MyTeam (version 19))" | rcssclient &> /dev/null &
    PIDS+=("$!")
done

for i in {1..11}; do
    echo "(init YourTeam (version 19))" | rcssclient &> /dev/null &
    PIDS+=("$!")
done


wait
