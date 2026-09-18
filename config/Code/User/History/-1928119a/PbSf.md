# Hyprland Install Script

> [!IMPORTANT]
> install a backup tool like `timeshift`. and Backup your system before installing hyprland using this script (HIGHLY RECOMMENDED)

> [!CAUTION]
> Download this script on a directory where you have write permissions. ie. HOME. Or any directory within your home directory. Else script will fail

> [!NOTE]
> 🔘 Pipewire and Pipewire audio

- This script will install pipewire and will also disable or will uninstall pulseaudio. If you dont want it, edit install.sh, about line 191 and comment the line `execute_script "pipewire.sh"` or you can simply just delete pipewire.sh in install-scripts directory before installing.

## ✨ to use this script

- clone this repo (latest commit only) to reduce file size download by using git. Change directory, make executable and run the script

```bash
git clone --depth=1 https://github.com/GamingEvolutionCentre/Linux-Stuff/Hyprland.git ~/Downloads/Hyprland
cd ~/Downloads/Hyprland
chmod +x install.sh
./install.sh
```

### 💥 💥 UNINSTALL SCRIPT / Removal of Config Files

> [!CAUTION]
> USE this with caution as it may render your system unstable.
> I will not be responsible if your system breaks,
> The best still to revert to previous state of your system is via `timeshift`.

```bash
cd ~/Downloads/Hyprland
chmod +x uninstall.sh
./uninstall.sh
```

#### 👍👍👍 Thanks and Credits!

- [`Hyprland`](https://hyprland.org/) Of course to Hyprland and @vaxerski for this awesome Dynamic Tiling Manager.

## 💖 Support

- a Star on my Github repos would be nice 🌟

- Subscribe to my Youtube Channel [YouTube](https://www.youtube.com/@Ja.KooLit)

#### 📹 Youtube videos (Click to view and watch the playlist) 📹

[![Youtube Playlist Thumbnail](https://raw.githubusercontent.com/LinuxBeginnings/screenshots/main/Youtube.png)](https://youtube.com/playlist?list=PLDtGd5Fw5_GjXCznR0BzCJJDIQSZJRbxx&si=iaNjLulFdsZ6AV-t)
