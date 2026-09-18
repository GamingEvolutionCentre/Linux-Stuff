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

- 11 March 2025, due to popular request, created a guided `uninstall.sh` script. USE this with caution as it may render your system unstable.
- I will not be responsible if your system breaks
- The best still to revert to previous state of your system is via `timeshift or snapper`

#### ✨ for ZSH and OH-MY-ZSH installation

> installer should auto change your default shell to zsh. However, if it does not, do this

```bash
chsh -s $(which zsh)
zsh
source ~/.zshrc
```

- reboot or logout
- by default `agnosterzak` theme is installed. Which is from external oh-my-zsh theme. You can find more themes from this [`OH-MY-ZSH-THEMES`](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
- to change the theme, `SUPER SHIFT O` , choose desired theme, and close and open terminal.
- or manually edit `~/.zshrc` . Look for ZSH_THEME="desired theme"

#### 🎞️ AGS Overview DEMO

- in case you wonder, here is a short demo of AGS overview [Youtube LINK](https://youtu.be/zY5SLNPBJTs)

#### ✨ TO DO once installation done and dotfiles copied

- SUPER H for HINT or click on the waybar HINT! Button
- Head over to [KooL Hyprland WIKI](https://github.com/LinuxBeginnings/Hyprland-Dots/wiki)

#### 🙋 Got a questions regarding the Hyprland Dots or configurations? 🙋

- Head over to wiki Link [`WIKI`](https://github.com/LinuxBeginnings/Hyprland-Dots/wiki)

#### ⌨ Keybinds

- Keybinds [`CLICK`](https://github.com/LinuxBeginnings/Hyprland-Dots/wiki/Keybinds)

> [!TIP]
> KooL Hyprland has a searchable keybind function via rofi. (SUPER SHIFT K) or right click the `HINTS` waybar button

#### 🔄 switching between Hyprland-git and none Hyprland-git

- you can use my prepared script [`LINK`](https://github.com/LinuxBeginnings/Arch-Hyprland/tree/main/assets/hyprland-install)
- Readme is also there

#### 🙋 👋 Having issues or questions?

- for the install part, kindly open issue on this repo
- for the Pre-configured Hyprland dots / configuration, submit issue [`here`](https://github.com/LinuxBeginnings/Hyprland-Dots/issues)

#### 🔧 Proper way to re-installing a particular script from install-scripts directory

- CD into Arch-Hyprland directory and then ran the below command.
- i.e. `./install-scripts/gtk-themes.sh` - For reinstall GTK Themes or
- `./install-scripts/sddm.sh` - For reinstall sddm

> [!IMPORTANT]
> DO NOT cd into install-scripts directory as script will most likely to fail

#### 🛠️ Optional system monitor scripts (cross-distro compatible)

- These installer helpers will set up user-level services and install required packages automatically.
- Works on Fedora, Arch, and other distributions using standard tools.
- Re-run any time from the repo root (do not `cd` into `install-scripts`).

- `./install-scripts/battery-monitor.sh`
  - Installs: `acpi`, `libnotify`
  - Creates: `~/.config/hypr/scripts/battery-monitor.sh` and user service `battery-monitor.service`
  - Manage: `systemctl --user status|start|stop battery-monitor`
- `./install-scripts/disk-monitor.sh`
  - Installs: `libnotify`
  - Creates: `~/.config/hypr/scripts/disk-monitor.sh` and user service `disk-monitor.service`
  - Manage: `systemctl --user status|start|stop disk-monitor`
- `./install-scripts/temp-monitor.sh`
  - Installs: `lm_sensors`, `libnotify`
  - Detects sensors (runs `sudo sensors-detect --auto` once)
  - Creates: `~/.config/hypr/scripts/temp-monitor.sh` and user service `temp-monitor.service`
  - Manage: `systemctl --user status|start|stop temp-monitor`
    > Packages above are installed by the respective installer scripts; no manual action is required. If you prefer package pre-install via the main package list, ensure `acpi`, `lm_sensors`, and `libnotify` are present in your setup.

#### 🛣️ Roadmap:

- [ ] show a progress bar in downloading and compiling part when installing outside AUR or official repo

#### ❗ some known issues for nvidia

- reports from members of my discord, states that some users of nvidia are getting stuck on sddm login. credit to @Kenni Fix stated was

```
 while in sddm press ctrl+alt+F2 or F3
log into your account
`lspci -nn`, find the id of your nvidia card
`ls /dev/dri/by-path` find the matching id
`ls -l /dev/dri/by-path` to check where the symlink points to
)
```

- add "env = WLR_DRM_DEVICES,/dev/dri/cardX" to the ENVvariables config `~/.config/hypr/UserConfigs/ENVariables.conf` ; X being where the symlink of the gpu points to

- more info from the hyprland wiki [`Hyprland Wiki Link`](https://wiki.hyprland.org/FAQ/#my-external-monitor-is-blank--doesnt-render--receives-no-signal-laptop)

- reports from a member of discord for Nvidia for additional env's
- remove # from the following env's on

```
env = GBM_BACKEND,nvidia-drm
env = WLR_RENDERER_ALLOW_SOFTWARE,1
```

#### ❗ other known issues

- [ ] If you are using this script on an Arch-Based distros like Arco linux, or cachy OS or EOS or Manjaro, make sure to install pipewire, pipewire-pulse & pipewire-audio first. Arco Linux, on some of their ISO's still shipped with pulseaudio as audio backend. You will experience getting "stuck" on installation.
- [ ] To install pipewire and its services , `sudo pacman -S pipewire wireplumber pipewire-audio pipewire-pulse` . When prompted, remove / replace pulseaudio. After that, you can ran `./install.sh`
- [ ] installing of cava-git on a newly installed Arch makes the install keep hanging. Switched back to cava. After booting and logged in, if cava dont work, replace it cava-git `yay -S cava-git` or `paru -S cava-git`
  > [!NOTE]
  > Auto start of Hyprland after login (no SDDM or GDM or any login managers)
- [ ] This was disabled a few days ago. (19 May 2024). This was because some users, after they used the Distro-Hyprland scripts with other DE (gnome-wayland or plasma-wayland), if they choose to login into gnome-wayland for example, Hyprland is starting.
- [ ] to avoid this, I disabled it. You can re-enable again by editing `~/.zprofile` . Remove all the # on the first lines
- [ ] ROFI issues (scaling, unexplained scaling etc). This is most likely to experience if you are installing on a system where rofi is currently installed. To fix it uninstall rofi and install rofi-wayland . `sudo pacman -Rns rofi` . Install rofi-wayland with `sudo pacman -S rofi-wayland`. Rofi-wayland is compatible with x11 so no need to worry.

#### 🫥 Improving performance for Older Nvidia Cards using driver 470

- [`SEE HERE`](https://github.com/LinuxBeginnings/Hyprland-Dots/discussions/123#discussion-6035205)

#### 📒 Final Notes

- join my discord channel [`Discord`](https://discord.com/invite/kool-tech-world)
- Feel free to copy, re-distribute, and use this script however you want. Would appreciate if you give me some loves by crediting my work :)


#### 👍👍👍 Thanks and Credits!

- [`Hyprland`](https://hyprland.org/) Of course to Hyprland and @vaxerski for this awesome Dynamic Tiling Manager.

## 💖 Support

- a Star on my Github repos would be nice 🌟

- Subscribe to my Youtube Channel [YouTube](https://www.youtube.com/@Ja.KooLit)

#### 📹 Youtube videos (Click to view and watch the playlist) 📹

[![Youtube Playlist Thumbnail](https://raw.githubusercontent.com/LinuxBeginnings/screenshots/main/Youtube.png)](https://youtube.com/playlist?list=PLDtGd5Fw5_GjXCznR0BzCJJDIQSZJRbxx&si=iaNjLulFdsZ6AV-t)
