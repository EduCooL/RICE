# Wallpapers

Large wallpaper files are not committed by default.

Use this convention for local wallpapers:

```text
~/Pictures/Wallpapers/current
```

Example setup:

```bash
mkdir -p ~/Pictures/Wallpapers
ln -sf /path/to/my-wallpaper.png ~/Pictures/Wallpapers/current
~/.config/hypr/scripts/wallpaper.sh
```

Hyprlock uses a blurred screenshot by default, so the lockscreen still works when this wallpaper path is missing.

Preferred mood: rainy window, cozy dark study room, warm desk lamp or candle, deep forest green, graphite surfaces, muted amber highlights, not anime, not cyberpunk neon, and not oversaturated.
