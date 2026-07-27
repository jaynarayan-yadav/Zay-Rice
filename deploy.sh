#!/usr/bin/env bash
# ==============================================================================
# MASTER DEPLOYMENT & BACKUP SCRIPT
# Deploys ZAY-RIce (Tokyo Night Synth) Arch Linux dotfiles with backup & safety.
# ==============================================================================

set -euo pipefail

RICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="${HOME}/.config/backup_rice_${TIMESTAMP}"

echo "======================================================================"
echo "         ZAY-RIce — TOKYO NIGHT SYNTH DEPLOYMENT TOOL"
echo "======================================================================"
echo ""

# Step 1: Audit Required Packages
echo "[1/4] Auditing system dependencies..."
REQUIRED_PKGS=("hyprland" "waybar" "wofi" "kitty" "dolphin" "swaync"
               "xdg-desktop-portal-hyprland" "polkit-kde-agent"
               "hyprpaper" "cliphist" "wl-clipboard" "playerctl"
               "nm-connection-editor" "pavucontrol" "blueman" "qt5ct")
OPTIONAL_PKGS=("wallust" "swww" "hyprlock" "hypridle" "foot"
               "hyprshot" "wlogout")
MISSING_PKGS=()
MISSING_OPT=()

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qs "^${pkg}$" >/dev/null 2>&1; then
        MISSING_PKGS+=("$pkg")
    fi
done

for pkg in "${OPTIONAL_PKGS[@]}"; do
    if ! pacman -Qs "^${pkg}$" >/dev/null 2>&1 && ! command -v "$pkg" >/dev/null 2>&1; then
        MISSING_OPT+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "[!] REQUIRED packages missing:"
    for pkg in "${MISSING_PKGS[@]}"; do echo "    - $pkg"; done
    echo "[!] Install: sudo pacman -S ${MISSING_PKGS[*]}"
    echo ""
else
    echo "[✓] All required packages present."
fi

if [ ${#MISSING_OPT[@]} -gt 0 ]; then
    echo "[~] Optional packages not installed (dynamic theming, screenshots, etc.):"
    for pkg in "${MISSING_OPT[@]}"; do echo "    - $pkg"; done
    echo "[~] Install optional (AUR): yay -S ${MISSING_OPT[*]}"
    echo ""
fi

# Cursor theme check
if ! ls /usr/share/icons/ 2>/dev/null | grep -qi bibata; then
    echo "[~] Cursor theme missing: yay -S bibata-cursor-theme"
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
echo "[✓] Backup complete at: ${BACKUP_DIR}"

# Step 3: Confirm before overwriting
echo ""
echo "[3/4] Ready to deploy ZAY-RIce configs to ~/.config"
echo "      This will OVERWRITE the modules listed above."
echo "      Rollback: cp -r ${BACKUP_DIR}/* ~/.config/ && hyprctl reload"
echo ""
read -rp "[?] Proceed with deployment? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted. Your existing configs are untouched."
    echo "Backup at ${BACKUP_DIR} can be safely deleted if not needed."
    exit 0
fi

# Deploy New Modular Configurations
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
echo "Next Steps:"
echo "  1. Log out and log back in (or reboot) to start Hyprland."
echo "  2. Run SDDM theme setup (optional): sudo bash ~/ZAY-RIce/sddm/setup_sddm.sh"
echo ""
echo "Verification after login:"
echo "  1. Reload Hyprland:        hyprctl reload"
echo "  2. Test Kitty opacity:     Super + Return  (should be 0.75)"
echo "  3. Test window move:       Super + Arrow"
echo "  4. Test minimize:          Super + M  (restore: Super + Shift + M)"
echo "  5. Switch wallpaper:       ~/.config/hypr/scripts/wallpaper.sh dark-figure-purple.png"
echo "  6. Verify portals:         pgrep -a xdg-desktop-portal"
echo "  7. Verify polkit:          pgrep -a polkit-kde"
echo ""
echo "Rollback Command (if needed):"
echo "  cp -r ${BACKUP_DIR}/* ~/.config/ && hyprctl reload"
echo "======================================================================"
