#!/bin/bash
# TODO align configs to XDG standards: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

# more recent emacs versions
# sudo add-apt-repository ppa:kelleyk/emacs

# activate all debs and their sources
sudo sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list 
sudo sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
sudo sed -i -- 's/#deb/deb/g' /etc/apt/sources.list
sudo sed -i -- 's/# deb/deb/g' /etc/apt/sources.list

# system basics
sudo apt install i3 gcc make cmake perl r-recommended python3 python3-venv pipenv flake8 python3-googleapi r-base git curl wget mplayer zsh emacspeak shellcheck markdown texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra ripgrep fd-find docker.io docker-compose -y;
# emacs 
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Installing-Emacs.html
sudo apt build-deb emacs
sudo apt install mailutils gnutls-bin
wget http://ftp.halifax.rwth-aachen.de/gnu/emacs/emacs-27.1.tar.gz
# TODO adjust script to dynamically download, ./configure, make, sudo make install
# Emacspeak
# https://tvraman.github.io/emacspeak/manual/Quick-Installation.html
sudo apt install espeak-ng espeak-ng-espeak libespeak-ng-dev tcl-dev tclx-8.4
git clone https://github.com/tvraman/emacspeak
# TODO cd emacspeak, make config, make, cd servers/espeak, make
export DTK_PROGRAM=espeak

# Mu / mu4e
sudo apt install maildir-utils
mu index --maildir=~/.mail
# Potentially the better command with version 1.4
# mu init --maildir=~/.mail --my-address=till.blesik@gmx.de --my-address=till.blesik@gmail.com --my-address=tblesik@escpeurope.eu --my-address=tblesik@escp.eu --my-address=ntm.greattfbspirit@gmx.de

# cleanup
sudo apt autoremove

# DOOM emacs
#https://github.com/hlissner/doom-emacs
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

# Copy configs

# Symlinks
ln -s ~/config/i3 ~/.config/i3
ln -s ~/config/emacs/init.el ~/.emacs.d/.

#git
git config --global user.email "mail@mailserver.tld"
git config --global user.name "GitUserName"
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

# emacspeak
# http://tvraman.github.io/emacspeak/manual/Installation.html#Installation
