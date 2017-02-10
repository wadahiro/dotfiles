#!/bin/bash

# Package management
pacman -S yaourt

# Window manager
pacman -S xorg-server xorg-server-utils xorg-xinit xorg-xclock xterm
pacman -S i3-wm i3status dmenu rofi compton lxappearance
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
#pacman -S networkmanager network-manager-applet gnome-keyring wpa_supplicant
yaourt -S lemonbaar
pip install i3ipc
mkdir ~/.i3/lemonbar && git clone https://github.com/mirekys/i3-lemonbar.git ~/.i3/lemonbar

# For intel video card
sudo pacman -S xf86-video-intel

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
pacman -S jdk7-openjdk jdk8-openjdk
yaourt -S jdk6
pacman -S nodejs npm
pacman -S go
pacman -S rustup
pacman -S lua

# Utilities
sudo pacman -S ntp
pacman -S unzip
sudo pacman -S p7zip
#sudo pacman -S copyq
curl https://raw.githubusercontent.com/erebe/greenclip/master/greenclip > $HOME/bin/greenclip
sudo pacman -S parcellite
pacman -S xsel
pacman -S feh
pacman -S imwheel
pacman -S powerline python-powerline
sudo pacman -S colordiff
yaourt -S peco
yaourt -S ghq
yaourt -S libqalculate

# Sound
sudo pacman -S alsa-utils
#sudo cat <<EOF > /etc/modprobe.d/alsa-base.conf
## https://wiki.archlinuxjp.org/index.php/Dell_XPS_13_(9333) 
#options snd_hda_intel index=0 vid=8086 pid=0a0c
#options snd_hda_intel index=1 vid=8086 pid=9c20
#EOF

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
sudo pacman -S zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
chsh -s /bin/zsh

# Vim
# The gvim provides also the CLI version of Vim with the +clipboard feature.
sudo pacman -S gvim
mkdir -p ~/.cache/vim-undo

# Tmux
pacman -S tmux
yaourt -S tmuxinator
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Browser
yaourt -S google-chrome-beta

# Dev tools
sudo pacman -S docker
sudo gpasswd -a $USER docker
systemctl enable docker
systemctl
#yaourt -S visual-studio-code-insiders
pacman -S eclipse-java
#pacman -S eclim
pacman -S maven
sudo pacman -S apache-ant
yaourt -S yarn

# Virtual Box
sudo pacman -S virtualbox virtualbox-guest-iso 
yaourt -S virtualbox-ext-oracle
sudo gpasswd -a $USER vboxusers
modprobe vboxdrv

