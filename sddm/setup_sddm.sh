#!/usr/bin/env bash
# ==============================================================================
# SDDM Login Screen Configuration Script
# Installs the Tokyo Night Synth SDDM theme cleanly on Arch Linux.
# Run with: sudo bash sddm/setup_sddm.sh
# ==============================================================================

set -euo pipefail

SDDM_THEME_DIR="/usr/share/sddm/themes/tokyo-night-sddm"
SDDM_CONF_FILE="/etc/sddm.conf.d/theme.conf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[+] Setting up Tokyo Night SDDM Login Theme..."

if [ "$EUID" -ne 0 ]; then
    echo "[!] Root privileges required. Run with: sudo bash $0"
    exit 1
fi

# Ensure SDDM directories exist
mkdir -p /usr/share/sddm/themes
mkdir -p /etc/sddm.conf.d

# Copy only the theme files (not the install script itself)
mkdir -p "$SDDM_THEME_DIR"
cp "$SCRIPT_DIR/Main.qml"   "$SDDM_THEME_DIR/"
cp "$SCRIPT_DIR/theme.conf" "$SDDM_THEME_DIR/"

# Write system SDDM configuration
cat <<EOF > "$SDDM_CONF_FILE"
[Theme]
Current=tokyo-night-sddm
CursorTheme=Bibata-Modern-Classic
EOF

echo "[✓] SDDM Theme configured!"
echo "[✓] Test with: sddm-greeter --test-mode --theme $SDDM_THEME_DIR"
