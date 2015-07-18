#!/bin/bash

## check for install zsh
sudo yum -d0 -e0 install zsh vim-enhanced util-linux

## check for /opt/vim-ide and clone with submodules
if [ ! -d /opt/vim-ide ];then
  sudo git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  sudo git submodule update --init
else
  cd /opt/vim-ide
  sudo git pull
fi

sudo cp -Rfu /opt/vim-ide/vim /etc/
sudo cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -vf /opt/vim-ide/skel/.pythonrc /etc/skel/
sudo cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -vf /opt/vim-ide/profile.d/* /etc/profile.d/

## clone and install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ];then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  [ -e ~/.zshrc ] || cp -vf ~/.zshrc ~/.zshrc.orig
  cp -vf ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  chsh -s /bin/zsh
else
  cd ~/.oh-my-zsh
  git pull
fi
