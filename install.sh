#!/bin/bash

## check for install zsh
sudo yum -d0 -e0 -y install \
zsh \
vim-enhanced \
util-linux \
fontconfig \
python-pip \
rubygems \
ruby-irb \
ruby-devel \
perl-Perl-Critic \
gcc \
patch \
perl \
python-devel \
python

## pip packages
sudo pip install --upgrade powerline-status
sudo pip install --upgrade pylint-common
sudo pip install --upgrade pylint
sudo pip install --upgrade python-ldap

## ruby gems
sudo gem install puppet-lint
sudo gem install ruby-lint
sudo gem install bond
sudo gem install json --platform=ruby
sudo gem install parser
sudo gem install ruby-beautify
sudo gem install rgen
sudo gem install rdoc-data
sudo gem install rdoc
sudo gem install pry
sudo gem install r10k

## Install powerline fonts
if [ ! -d /usr/local/share/fonts/powerline ]; then
  sudo git clone https://github.com/powerline/fonts.git /usr/local/share/fonts/powerline
  sudo wget -qO /usr/local/share/fonts/powerline/PowerlineSymbols.otf \
    https://raw.githubusercontent.com/powerline/powerline/develop/font/PowerlineSymbols.otf
  sudo wget -qO /etc/fonts/conf.d/font/10-powerline-symbols.conf \
    https://raw.githubusercontent.com/powerline/powerline/develop/font/10-powerline-symbols.conf
fi
sudo fc-cache -vf

## check for /opt/vim-ide and clone with submodules
if [ ! -d /opt/vim-ide ];then
  sudo git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  sudo git submodule update --init
else
  cd /opt/vim-ide
  sudo git pull
fi

sudo cp -Rvfu /opt/vim-ide/vim /etc/
sudo cp -vfu /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -vfu /opt/vim-ide/skel/.pythonrc /etc/skel/
sudo cp -vfu /opt/vim-ide/skel/.vimrc /etc/skel/
sudo cp -vfu /opt/vim-ide/profile.d/* /etc/profile.d/

## clone and install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ];then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  [ -e ~/.zshrc ] || cp -vf ~/.zshrc ~/.zshrc.orig
  cp -vf ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  sudo chsh -s /bin/zsh ${LOGNAME}
else
  cd ~/.oh-my-zsh
  git pull
fi
