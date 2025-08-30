#!/bin/sh

sysctl hw.sensors.cpu0.temp0 | cut -d " " -f1 | cut -d "=" -f2 | cut -d "." -f1

