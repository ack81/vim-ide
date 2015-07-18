#!/bin/bash

## check for install zsh
[ `rpm -qa zsh | grep "^zsh-"` ] || sudo yum -d0 -e0 -y install zsh


## check for /opt/vim-ide and clone with submodules
if [ ! -d /opt/vim-ide ];then
  sudo git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  sudo git submodule update --init
else
  cd /opt/vim-ide
  sudo git pull
fi

[ ! -d /etc/vim ] && sudo cp -vfR /opt/vim-ide/vim /etc/ || echo "SKIPPING: /etc/vim direcotry already exists"
sudo cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -vf /opt/vim-ide/skel/.pythonrc /etc/skel/
sudo cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -vf /opt/vim-ide/profile.d/* /etc/profile.d/

## clone and install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ];then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cp ~/.zshrc ~/.zshrc.orig
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  chsh -s /bin/zsh
else
  cd ~/.oh-my-zsh
  git pull
fi
