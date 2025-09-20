#!/bin/sh

sysctl -n hw.sensors.cpu0.temp0 | cut -f 1 -d "."
