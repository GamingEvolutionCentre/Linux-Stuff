<div align="center">

# SDDM-Themes:

[![GitHub Stars](https://img.shields.io/github/stars/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot?logo=github&logoColor=black)](https://github.com/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot?logo=github&logoColor=black)](https://github.com/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot/issues)
[![GitHub License](https://img.shields.io/github/license/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot?logo=github&logoColor=black)](https://github.com/GamingEvolutionCentre/Gaming-Evolution-Centre-Bot/license)

</div>

SDDM-Themes is a series of themes for the [SDDM](https://github.com/sddm/sddm/) display manager.

All themes were created for all resolutions.

> [!NOTE]
> Since the project is still in active development, you may encounter some issues. Please consider [submitting feedback](https://github.com/GamingEvolutionCentre/SDDM-Themes/issues) if you do.

<br>

# 🚨 Install 🚨
```
"curl -fsSL https://github.com/GamingEvolutionCentre/SDDM-Themes | sh

```
<br>

## 🚨🚨 Arch 🚨🚨
SDDM Themes can be installed on [Arch](https://archlinux.org) with three different [AUR](https://aur.archlinux.org) packages:

```
git clone https://aur.archlinux.org/SDDM-Themes.git
cd <package>
makepkg -si
```

Replace `<package>` with your preferred package.

If you use [yay](https://github.com/Jguer/yay), [paru](https://github.com/Morganamilo/paru) or any other [AUR Helper](https://wiki.archlinux.org/title/AUR_helpers), it's even simpler:

```
paru -S SDDM-Themes
```
<br>

## 🚨🚨 Debian 🚨🚨
SDDM Themes can be installed on [Debian](https://www.debian.org) with three different [AUR](https://www.debian.org/distrib/packages https://aur.archlinux.org) packages:

```
sudo apt install SDDM-Themes
```
<br>

# Selecting a theme
You can select theme by editing [metadata](./metadata.desktop) (`/usr/share/sddm/themes/sddm-theme/metadata.desktop`).

Just edit this line:

```
ConfigFile=Themes/cyberpunk.conf
```
All available configs are in [Themes](./Themes/) directory.
<br>

# License
BSD 3-Clause License

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
