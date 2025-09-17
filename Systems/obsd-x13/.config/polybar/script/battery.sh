#!/usr/local/bin/bash

#BAT_INFO=$(acpi -b)
#BAT=$(echo "$BAT_INFO" | grep -E -o '[0-9]+%' | head -1)
#BAT_VALUE=${BAT%?}  
# Remove the '%' sign
BAT_VALUE=$(apm -l)

FULL_ICON="󰁹" #"   "  
# Full battery
MEDIUM_ICON="󰁿" #"   "  
# Medium battery
QUARTER_ICON="󰁼" #"   "  
# Quarter battery
EMPTY_ICON="󰂎" #"   "  
# Empty battery
CHARGING_ICON="󱊦" #"󱐋"  
# Charging icon

foreground="#C5C8C6"

#CHARGING_STATUS=$(echo "$BAT_INFO" | grep -o 'Charging')
CHARGING_STATUS=$(apm -a)

if [ "$CHARGING_STATUS" = "1" ]; then
    ICON="$CHARGING_ICON"
    COLOR="#00cccc"
elif [ "$BAT_VALUE" -gt 80 ]; then
    ICON="$FULL_ICON"
    COLOR="#00cccc"  
# Purple color
elif [ "$BAT_VALUE" -gt 60 ] && [ "$BAT_VALUE" -le 80 ]; then
    ICON="$MEDIUM_ICON"
    COLOR="#00cccc"  
# Purple color
elif [ "$BAT_VALUE" -gt 35 ] && [ "$BAT_VALUE" -le 60 ]; then
    ICON="$QUARTER_ICON"
    COLOR="#cc0088"  
# Warning color
elif [ "$BAT_VALUE" -gt 20 ] && [ "$BAT_VALUE" -le 35 ]; then
    ICON="$QUARTER_ICON"
    COLOR="#cc0022"  
# Red-ish color
elif [ "$BAT_VALUE" -le 20 ]; then
    ICON="$EMPTY_ICON"
    COLOR="#880000"  
# Red color for empty battery
    URGENT=33  
# Urgent flag
# else
#    ICON="$QUARTER_ICON"  # Fallback icon
#    COLOR="#ff00ff"  # Default color
fi

# Full and short texts
FULL_TEXT="$ICON $BAT_VALUE% "
#SHORT_TEXT="BAT: $BAT"

# Output
#echo "$FULL_TEXT"
#echo "$SHORT_TEXT "
echo -n "%{F$COLOR}"
echo -n "$ICON "
echo -n "%{F$foreground}"
echo "$BAT_VALUE%"

#[ -n "$URGENT" ] && exit "$URGENT"

exit 0
