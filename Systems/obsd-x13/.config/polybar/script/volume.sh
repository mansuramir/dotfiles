#!/bin/sh

vol_level=$(sndioctl -n output.level)
awk "BEGIN {printf \"%.0f\", $vol_level * 100}"
#echo "The percentage is: $percentage%"

