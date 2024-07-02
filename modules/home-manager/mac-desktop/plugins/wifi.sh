#!/bin/sh

if [ "$SENDER" = "wifi_change" ]; then

    STATUS=$(ifconfig en0 | awk '/status:/{print $2}')

    case $STATUS in
        active)
            ICON="󰖩"
            ;;
        inactive)
            ICON="󰖪"
    esac

    sketchybar --set "$NAME" icon="$ICON" label="$STATUS"
fi
