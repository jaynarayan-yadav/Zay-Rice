# 🗺️ ZAY-RIce Roadmap

This document outlines planned features and future improvements for ZAY-RIce.
Community contributions toward any of these are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## 🔜 Version 1.1 — Hardware Control Integration

### OMEN Key Overlay Panel
> Custom popup menu triggered by the HP OMEN keyboard key — similar to the OMEN Gaming Hub on Windows.

- [ ] Auto-detect OMEN key scancode via `wev`
- [ ] Bind OMEN key in `bindings.conf` (`XF86Launch3` or `XF86Tools`)
- [ ] Create `~/.config/hypr/scripts/omen-panel.sh` with `wofi --dmenu` popup
- [ ] Options: Max Fan Speed, Battery Saver, Performance Mode, System Stats
- [ ] Integrate `nbfc-linux` for fan speed control (`yay -S nbfc-linux`)
- [ ] Integrate `auto-cpufreq` for CPU governor switching
- [ ] Show current CPU temp and fan RPM live in the popup

**Preview of planned menu:**
```
┌──────────────────────────┐
│  ⬡ OMEN Control Panel   │
│  🌀  Max Fan Speed       │
│  🔋  Battery Saver       │
│  ⚡  Performance Mode    │
│  🌡️  Balanced            │
│  📊  System Stats        │
└──────────────────────────┘
```

### Thermal Monitoring in Waybar
- [ ] Add CPU temperature module to top bar (already has `temperature` module, needs calibration per hardware)
- [ ] Add fan RPM reading if `nbfc-linux` is installed
- [ ] Color-coded: green → yellow → red based on temp thresholds

---

## 🔜 Version 1.2 — Dynamic Theming Pipeline

### Full Wallust Template System
- [ ] Add `dot_config/appearance/wallust-templates/` directory
- [ ] Wallust templates for: Waybar CSS, Wofi CSS, Kitty colors, Hyprlock colors
- [ ] Single command (`wallpaper.sh`) recolors the **entire desktop** from any wallpaper
- [ ] No manual hex editing needed after wallpaper change

### Theme Presets
- [ ] `themes/` directory with multiple named presets
  - `tokyo-night-synth` (current default)
  - `catppuccin-mocha`
  - `gruvbox-dark`
  - `nord`
- [ ] `apply-theme.sh <theme-name>` command to switch entire palette instantly

---

## 🔜 Version 1.3 — Notifications & Quick Settings

### SwayNC Integration
- [ ] Custom SwayNC stylesheet matching Tokyo Night Synth
- [ ] Do Not Disturb toggle in the notification panel
- [ ] Quick settings panel: Wi-Fi, Bluetooth, Volume, Brightness, Night Mode

### Brightness Control
- [ ] `brightnessctl` integration in Waybar (slider on scroll)
- [ ] Keyboard brightness keys bind in `bindings.conf`
- [ ] Smooth brightness animation

---

## 🔜 Version 1.4 — Workspace & Window Enhancements

### Named Workspaces with Icons
- [ ] Assign names to workspaces: `1:` `2:` `3:󰝚` `4:` `5:` `6:`
- [ ] Waybar shows icon instead of number when workspace has apps

### Scratchpad Terminal
- [ ] `Super + ~` toggles a floating Kitty scratchpad terminal
- [ ] Slides in from top with animation (special workspace)

### Picture-in-Picture Rules
- [ ] Auto-detect PiP windows from Firefox/Brave/Chrome
- [ ] Pin to bottom-right corner, always-on-top, no border, no shadow
- [ ] Exempt from opacity rules

---

## 🔜 Version 1.5 — Beginner Onboarding

### Interactive Setup Script
- [ ] Replace `deploy.sh` plain text prompts with a pretty TUI using `gum` or `whiptail`
- [ ] Step-by-step guided install with checkmarks
- [ ] Optional component selection (install only what you want)

### First Boot Welcome Screen
- [ ] On first Hyprland login: show a floating welcome window listing keybindings
- [ ] Auto-dismiss after 10 seconds or on keypress

### Uninstall Script
- [ ] `uninstall.sh` — restores the backup created by `deploy.sh`
- [ ] Clean removal with confirmation

---

## 🔮 Long-Term Ideas (No Timeline)

| Idea | Description |
|------|-------------|
| **Hyprland Plugin Support** | Integrate `hyprpm` managed plugins (e.g., `hyprspace`, `hyprtrails`) |
| **Multi-monitor Profiles** | Auto-detect connected monitors and apply saved layout profiles |
| **Gamemode Integration** | `Super + G` toggles `gamemode` — disables blur, sets governor to performance, hides dock |
| **AGS/Aylur's Widget Shell** | Replace Waybar with a fully custom AGS-based bar for more flexibility |
| **Wayland Screenshot Annotation** | `hyprshot` + `swappy` for annotating screenshots before saving |
| **Night Light** | `wlsunset` auto-adjusts color temperature based on time of day |
| **AI Wallpaper Generator** | Script that generates a new AI wallpaper and runs Wallust on it |

---

## 📬 Suggest a Feature

Open a [GitHub Issue](https://github.com/jaynarayan-yadav/Zay-Rice/issues) with the label `enhancement`.
Describe what you want and why it would improve the rice.
