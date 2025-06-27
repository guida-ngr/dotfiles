#!/bin/bash

MONITOR_NAME="HDMI-2"
POLYBAR_INSTANCE="main"

while true; do
    fullscreen=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 | xargs -I{} xprop -id {} _NET_WM_STATE | grep _NET_WM_STATE_FULLSCREEN)

    if [[ -n "$fullscreen" ]]; then
        polybar-msg -p $(pgrep -f "polybar $POLYBAR_INSTANCE") cmd hide
    else
        polybar-msg -p $(pgrep -f "polybar $POLYBAR_INSTANCE") cmd show
    fi

    sleep 1
done
