#!/usr/bin/env bash
# Polkit authentication agent launcher helper script
# Ensures polkit-kde agent runs under Hyprland without duplicate instances

if ! pgrep -f "polkit-kde-authentication-agent-1" > /dev/null; then
    if [ -f /usr/lib/polkit-kde-authentication-agent-1 ]; then
        /usr/lib/polkit-kde-authentication-agent-1 &
    elif [ -f /usr/libexec/polkit-kde-authentication-agent-1 ]; then
        /usr/libexec/polkit-kde-authentication-agent-1 &
    fi
fi
