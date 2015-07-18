#!/bin/bash

## check for install zsh
rpm -qa zsh | grep "^zsh-" && yum -d0 -e0 -y install zsh

## check for /opt/vim-ide and clone with submodules
if [ ! -d /opt/vim-ide ];then
  git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  git submodule update --init
  [ ! -d /etc/vim ] && cp -i-vfR vim /etc/
  cp -vf skel/.* /etc/skel
  cp -vf profile.d/* /etc/profile.d/
fi

## clone and install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
