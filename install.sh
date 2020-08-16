#!/bin/bash

# system basics
sudo apt install i3 gcc make perl python3 r-base git curl wget zsh emacs shellcheck markdown ripgrep fd-find docker.io -y;

# cleanup
sudo apt autoremove

# DOOM emacs
#https://github.com/hlissner/doom-emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Copy configs

# Symlinks


#git
git config --global user.email "till.blesik@gmx.de"
git config --global user.name "tfb"
git config --global core.excludesfile ~/.gitignore_global

# oh-my-zsh
# https://www.howtoforge.com/tutorial/how-to-setup-zsh-and-oh-my-zsh-on-linux/
#chsh -s $(which zsh)
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# virtualbox
# add user to vbox group to allow accessing shared folders
#sudo usermod -G vboxsf -a tfb
# create directory for cloud
#sudo mkdir /mnt/cloud
#sudo chown tfb:tfb /mnt/cloud
