# AGENTS.md

## Project mission

Build a personal Arch Linux Hyprland rice from scratch, without copying a ready-made dotfiles repository.

The final system must feel like a coherent custom desktop environment, not a random collection of tools. The target style is based on the provided reference image:

- dark cozy room / rainy evening mood;
- deep green-black graphite surfaces;
- soft teal/sage accents;
- warm muted amber highlights;
- translucent panels;
- rounded cards;
- low visual noise;
- comfortable for long coding and study sessions;
- practical keyboard-first workflow;
- minimal but not empty;
- visually consistent across Hyprland, bar/shell, launcher, notifications, terminal, file manager, lock screen, and scripts.

This project is not about making a screenshot-only rice. It must be a daily usable working environment for coding, browsing, university/VKR work, terminal usage, Git, Docker/PostgreSQL development, notes, music, communication, and general desktop use.

## Project stages

Build the rice in three explicit stages:

```text
Stage 1 — functional MVP
Goal: components work, launch, reload, stow safely, and can be maintained on a daily system.

Stage 2 — visual unification
Goal: align palette, radius, padding, borders, opacity, blur, typography, and spacing across components.

Stage 3 — polished rice / possible Quickshell
Goal: custom wallpaper, polished UX flows, dashboard-like behavior, and a possible Quickshell prototype.
```

Stage 1 prioritizes reliable configs, safe scripts, package manifests, health checks, and practical documentation over perfect visuals.

Stage 2 may refine the existing Hyprland, Waybar, Rofi, SwayNC, Kitty, Hyprlock, GTK, and Qt styling so the desktop feels more coherent.

Stage 3 is the earliest point where custom shell/dashboard work should be explored. Do not implement or replace working Stage-1 components with Quickshell unless the user explicitly asks for it.

## Core design direction

Use the following concept as the source of truth:

```text
Style: cozy dark room + rainy evening + focus and calm
Mood: quiet, deep, warm, focused
Base: graphite / forest black / deep desaturated green
Accent: muted teal / sage
Secondary accent: warm candle amber
Surface: transparent dark glass panels
Text: soft off-white, not pure white
Borders: subtle, 1px, low-contrast
Corners: 12-16px
Blur: soft, visible but not excessive
Animations: calm, short, not flashy
Density: compact but readable
```

The reference image shows a custom Hyprland environment with:

- a centered wallpaper area with a thin top bar;
- compact workspaces;
- dashboard/control center on the right;
- launcher panel;
- terminal panel;
- code/editor panel;
- file manager panel;
- notification cards;
- clipboard cards;
- power menu;
- quick actions;
- lock screen;
- workspace overview;
- consistent rounded panels and muted colors.

The goal is to implement this atmosphere in real dotfiles.

## Important rule: do not copy external dotfiles

Do not clone, vendor, or directly copy another rice repository.

Allowed:

- read documentation;
- use official examples;
- use Arch Wiki / Hyprland Wiki / tool documentation;
- take inspiration from concepts such as Caelestia, but do not copy its files;
- create our own configs, scripts, colors, layout, and naming.

Forbidden:

- copying complete configs from Caelestia or any other dotfiles repository;
- adding large unexplained scripts from random GitHub repositories;
- hiding important logic in opaque binaries;
- using a prebuilt rice installer;
- adding unnecessary dependencies just because a reference rice uses them.

## Target stack

### Base system

Use Arch Linux with a Hyprland-first Wayland setup.

Required base components:

```text
hyprland
xdg-desktop-portal
xdg-desktop-portal-hyprland
pipewire
pipewire-pulse
wireplumber
networkmanager
bluez
bluez-utils
brightnessctl
playerctl
pamixer
polkit-gnome or hyprpolkitagent
```

### Login / session

Preferred:

```text
sddm
```

Keep the system usable from TTY as well. Do not make the setup depend entirely on a display manager.

### Compositor

Use:

```text
Hyprland
```

The Hyprland config must be modular and split into files.

Suggested structure:

```text
.config/hypr/
├── hyprland.conf
├── conf/
│   ├── autostart.conf
│   ├── env.conf
│   ├── input.conf
│   ├── keybinds.conf
│   ├── monitors.conf
│   ├── windowrules.conf
│   ├── animations.conf
│   ├── decoration.conf
│   ├── gestures.conf
│   └── workspaces.conf
├── scripts/
│   ├── screenshot-area.sh
│   ├── screenshot-full.sh
│   ├── power-menu.sh
│   ├── clipboard-menu.sh
│   ├── launcher.sh
│   ├── reload.sh
│   ├── toggle-night-mode.sh
│   └── wallpaper.sh
└── hyprlock.conf
```

### Bar / shell strategy

The desired final direction is a custom shell/bar inspired by Caelestia-like concepts, but written specifically for this dotfiles repo.

However, the implementation must be incremental.

#### Stage 1: stable MVP

Use Waybar as a temporary, reliable MVP bar.

```text
waybar
```

Waybar must match the final visual style and must not look like a default Linux panel.

#### Stage 2: custom shell

Prepare the repository for a future custom bar/dashboard implementation.

Preferred future technology:

```text
quickshell
```

Do not implement a large Quickshell shell unless explicitly requested. First create clean foundations: colors, scripts, workspace logic, module requirements.

The repo may contain a placeholder or early prototype directory:

```text
.config/quickshell/
```

But the initial usable version should not depend on Quickshell unless the user explicitly asks to proceed with it.

### Launcher

Use:

```text
rofi-wayland
```

The launcher must visually match the reference:

- dark translucent panel;
- rounded corners;
- subtle border;
- compact list;
- icons enabled;
- soft teal selection;
- bottom action icons if practical;
- no bright default theme.

Rofi should support at least:

```text
app launcher
power menu
clipboard menu
window switcher
optional project launcher
```

### Notifications

Preferred initial choice:

```text
swaync
```

SwayNC should be styled as a compact notification center with card-like notifications.

It must match the visual language of the reference:

- dark glass cards;
- teal/sage icons or highlights;
- low contrast borders;
- readable text;
- no default bright theme.

### Terminal

Use:

```text
kitty
```

Kitty must use the project palette and font. It should look consistent with the rest of the rice.

### Shell

Use:

```text
zsh + starship
```

The shell must be practical for development work, not overloaded with slow plugins.

Recommended CLI tools:

```text
git
github-cli
neovim
fzf
ripgrep
fd
bat
eza
zoxide
btop
fastfetch
yazi
tmux
```

### File managers

Use both:

```text
thunar
yazi
```

Thunar is the GUI file manager. Yazi is the terminal file manager.

Thunar should be themed consistently through GTK settings.

### Screenshots

Use:

```text
grim
slurp
swappy
wl-clipboard
```

Required scripts:

```text
screenshot area
screenshot full
screenshot active monitor if practical
copy screenshot to clipboard
save screenshot to Pictures/Screenshots
open screenshot in swappy when needed
```

### Clipboard history

Use:

```text
wl-clipboard
cliphist
rofi-wayland
```

### Wallpaper

Use:

```text
hyprpaper
```

Wallpaper style should follow the reference:

- rainy window;
- cozy dark study room;
- warm desk lamp/candle;
- deep forest green;
- graphite room;
- muted amber highlights;
- not anime;
- not cyberpunk neon;
- not oversaturated.

The repo should not require shipping large wallpaper files unless the user adds them. Provide a clear wallpaper path convention.

### Lock and idle

Use:

```text
hyprlock
hypridle
```

Lock screen should match the reference:

- dark blurred wallpaper;
- centered time;
- date below;
- subtle password field;
- small lock icon;
- minimal status indicators;
- no clutter.

### Theming

Use a single source of truth for colors.

Required theme files:

```text
themes/
├── colors.json
├── colors.conf
├── colors.css
├── colors.rasi
├── colors.sh
└── colors.qml
```

Even if some formats are not used immediately, keep the structure ready.

The same palette must be reused across:

```text
Hyprland
Waybar
Rofi
SwayNC
Kitty
Starship
GTK
Qt
Hyprlock
scripts
future Quickshell
```

## Palette

Use the following initial palette as a starting point.

```text
base_00 = #0E1312
base_01 = #151A19
base_02 = #1E2322
base_03 = #2A302F

surface_00 = rgba(14, 19, 18, 0.72)
surface_01 = rgba(21, 26, 25, 0.78)
surface_02 = rgba(30, 35, 34, 0.82)

text_00 = #D8E1DC
text_01 = #A7B9B1
text_02 = #73837D

teal_00 = #394F4B
teal_01 = #516F66
teal_02 = #6E8D88
teal_03 = #A7B9B1

amber_00 = #B89A6A
amber_01 = #E6C99A

danger = #D1786C
warning = #D8A657
success = #8BAE8B
info = #7FA6A0

border = rgba(167, 185, 177, 0.18)
border_active = rgba(167, 185, 177, 0.42)
shadow = rgba(0, 0, 0, 0.45)
```

Keep the palette calm. Do not introduce saturated neon colors.

## Typography

Preferred fonts:

```text
UI: Inter / SF Pro / Geist
Mono: JetBrainsMono Nerd Font
Accent/optional headings: Literata / Iosevka Serif / Playfair Display
Icons: Nerd Font symbols + Papirus/Tela icons
```

If the exact fonts are not installed, provide package recommendations and fallback chains.

Do not use overly decorative fonts in functional UI.

## Repository layout

Create dotfiles in a Stow-friendly format.

Target repository:

```text
.dotfiles/
├── AGENTS.md
├── README.md
├── install.sh
├── packages/
│   ├── pacman.txt
│   ├── aur.txt
│   ├── flatpak.txt
│   └── optional.txt
├── stow/
│   ├── hypr/
│   │   └── .config/hypr/
│   ├── waybar/
│   │   └── .config/waybar/
│   ├── rofi/
│   │   └── .config/rofi/
│   ├── swaync/
│   │   └── .config/swaync/
│   ├── kitty/
│   │   └── .config/kitty/
│   ├── zsh/
│   │   └── .zshrc
│   ├── starship/
│   │   └── .config/starship.toml
│   ├── git/
│   │   └── .gitconfig
│   ├── gtk/
│   │   ├── .config/gtk-3.0/
│   │   └── .config/gtk-4.0/
│   ├── qt/
│   │   └── .config/qt6ct/
│   └── nvim/
│       └── .config/nvim/
├── themes/
│   ├── colors.json
│   ├── colors.conf
│   ├── colors.css
│   ├── colors.rasi
│   ├── colors.sh
│   └── colors.qml
├── scripts/
│   ├── install-packages.sh
│   ├── apply-theme.sh
│   ├── backup-existing-configs.sh
│   ├── stow-all.sh
│   └── check-health.sh
└── wallpapers/
    └── README.md
```

## Dotfiles management

Use GNU Stow.

Do not write scripts that blindly overwrite the user’s real configs.

Before stowing, back up existing files.

Required behavior:

```text
1. detect existing conflicting config files;
2. move conflicts into timestamped backup directory;
3. stow selected modules;
4. print clear summary;
5. never silently delete user files.
```

Suggested backup location:

```text
~/.dotfiles-backups/YYYY-MM-DD_HH-MM-SS/
```

## Install scripts

Scripts must be readable and safe.

Use Bash.

Rules:

- use `set -euo pipefail`;
- print clear messages;
- check for commands before using them;
- avoid destructive operations;
- never run `rm -rf` on broad paths;
- ask before installing huge optional components;
- keep package install lists separate from config logic;
- support partial installation.

Required scripts:

```text
install.sh
scripts/install-packages.sh
scripts/backup-existing-configs.sh
scripts/stow-all.sh
scripts/apply-theme.sh
scripts/check-health.sh
```

`install.sh` should orchestrate the setup, but individual scripts should be runnable independently.

## Package lists

Create package lists but do not assume all users want every package.

### packages/pacman.txt

Initial packages:

```text
hyprland
xdg-desktop-portal
xdg-desktop-portal-hyprland
waybar
rofi-wayland
swaync
kitty
hyprpaper
hyprlock
hypridle
grim
slurp
swappy
wl-clipboard
cliphist
thunar
tumbler
ffmpegthumbnailer
zsh
starship
git
github-cli
neovim
fzf
ripgrep
fd
bat
eza
zoxide
btop
fastfetch
yazi
tmux
pipewire
pipewire-pulse
wireplumber
networkmanager
bluez
bluez-utils
brightnessctl
playerctl
pamixer
pavucontrol
nwg-look
qt5ct
qt6ct
kvantum
papirus-icon-theme
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-jetbrains-mono-nerd
```

### packages/aur.txt

Keep AUR minimal.

Possible AUR packages:

```text
visual-studio-code-bin
```

Do not require an AUR helper unless needed. If using one, prefer `paru`, but do not install it silently without explanation.

### packages/flatpak.txt

Optional. Keep separate.

Possible Flatpaks:

```text
com.spotify.Client
org.telegram.desktop
md.obsidian.Obsidian
```

## Hyprland requirements

### Visual

Hyprland should use:

```text
gaps_in = 6
gaps_out = 12
border_size = 1 or 2
rounding = 12-16
blur enabled
shadow subtle
dim inactive optional and very subtle
```

Use calm animations.

Avoid excessive bounce, overshoot, and long animation timings.

### Input

Configure:

- keyboard layout switch if needed;
- mouse/touchpad natural scroll option;
- touchpad tap-to-click;
- sensitivity defaults;
- repeat rate.

Do not hardcode a layout that may break the user. Leave a clear section for `us/ru` or other layouts.

### Workspaces

Recommended workspace model:

```text
1 — dev
2 — web
3 — code
4 — chat
5 — media
6 — files
```

Expose this logic in the bar visually.

### Keybinds

Use `SUPER` as the main modifier.

Required binds:

```text
SUPER + Return        terminal
SUPER + D             launcher
SUPER + E             file manager
SUPER + B             browser
SUPER + Q             close focused window
SUPER + F             fullscreen
SUPER + Space         toggle floating
SUPER + V             clipboard history
SUPER + L             lock
SUPER + Shift + S     screenshot area
SUPER + Print         screenshot area or full
SUPER + Shift + Q     power menu
SUPER + R             reload Hyprland / config helper
SUPER + 1-6           switch workspace
SUPER + Shift + 1-6   move window to workspace
SUPER + arrows        focus windows
SUPER + Shift+arrows  move windows
SUPER + mouse drag    move/resize floating windows
```

Use intuitive names in comments.

### Autostart

Start only necessary services:

```text
hyprpaper
waybar
swaync
wl-paste/cliphist watcher
polkit agent
nm-applet if needed
blueman-applet if needed
```

Avoid launching duplicate daemons.

## Waybar requirements

Waybar must be treated as the stage-1 shell.

Visual style:

- compact top panel;
- transparent dark background;
- rounded workspace pills;
- active workspace with teal background;
- small status icons;
- centered current mode/title optional;
- right side: network, volume, battery, language, time, power;
- no bright separators;
- no huge margins.

Suggested modules:

```text
hyprland/workspaces
hyprland/window
clock
pulseaudio
network
bluetooth
battery
tray
custom/power
custom/launcher
custom/clipboard
```

Use CSS variables or generated colors from `themes/colors.css`.

## Rofi requirements

Rofi themes:

```text
launcher.rasi
power-menu.rasi
clipboard.rasi
```

Rofi scripts:

```text
scripts/launcher.sh
scripts/power-menu.sh
scripts/clipboard-menu.sh
```

Power menu actions:

```text
Lock
Sleep
Restart
Shutdown
Logout
```

Do not execute destructive actions without a confirmation step unless the action is clearly selected.

## SwayNC requirements

SwayNC must look like a right-side dashboard/control center, similar to the reference.

Style:

- dark cards;
- rounded 12-16px;
- subtle border;
- compact notification cards;
- muted teal highlights;
- amber only for warnings/important accents.

If SwayNC limitations prevent full control-center behavior, keep it as notifications only and leave dashboard work for future Quickshell.

## Kitty requirements

Kitty config must include:

- font family;
- font size;
- shell integration if safe;
- background opacity;
- project palette;
- cursor color;
- selection color;
- inactive/active tab styling if tabs are used.

Avoid terminal transparency so strong that text readability suffers.

## Zsh requirements

`.zshrc` must be clean, fast, and understandable.

Required:

```text
starship init
zoxide init
fzf integration if available
aliases for ls/cat/grep replacements
history config
editor env var
useful project aliases
```

Example aliases:

```text
ls=eza
ll=eza -la --icons
cat=bat
grep=rg
v=nvim
g=git
```

Do not install heavy plugin managers by default. If adding plugins later, keep them optional.

## Starship requirements

Starship prompt should be compact and calm.

Style:

- no giant multi-line prompt unless user asks;
- show directory, git branch/status, Python/Node when relevant;
- use teal/amber accents;
- keep prompt fast.

## GTK / Qt theming

Use `nwg-look`, `qt5ct`, `qt6ct`, and optionally `kvantum`.

Goal:

- GTK apps and Qt apps should not visually fight each other;
- Thunar should look acceptable in the dark theme;
- icons should match the calm teal/green style.

Recommended icon themes:

```text
Papirus-Dark
Tela-circle-dark
```

Do not hardcode one unavailable theme without fallback.

## Dashboard / future custom shell requirements

The long-term target is a custom Quickshell-based shell, but only after the MVP is stable.

Future custom shell modules:

```text
top bar
workspace pills
active app / current mode
system status cluster
control center
calendar
media player
volume/brightness sliders
network/bluetooth status
notifications summary
clipboard cards
quick actions
power menu
```

Use this structure when the user asks to begin Quickshell implementation:

```text
stow/quickshell/.config/quickshell/
├── shell.qml
├── modules/
│   ├── Bar.qml
│   ├── Dashboard.qml
│   ├── Workspaces.qml
│   ├── SystemStatus.qml
│   ├── Media.qml
│   ├── Calendar.qml
│   ├── Notifications.qml
│   └── PowerMenu.qml
├── services/
│   ├── Hyprland.qml
│   ├── Audio.qml
│   ├── Battery.qml
│   └── System.qml
└── theme/
    ├── Colors.qml
    ├── Typography.qml
    └── Metrics.qml
```

Do not prematurely replace working Waybar/SwayNC/Rofi until the custom shell can fully replace the needed functionality.

## Coding standards

### General

- Prefer simple, readable configs.
- Comment non-obvious parts.
- Use consistent naming.
- Split large configs into modules.
- Avoid magic numbers without explanation.
- Avoid overengineering early.

### Bash

Use:

```bash
set -euo pipefail
```

Prefer functions for repeated logic.

Check external dependencies before running commands.

Use `notify-send` only if notifications are available.

### CSS/Rasi/QML

Use shared color variables where possible.

Keep spacing consistent.

Suggested design tokens:

```text
radius_small = 8px
radius_medium = 12px
radius_large = 16px

spacing_xs = 4px
spacing_sm = 8px
spacing_md = 12px
spacing_lg = 16px

border_width = 1px
panel_opacity = 0.78
blur_strength = 10-20
```

## Health checks

Create `scripts/check-health.sh` that checks:

```text
hyprland installed
waybar installed
rofi-wayland installed
swaync installed
kitty installed
hyprpaper installed
hyprlock installed
xdg-desktop-portal-hyprland installed
pipewire running
wireplumber running
NetworkManager running
Bluetooth service status
cliphist available
grim/slurp available
required fonts available
```

It should print a clear report.

## README requirements

`README.md` must explain:

- what this rice is;
- visual concept;
- screenshots placeholder;
- install steps;
- package installation;
- stow usage;
- backup behavior;
- keybinds;
- how to change colors;
- how to change wallpaper;
- how to enable/disable components;
- known limitations;
- future Quickshell plan.

Keep README practical and not marketing-heavy.

## Output expectations for Codex

When implementing, Codex should produce real files and not just a plan.

For each task, return:

```text
1. Summary of changes
2. Files created/modified
3. How to install/apply
4. How to test
5. Known limitations
6. Next recommended step
```

If a package/tool name is uncertain, do not invent blindly. Mark it as TODO or ask for confirmation in the PR summary.

## First implementation milestone

The first useful milestone should create a complete MVP:

```text
1. repository structure;
2. package lists;
3. safe install/stow scripts;
4. modular Hyprland config;
5. Waybar config styled according to the reference;
6. Rofi launcher/power/clipboard themes;
7. SwayNC theme;
8. Kitty config;
9. Zsh + Starship config;
10. Hyprlock config;
11. Hyprpaper config;
12. screenshot and clipboard scripts;
13. README with install and usage guide.
```

Do not implement Quickshell in milestone 1 unless explicitly asked.

## Second implementation milestone

After MVP works:

```text
1. refine design tokens;
2. improve workspace overview behavior;
3. add dashboard-like SwayNC layout if feasible;
4. add project launcher;
5. add theme switching script;
6. add optional rainy/cozy wallpaper pack structure;
7. prepare Quickshell prototype.
```

## Third implementation milestone

Only after the user confirms the MVP is comfortable:

```text
1. implement custom Quickshell bar;
2. move workspace/status logic from Waybar to Quickshell;
3. implement custom dashboard;
4. gradually replace SwayNC/Rofi pieces where it makes sense;
5. keep rollback path to Waybar.
```

## Non-goals

Do not implement the following unless explicitly requested:

```text
full Neovim IDE config
AGS shell
Eww widgets
entire Quickshell desktop shell
complex animations everywhere
wallpaper generation pipeline
Nix/NixOS setup
system-wide security hardening
gaming-specific setup
NVIDIA-specific tweaks
dual-GPU laptop setup
```

## Final quality bar

The setup is acceptable only if:

- it boots into Hyprland;
- essential hotkeys work;
- terminal opens;
- launcher opens;
- screenshots work;
- clipboard history works;
- notifications work;
- lock screen works;
- bar displays workspaces and system status;
- theme is visually coherent;
- configs are readable and modular;
- Stow installation is safe;
- README explains recovery and rollback;
- no user configs are silently destroyed.

The setup must feel personal, calm, and usable for daily development, not like a fragile copied rice.
