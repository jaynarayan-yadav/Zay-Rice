# Contributing to ZAY-RIce

Thank you for your interest in improving ZAY-RIce!

## How to Contribute

### 🐛 Reporting Bugs
Open an issue with:
- Your Hyprland version (`hyprctl version`)
- Your GPU and driver (`lspci | grep VGA`)
- The exact error message or screenshot

### ✨ Suggesting Features
Open an issue describing:
- What you want to add
- Why it improves the rice

### 🔧 Submitting a Fix
1. Fork the repository
2. Create a branch: `git checkout -b fix/your-fix-name`
3. Make your changes
4. Test that `deploy.sh` runs cleanly on a fresh Arch install
5. Open a pull request with a clear description

## Code Style
- Shell scripts: POSIX-compatible where possible, `set -euo pipefail` at top
- Hyprland configs: One blank line between sections, comments above every block
- CSS: Group dock and top-bar sections with clear `/* --- SECTION --- */` headers

## Testing
Before submitting, verify:
```bash
bash -n deploy.sh                  # syntax check
bash -n dot_config/hypr/scripts/wallpaper.sh
hyprctl --instance 0 reload        # live reload if Hyprland is running
```
