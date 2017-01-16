#!/bin/bash

# Package management
pacman -S yaourt

# Window manager
pacman -S xorg-server xorg-server-utils xorg-xinit xorg-xclock xterm
pacman -S i3-wm i3status dmenu rofi compton lxappearance
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
#pacman -S networkmanager network-manager-applet gnome-keyring wpa_supplicant

systemctl enable lightdm

# VirtualBox guest
pacman -S virtualbox-guest-utils

# Filer
pacman -S spacefm
pacman -S numix-themes
yaourt -S numix-icon-theme-git

# Terminal
pacman -S termite

systemctl enable sshd
systemctl start sshd

# SSH
pacman -S openssh

# Git
pacman -S git
pacman -S tig

# Languages
pacman -S python python-pip python2
pacman -S jdk6 jdk7-openjdk jdk8-openjdk
pacman -S nodejs npm
pacman -S go
pacman -S rustup
pacman -S lua

# Utilities
pacman -S unzip
pacman -S copyq
pacman -S xsel
pacman -S feh
pacman -S imwheel
pacman -S powerline python-powerline
yaourt -S peco
yaourt -S ghq

# Japanese
pacman -S fcitx-im fcitx-configtool fcitx-mozc

# Fonts
echo << EOS >> /etc/pacman.conf
[infinality-bundle]
Server = http://bohoomil.com/repo/$arch
EOS
pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
pacman -Syy
pacman -S infinality-bundle
pacman -S ttf-dejavu ttf-hack otf-ipafont powerline-fonts 
yaourt -S otf-source-han-code-jp

# Zsh
pacman -S prezto zsh

# Vim
pacman -S vim

# Tmux
pacman -S tmux

# Browser
pacman -S google-chrome-beta

# Dev tools
pacman -S docker
systemctl enable docker
systemctl
pacman -S visual-studio-code-insiders
pacman -S eclim eclipse-java
pacman -S maven
yaourt -S yarn

