# MangoWM Multi-Theme Dotfiles (Wayland)

Multi-theme dotfiles for MangoWM (MangoWC), a Wayland compositor based on dwl/scenefx, with a terminal-based online installer.

## Themes
1. Catppuccin Mocha
2. Dracula
3. Nord
4. Gruvbox Dark
5. Tokyo Night
6. Rose Pine

## Stack (Wayland)
- Compositor: MangoWM
- Bar: waybar
- Launcher: fuzzel
- Notifications: mako
- Wallpaper: swaybg
- Terminal: foot
- Lock: swaylock + swayidle
- Screenshots: grim + slurp + wl-clipboard
- Portals: xdg-desktop-portal-wlr

## Install
Online:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/code-smith404/MangoWM-dotfiles/main/install.sh)"
```
Local:
```bash
git clone https://github.com/code-smith404/MangoWM-dotfiles.git
cd MangoWM-dotfiles
./install.sh
```

## Switch theme
```bash
mango-theme list
mango-theme set catppuccin-mocha
mango-theme current
mango-theme random
```

## Xwayland
MangoWM config enables Xwayland for X11 apps. Env vars are set in config via `env=`:
- QT_QPA_PLATFORM=wayland
- GDK_BACKEND=wayland
- MOZ_ENABLE_WAYLAND=1
- ELECTRON_OZONE_PLATFORM_HINT=auto
- XCURSOR_THEME, XCURSOR_SIZE

To force an app through Xwayland, set `GDK_BACKEND=x11` or `QT_QPA_PLATFORM=xcb`.

## Add a theme
Add `themes/<name>/palette.conf` with required keys and run installer; no installer changes.

## Uninstall
```bash
./uninstall.sh
```
