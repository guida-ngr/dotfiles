#!/bin/bash

if pgrep -x "blueman-manager" > /dev/null
then
    killall blueman-manager
else
    nohup blueman-manager > /dev/null 2>&1 &
fi
