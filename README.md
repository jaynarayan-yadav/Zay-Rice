# Tokyo Night Synth — Production-Grade Modular Arch Linux Rice & Installation Blueprint

An Arch Linux daily-driver workstation environment combining macOS visual polish, Windows snap/minimize ergonomics, Linux modularity, and GUI-first discoverability.

---

## 📁 Repository Layout

```
/home/zay/ricing/
├── dot_config/
│   ├── appearance/
│   │   ├── colors.conf                    # ⚡ Central palette (static OR auto-updated by Wallust)
│   │   ├── gtk-qt-theme.conf              # GTK 2/3/4 & Qt reference config
│   │   └── wallpapers/                    # 🖼️ All bundled wallpapers
│   │       ├── tokyo-lofi-cityscape.jpg   # Primary — Tokyo Night lofi rooftop scene
│   │       ├── dark-figure-purple.png     # Secondary — dark purple figure aesthetic
│   │       └── samurai-ghost-warrior.jpg  # Tertiary — samurai warrior with crows
│   ├── autostart/
│   │   └── environment.sh                 # Wayland envvars, portal isolation, polkit, cliphist
│   ├── hypr/
│   │   ├── hyprland.conf                  # Master file (sources sub-configs)
│   │   ├── hyprpaper.conf                 # Wallpaper loader (all 3 preloaded, IPC on)
│   │   ├── animations.conf                # 60fps+ bezier curves
│   │   ├── bindings.conf                  # Windows-style snapping & minimize keybindings
│   │   ├── monitors.conf                  # Display resolutions, Hz & scaling
│   │   ├── rules.conf                     # Opacity rules (Kitty & VSCode @ 0.75), dialog rules
│   │   └── scripts/
│   │       ├── polkit.sh                  # Safe polkit launcher
│   │       └── wallpaper.sh              # 🎨 Wallpaper switcher + Wallust dynamic palette
│   ├── wallust/
│   │   └── wallust.toml                   # Wallust color extraction settings
│   ├── waybar/
│   │   ├── config-top.jsonc               # Top bar (workspaces, mpris, hw monitors)
│   │   ├── config-dock.jsonc              # Vertical side dock (squircles + indicator dots)
│   │   └── style.css                      # Glassmorphism Tokyo Night + dock styling
│   ├── wofi/
│   │   ├── config                         # App launcher settings
│   │   └── style.css                      # Tokyo Night launcher stylesheet
│   ├── kitty/
│   │   └── kitty.conf                     # 0.75 opacity + JetBrainsMono NF + full palette
│   ├── foot/
│   │   └── foot.ini                       # Foot terminal config (0.75 alpha)
│   ├── vscode/
│   │   └── settings.json                  # VSCode UI theming (compositor handles 0.75 opacity)
│   ├── gtk-3.0/
│   │   └── settings.ini                   # GTK3 theme application
│   └── gtk-4.0/
│       └── settings.ini                   # GTK4 theme application
├── sddm/
│   ├── theme.conf                         # Tokyo Night SDDM theme config
│   ├── Main.qml                           # SDDM login screen QML template
│   └── setup_sddm.sh                      # SDDM theme installer script
├── deploy.sh                              # Automated install, backup & rollback tool
└── README.md                              # This file
```

---

## 📦 MISSING ASSET CHECKLIST — USER ACTION REQUIRED

These items are NOT generated and must be installed manually on your live system:

### 🔴 Required (Desktop won't fully work without these)

| # | What | Where to Install | How |
|---|------|-----------------|-----|
| 1 | **JetBrainsMono Nerd Font** | System fonts | `sudo pacman -S ttf-jetbrains-mono-nerd` |
| 2 | **Papirus / BeautyLine Icon Theme** | System icons | `sudo pacman -S papirus-icon-theme` or `yay -S beautyline` |
| 3 | **Bibata-Modern-Classic Cursor** | System cursors | `yay -S bibata-cursor-theme` |
| 4 | **TokyoNight-Dark GTK Theme** | GTK theme | `yay -S tokyonight-gtk-theme-git` |
| 5 | **JetBrainsMono Nerd Font in VSCode** | VSCode extension | Install `Tokyo Night` theme + `Material Icon Theme` extensions |

### 🟡 Optional (Dynamic theming, screen lock, etc.)

| # | What | How |
|---|------|-----|
| 6 | **Wallust** (dynamic palette from wallpaper) | `sudo pacman -S wallust` or `yay -S wallust-git` |
| 7 | **swww** (animated wallpaper transitions) | `sudo pacman -S swww` |
| 8 | **Hyprlock** (screen lock) | `sudo pacman -S hyprlock` |
| 9 | **Hypridle** (idle daemon) | `sudo pacman -S hypridle` |
| 10 | **cliphist** (clipboard manager) | `sudo pacman -S cliphist wl-clipboard` |
| 11 | **playerctl** (media controls in Waybar) | `sudo pacman -S playerctl` |

### 🟢 Already Bundled in This Repository

- ✅ All 3 wallpapers in `dot_config/appearance/wallpapers/`
- ✅ Tokyo Night Synth static palette in `dot_config/appearance/colors.conf`
- ✅ All Hyprland, Waybar, Wofi, Kitty, Foot, VSCode, GTK configs
- ✅ SDDM login theme template + installer script
- ✅ Automated `deploy.sh` with backup & rollback

---

## 🎨 Color Palette: Static vs. Dynamic — Full Explanation

### 1. Current State (Static Palette)
Your current setup uses a **fully static** Tokyo Night Synth palette. Colors are hardcoded in `~/.config/appearance/colors.conf`. The palette **does NOT automatically change** when you switch wallpapers.

### 2. Dynamic Integration with Wallust
When **Wallust** is installed, switching wallpapers via `wallpaper.sh` will:
1. Extract a 16-color palette from the new wallpaper image.
2. Overwrite `~/.config/appearance/colors.conf` with Wallust-generated colors.
3. Reload Hyprland to apply new active/inactive border colors.
4. Reload Waybar to apply new accent colors in the taskbar/dock.

**Switch wallpaper + regenerate palette:**
```bash
# To tokyo lofi (default — Tokyo Night Synth mood):
~/.config/hypr/scripts/wallpaper.sh tokyo-lofi-cityscape.jpg

# To dark purple figure (deep indigo mood):
~/.config/hypr/scripts/wallpaper.sh dark-figure-purple.png

# To samurai warrior (warm earthy tones):
~/.config/hypr/scripts/wallpaper.sh samurai-ghost-warrior.jpg
```

### 3. Opacity Rules Are Never Touched by Wallust
Wallust ONLY changes **palette colors** — it never modifies opacity values.
These are hardcoded in two places that Wallust does not touch:
- **Kitty**: `background_opacity 0.75` in `kitty.conf`
- **VSCode**: `windowrulev2 = opacity 0.75 override 0.75` in `rules.conf`

---

## 🚀 Arch Linux + Hyprland Setup Blueprint

### SECTION 1: Creating the Bootable USB Drive
#### On Windows
1. Download official Arch Linux ISO from `archlinux.org/download`.
2. Open Rufus, insert USB drive (8GB+).
3. Set Target System to **UEFI (non-CSM)** → click **START** in DD Image Mode.

#### On Linux/macOS
```bash
sudo dd status=progress bs=4M if=path/to/archlinux.iso of=/dev/sdX conv=fsync
```

---

### SECTION 2: Installing Base Arch Linux
1. Boot from USB (disable Secure Boot in BIOS).
2. Connect to Wi-Fi: `iwctl` → `station wlan0 connect YOUR_SSID`
3. Run: `archinstall` → Select: BTRFS or EXT4, Pipewire, NetworkManager, Minimal profile.
4. Reboot: `reboot`

---

### SECTION 3: Core Packages
```bash
sudo pacman -Syu git base-devel networkmanager pipewire pipewire-pulse pipewire-alsa wireplumber sddm
sudo systemctl enable --now NetworkManager sddm

sudo pacman -S hyprland waybar kitty wofi dolphin hyprpaper hyprlock hypridle \
    qt5-wayland qt6-wayland xdg-desktop-portal-hyprland polkit-kde-agent \
    swww cliphist wl-clipboard playerctl pavucontrol blueman nm-connection-editor \
    ttf-jetbrains-mono-nerd papirus-icon-theme

# AUR helper
cd ~ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ~ && rm -rf yay

# AUR packages
yay -S visual-studio-code-bin wallust-git bibata-cursor-theme tokyonight-gtk-theme-git beautyline
```

---

### SECTION 4: Deploy This Repository
```bash
git clone https://github.com/YOUR_USERNAME/ricing.git ~/ricing
~/ricing/deploy.sh
```

---

### SECTION 5: Verification Checklist
```bash
# Reload Hyprland
hyprctl reload

# Verify portals (should see exactly 2 processes)
pgrep -a xdg-desktop-portal

# Verify polkit (should see exactly 1 process)
pgrep -a polkit-kde

# Test opacity (open Kitty — should be 0.75)
# Super + Return

# Test split snap
# Open 2 windows → Super + Left / Super + Right

# Test minimize
# Super + M → click app icon in dock/taskbar to restore

# Switch wallpaper + dynamic palette
~/.config/hypr/scripts/wallpaper.sh dark-figure-purple.png
```
