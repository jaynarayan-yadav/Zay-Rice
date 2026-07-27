#!/usr/bin/env bash
# ==============================================================================
# SDDM Login Screen Configuration Script
# Agent 5: System Reliability Specialist & Agent 2: Theme Specialist
# Installs and configures Tokyo Night Synth SDDM Theme cleanly on Arch Linux
# ==============================================================================

set -euo pipefail

SDDM_THEME_DIR="/usr/share/sddm/themes/tokyo-night-sddm"
SDDM_CONF_FILE="/etc/sddm.conf.d/theme.conf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[+] Setting up Tokyo Night SDDM Login Theme..."

if [ "$EUID" -ne 0 ]; then
    echo "[!] Note: Root privileges (sudo) required to install SDDM theme system-wide."
    echo "[!] Run this script with: sudo bash $0"
    exit 1
fi

# Ensure SDDM directories exist
mkdir -p /usr/share/sddm/themes
mkdir -p /etc/sddm.conf.d

# Copy theme directory
mkdir -p "$SDDM_THEME_DIR"
cp -r "$SCRIPT_DIR"/* "$SDDM_THEME_DIR"/ 2>/dev/null || true

# Generate system SDDM configuration
cat <<EOF > "$SDDM_CONF_FILE"
[Theme]
Current=tokyo-night-sddm
CursorTheme=Bibata-Modern-Classic
EOF

echo "[✓] SDDM Theme successfully configured! Test with: sddm-greeter --test-mode --theme $SDDM_THEME_DIR"
