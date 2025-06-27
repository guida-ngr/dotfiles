#!/bin/bash

power_status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ $power_status == "yes" ]]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
