# 🌌 ZAY-RIce
**Production-Grade Modular Arch Linux Hyprland Workstation**

![License](https://img.shields.io/github/license/jaynarayan-yadav/ZAY-RIce?style=flat-square&color=f70068)
![Stars](https://img.shields.io/github/stars/jaynarayan-yadav/ZAY-RIce?style=flat-square&color=00e5ff)
![Hyprland](https://img.shields.io/badge/Hyprland-latest-blueviolet?style=flat-square)
![Arch Linux](https://img.shields.io/badge/Arch%20Linux-rolling-1793d1?style=flat-square&logo=archlinux)

A standalone Arch Linux Hyprland workstation with a unified Tokyo Night Synth aesthetic. macOS-level visual polish, Windows-style window management, and full Wayland compliance — zero KDE Plasma dependencies.

---

## ✨ Features
- **Dynamic Theming** — Wallust extracts a 16-color palette from any wallpaper and reloads everything instantly
- **Vertical Side Dock** — Squircle app buttons with neon-pink active and cyan running indicators
- **Top Status Bar** — Workspace pills, window title, MPRIS media, CPU/RAM/temp, clock, tray
- **Compositor Opacity** — Kitty and VSCode at 0.75 opacity; auth dialogs always opaque
- **Silent Boot** — SDDM login screen with custom Tokyo Night theme
- **Safe Deployment** — `deploy.sh` backs up your existing configs before touching anything

## 📸 Screenshots
*(Add your screenshots here!)*

---

## ⚡ Quick Install

> **Prerequisites:** Arch Linux with Hyprland, `git`, and the packages below installed.

```bash
git clone https://github.com/jaynarayan-yadav/ZAY-RIce.git ~/ZAY-RIce
bash ~/ZAY-RIce/deploy.sh
```

The deploy script will check for missing packages, back up your existing configs, ask for confirmation, then apply everything.

---

## 📦 Required Packages

```bash
# Core (pacman)
sudo pacman -S hyprland waybar wofi kitty dolphin swaync hyprpaper \
    xdg-desktop-portal-hyprland polkit-kde-agent qt5ct \
    cliphist wl-clipboard playerctl pavucontrol blueman nm-connection-editor \
    ttf-jetbrains-mono-nerd papirus-icon-theme

# AUR (via yay)
yay -S wallust-git hyprlock hypridle hyprshot wlogout \
    bibata-cursor-theme tokyonight-gtk-theme-git beautyline

# Optional animated wallpapers
sudo pacman -S swww
```

> **Note on `polkit-kde-agent`:** The `polkit-kde-authentication-agent-1` binary is a **standalone** authentication popup. It does NOT require KDE Plasma or kwin to be installed. It's used here purely because it is the most reliable Wayland-native polkit agent. Alternatives: `lxqt-policykit` or `mate-polkit`.

---

## 📁 Repository Layout
```
ZAY-RIce/
├── dot_config/
│   ├── appearance/          # Color palette + 3 bundled wallpapers
│   ├── autostart/           # Wayland env vars, portals, polkit, clipboard
│   ├── hypr/                # Hyprland master config + animations, rules, bindings
│   ├── wallust/             # Dynamic palette extraction settings
│   ├── waybar/              # Top bar (config-top.jsonc) + side dock (config-dock.jsonc)
│   ├── wofi/                # App launcher
│   ├── kitty/ & foot/       # Terminal configs (0.75 opacity)
│   ├── vscode/              # VSCode UI theming
│   └── gtk-3.0/ & 4.0/      # GTK theme application
├── sddm/                    # Custom SDDM login screen + installer
├── deploy.sh                # Safe deployment with backup & rollback
├── howtosetup.txt           # Full Arch install guide (USB → Hyprland)
├── CONTRIBUTING.md
├── CHANGELOG.md
├── SECURITY.md
└── README.md
```

## 🔑 Key Bindings

| Shortcut | Action |
|----------|--------|
| `Super + Return` | Launch Kitty terminal |
| `Super + Space` | Open Wofi app launcher |
| `Super + E` | Open Thunar file manager |
| `Super + Q` | Close focused window |
| `Super + M` | Minimize to hidden workspace |
| `Super + Shift + M` | Restore minimized windows |
| `Super + Shift + L` | Lock screen (hyprlock) |
| `Super + Shift + P` | Power menu (wlogout) |
| `Super + Arrow` | Move window in tiling layout |
| `Super + Shift + Arrow` | Resize window |
| `Super + 1-6` | Switch workspace |
| `Print` | Screenshot region |

## 🎨 Wallpaper Switching

```bash
# Switch to any bundled wallpaper (Wallust auto-regenerates palette)
~/.config/hypr/scripts/wallpaper.sh tokyo-lofi-cityscape.jpg
~/.config/hypr/scripts/wallpaper.sh dark-figure-purple.png
~/.config/hypr/scripts/wallpaper.sh samurai-ghost-warrior.jpg
```

## 📖 Full Setup Guide
For a complete Arch Linux installation from scratch (bootable USB → SDDM):

👉 **[Read howtosetup.txt](howtosetup.txt)**

---

## 🗺️ Roadmap

Planned features for upcoming versions:

| Version | Feature |
|---------|---------|
| **v1.1** | 🎮 OMEN key overlay panel — fan speed, performance mode, system stats |
| **v1.1** | 🌡️ Live CPU temp + fan RPM in Waybar via `nbfc-linux` |
| **v1.2** | 🎨 Full Wallust template pipeline — entire desktop recolors from wallpaper |
| **v1.2** | 🎨 Theme presets: Catppuccin, Gruvbox, Nord |
| **v1.3** | 🔔 Custom SwayNC stylesheet + quick settings panel |
| **v1.4** | 🖼️ Picture-in-Picture auto-rules, named workspaces with icons |
| **v1.5** | 🚀 Interactive TUI setup script + first-boot welcome screen |
| **Future** | 🎮 Gamemode toggle, AGS bar, AI wallpaper generator |

👉 **[Full Roadmap →](ROADMAP.md)**

---

## 📜 License
MIT — see [LICENSE](LICENSE)

*Created by [jaynarayan-yadav](https://github.com/jaynarayan-yadav)*
