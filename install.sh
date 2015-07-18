#!/bin/bash

rpm -qa zsh | grep "^zsh-" && yum -d0 -e0 -y install zsh

if [ ! -d vim-ide ];then
  git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  git submodule update --init
  [ ! -d /etc/vim ] && cp -R vim /etc/
  cp skel/.* /etc/skel
  cp profile.d/* /etc/profile.d/
fi
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
