#!/usr/bin/env bash
# ==============================================================================
# PURE HYPRLAND SESSION — Wayland Environment & Autostart
# Sets environment variables and starts required background services.
# Services: xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk,
#           polkit-kde-authentication-agent-1, cliphist clipboard manager
#
# NOTE on polkit-kde-authentication-agent-1:
#   This is a STANDALONE binary from the polkit-kde-agent package.
#   It does NOT require KDE Plasma or kwin.
#   Alternative agents: lxqt-policykit, mate-polkit
# ==============================================================================

# --- Session Identity ---
export XDG_CURRENT_DESKTOP="Hyprland"
export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="Hyprland"

# --- Toolkit Wayland Backends ---
export GDK_BACKEND="wayland,x11,*"
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR="1"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export SDL_VIDEODRIVER="wayland"
export CLUTTER_BACKEND="wayland"
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# --- Rendering & Wayland Compat ---
export MOZ_ENABLE_WAYLAND="1"
export _JAVA_AWT_WM_NONREPARENTING="1"
export XCURSOR_SIZE="24"
export HYPRCURSOR_SIZE="24"

# --- D-Bus session registration ---
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE 2>/dev/null || true
fi

# --- Desktop Portal Initialization ---
# Kill stale portals from a previous session then restart cleanly
pkill -f "xdg-desktop-portal" 2>/dev/null || true
sleep 0.5

# Start Hyprland-specific portal
if [ -f /usr/lib/xdg-desktop-portal-hyprland ]; then
    /usr/lib/xdg-desktop-portal-hyprland &
elif [ -f /usr/libexec/xdg-desktop-portal-hyprland ]; then
    /usr/libexec/xdg-desktop-portal-hyprland &
fi
sleep 0.8

# Start GTK portal (handles file-pickers in pure Hyprland)
if [ -f /usr/lib/xdg-desktop-portal-gtk ]; then
    /usr/lib/xdg-desktop-portal-gtk &
elif [ -f /usr/libexec/xdg-desktop-portal-gtk ]; then
    /usr/libexec/xdg-desktop-portal-gtk &
fi
sleep 0.3

# Start main portal dispatcher
/usr/lib/xdg-desktop-portal &

# --- Polkit Agent (standalone, no KDE DE dependency) ---
if ! pgrep -f "polkit-kde-authentication-agent-1" >/dev/null; then
    for agent_path in \
        /usr/lib/polkit-kde-authentication-agent-1 \
        /usr/libexec/polkit-kde-authentication-agent-1 \
        /usr/lib/kde4/libexec/polkit-kde-authentication-agent-1; do
        if [ -f "$agent_path" ]; then
            "$agent_path" &
            break
        fi
    done
fi

# --- Clipboard Manager (single instance) ---
if command -v cliphist >/dev/null 2>&1 && ! pgrep -f "cliphist store" >/dev/null; then
    wl-paste --type text  --watch cliphist store &
    wl-paste --type image --watch cliphist store &
fi
