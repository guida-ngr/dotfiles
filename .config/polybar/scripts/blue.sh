#!/bin/bash

COLOR_CONNECTED_ICON="#a9ddea"
COLOR_DISCONNECTED_ICON="#5b5e5c"
COLOR_TEXT_DEVICE_NAME="#a9ddea"
COLOR_OFF="#a9ddea"

ICON_ON="󰂯"
ICON_OFF="󰂲"

BLUETOOTHCTL="/usr/bin/bluetoothctl"
GREP="/usr/bin/grep"
AWK="/usr/bin/awk"
HEAD="/usr/bin/head"
PGREP="/usr/bin/pgrep"

BLUETOOTH_POWER_STATUS=$($BLUETOOTHCTL show | $GREP "Powered" | $AWK '{print $2}')
CONNECTED_DEVICES=$($BLUETOOTHCTL devices Connected | $AWK '{print $2}')
OUTPUT=""
if [ "$BLUETOOTH_POWER_STATUS" == "yes" ]; then
    if [ -n "$CONNECTED_DEVICES" ]; then
        FIRST_DEVICE_MAC=$(echo "$CONNECTED_DEVICES" | $HEAD -n 1)
        CONNECTED_DEVICE_NAME=$($BLUETOOTHCTL info "$FIRST_DEVICE_MAC" | $GREP "Name" | $AWK '{print $2}')

        OUTPUT="%{F$COLOR_CONNECTED_ICON}$ICON_ON%{F-}%{F$COLOR_TEXT_DEVICE_NAME} $CONNECTED_DEVICE_NAME%{F-}"
    else
        OUTPUT="%{F$COLOR_DISCONNECTED_ICON}$ICON_ON%{F-}"
    fi
else
    OUTPUT="%{F$COLOR_OFF}$ICON_OFF%{F-}"
fi
echo "DEBUG: Output string: $OUTPUT" > /tmp/polybar_bluetooth_debug.log
echo "$OUTPUT"
