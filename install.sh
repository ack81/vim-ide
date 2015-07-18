#!/bin/bash

## check for install zsh
rpm -qa zsh | grep "^zsh-" && yum -d0 -e0 -y install zsh

## check for /opt/vim-ide and clone with submodules
if [ ! -d /opt/vim-ide ];then
  git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  git submodule update --init
else
  cd /opt/vim-ide
  git pull
fi

[ ! -d /etc/vim ] && cp -vfR /opt/vim-ide/vim /etc/ || echo "SKIPPING: /etc/vim direcotry already exists"
cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
cp -vf /opt/vim-ide/skel/.pythonrc /etc/skel/
cp -vf /opt/vim-ide/skel/.irbrc /etc/skel/
cp -vf /opt/vim-ide/profile.d/* /etc/profile.d/

## clone and install oh-my-zsh
if [ ! -d ~/oh-my-zsh ];then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cp ~/.zshrc ~/.zshrc.orig
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  chsh -s /bin/zsh
else
  cd ~/oh-my-zsh
  git pull
fi
