# 🌌 ZAY-RIce
**Production-Grade Modular Arch Linux Hyprland Workstation**

An Arch Linux daily-driver workstation environment combining macOS visual polish, Windows snap/minimize ergonomics, Linux modularity, and GUI-first discoverability. Features a fully integrated Tokyo Night Synth aesthetic.

---

## ✨ Features
- **Dynamic Theming**: Integrated Wallust extracts 16-color palettes from your wallpapers and updates your system dynamically.
- **Custom Docks & Bars**: Beautiful vertical side dock and top status bar using Waybar with glassmorphism effects.
- **Refined Window Management**: Windows-style window snapping and minimizing keybindings.
- **Compositor Optimization**: 60fps+ bezier curve animations.
- **Custom Login Screen**: Tokyo Night customized SDDM theme.

## 📸 Screenshots
*(Add your screenshots here!)*

## 📁 Repository Layout
```
/home/zay/ZAY-RIce/
├── dot_config/
│   ├── appearance/          # Central palette & bundled wallpapers
│   ├── autostart/           # Wayland envvars, portal isolation, polkit
│   ├── hypr/                # Master window manager configs (animations, binds, rules)
│   ├── wallust/             # Color extraction settings
│   ├── waybar/              # Top bar & side dock configurations
│   ├── wofi/                # App launcher settings
│   ├── kitty/ & foot/       # Terminal configs
│   ├── vscode/              # Code editor UI theming
│   └── gtk-3.0/ & 4.0/      # Theme application settings
├── sddm/                    # Custom login screen QML & installer
├── deploy.sh                # Automated install, backup & rollback tool
├── howtosetup.txt           # Setup and installation instructions
└── README.md                # This file
```

## 📦 Missing Asset Checklist
Ensure you have these installed on your live system for the best experience:
1. **Fonts**: `ttf-jetbrains-mono-nerd`
2. **Icons**: `papirus-icon-theme` or `beautyline`
3. **Cursors**: `bibata-cursor-theme`
4. **GTK Theme**: `tokyonight-gtk-theme-git`
5. **Extras**: `wallust`, `swww`, `hyprlock`, `hypridle`, `cliphist`, `playerctl`

## 🛠️ Installation & Setup

### Quick Install
If you already have Arch Linux running and the required packages installed, just clone and run the deployment script:
```bash
git clone https://github.com/jaynarayan-yadav/ZAY-RIce.git ~/ZAY-RIce
~/ZAY-RIce/deploy.sh
```

### Full Setup Guide
Looking to replicate this setup from scratch (including OS installation)? I've moved the complete step-by-step installation guide to a separate file.
👉 **[Read the Full Setup Guide](howtosetup.txt)**

---
*Created by [jaynarayan-yadav](https://github.com/jaynarayan-yadav)*
