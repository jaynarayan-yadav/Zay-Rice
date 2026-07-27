#!/usr/bin/env bash
# ==============================================================================
# MASTER DEPLOYMENT & BACKUP SCRIPT
# Agent 5: System Reliability & Arch Maintenance Specialist
# Deploys Tokyo Night Synth Modular Arch Linux Rice with complete backup & safety
# ==============================================================================

set -euo pipefail

RICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="${HOME}/.config/backup_rice_${TIMESTAMP}"

echo "======================================================================"
echo "   TOKYO NIGHT SYNTH ARCH LINUX RICE DEPLOYMENT & BACKUP TOOL"
echo "======================================================================"
echo ""

# Step 1: Audit Required Packages
echo "[1/4] Auditing system dependencies..."
REQUIRED_PKGS=("hyprland" "waybar" "wofi" "kitty" "xdg-desktop-portal-hyprland" "polkit-kde-agent" "hyprpaper" "cliphist" "wl-clipboard" "playerctl" "nm-connection-editor" "pavucontrol" "blueman")
OPTIONAL_PKGS=("wallust" "swww" "hyprlock" "hypridle" "foot")
MISSING_PKGS=()
MISSING_OPT=()

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v "$pkg" >/dev/null 2>&1 && ! pacman -Qs "$pkg" >/dev/null 2>&1; then
        MISSING_PKGS+=("$pkg")
    fi
done

for pkg in "${OPTIONAL_PKGS[@]}"; do
    if ! command -v "$pkg" >/dev/null 2>&1 && ! pacman -Qs "$pkg" >/dev/null 2>&1; then
        MISSING_OPT+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "[!] REQUIRED packages missing:"
    for pkg in "${MISSING_PKGS[@]}"; do echo "    - $pkg"; done
    echo "[!] Install: sudo pacman -S ${MISSING_PKGS[*]}"
else
    echo "[✓] All required packages present."
fi

if [ ${#MISSING_OPT[@]} -gt 0 ]; then
    echo "[~] Optional packages not installed (dynamic theming, etc.):"
    for pkg in "${MISSING_OPT[@]}"; do echo "    - $pkg"; done
    echo "[~] Install optional: sudo pacman -S ${MISSING_OPT[*]}  (or via yay)"
fi

# Step 2: Backup Existing Configurations
echo ""
echo "[2/4] Backing up existing configurations to: ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}"

TARGET_MODULES=("appearance" "autostart" "hypr" "waybar" "wofi" "kitty" "vscode" "gtk-3.0" "gtk-4.0" "foot" "wallust")
for mod in "${TARGET_MODULES[@]}"; do
    if [ -d "${CONFIG_DIR}/${mod}" ] || [ -f "${CONFIG_DIR}/${mod}" ]; then
        echo "  -> Backing up ${mod}..."
        cp -rL "${CONFIG_DIR}/${mod}" "${BACKUP_DIR}/"
    fi
done
echo "[✓] Backup complete."

# Step 3: Deploy New Modular Configurations
echo ""
echo "[3/4] Deploying modular Tokyo Night Synth configurations..."
mkdir -p "${CONFIG_DIR}"

for mod_path in "${RICE_DIR}/dot_config"/*; do
    mod_name="$(basename "${mod_path}")"
    echo "  -> Installing ${mod_name} to ~/.config/${mod_name}..."
    rm -rf "${CONFIG_DIR}/${mod_name}"
    cp -r "${mod_path}" "${CONFIG_DIR}/${mod_name}"
done

# Step 4: Ensure Executable Permissions
chmod +x "${CONFIG_DIR}/autostart/environment.sh" 2>/dev/null || true
chmod +x "${CONFIG_DIR}/hypr/scripts"/*.sh 2>/dev/null || true

echo ""
echo "[✓] DEPLOYMENT SUCCESSFUL!"
echo "======================================================================"
echo "Verification Steps:"
echo "  1. Reload Hyprland:          hyprctl reload"
echo "  2. Test Kitty Opacity:       Super + Return (should be 0.75)"
echo "  3. Test Split Snap:          Super + Left / Right"
echo "  4. Test Minimize Taskbar:    Super + M"
echo "  5. Switch Wallpaper:         ~/.config/hypr/scripts/wallpaper.sh dark-figure-purple.png"
echo "  6. Verify Portals:           pgrep -a xdg-desktop-portal"
echo "  7. Verify Polkit (single):   pgrep -a polkit-kde"
echo ""
echo "Rollback Command (if needed):"
echo "  cp -r ${BACKUP_DIR}/* ~/.config/ && hyprctl reload"
echo "======================================================================"
