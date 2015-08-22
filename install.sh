#!/bin/bash

## check for install zsh
echo -n "Installing Packages... "
sudo yum -d0 -e0 -y install \
epel-release
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
openldap-devel \
python-devel \
python \
python-pip \
> /dev/null
echo "Done"

## pip packages
echo -n "Installing Python modules... "
sudo pip install --upgrade --quiet requests[security]
sudo pip install --upgrade --quiet powerline-status
sudo pip install --upgrade --quiet pylint-common
sudo pip install --upgrade --quiet pylint
sudo pip install --upgrade --quiet python-ldap
echo "Done"

## ruby gems
echo -n "Installing Ruby gems "
gem list puppet-lint | grep -sq "^puppet-lint " || sudo gem install puppet-lint 1> /dev/null
gem list ruby-lint | grep -sq "^ruby-lint " || sudo gem install ruby-lint 1> /dev/null
gem list bond | grep -sq "^bond " || sudo gem install bond 1> /dev/null
gem list json | grep -sq "^json " || sudo gem install json --platform=ruby 1> /dev/null
gem list parser | grep -sq "^parser " || sudo gem install parser 1> /dev/null
gem list ruby-beautify | grep -sq "^ruby-beautify " || sudo gem install ruby-beautify 1> /dev/null
gem list rgen | grep -sq "^rgen " || sudo gem install rgen 1> /dev/null
gem list rdoc-data | grep -sq "^rdoc-data " || sudo gem install rdoc-data 1> /dev/null
gem list rdoc | grep -sq "^rdoc " || sudo gem install rdoc 1> /dev/null
gem list pry | grep -sq "^pry " || sudo gem install pry 1> /dev/null
gem list r10k | grep -sq "^r10k " || sudo gem install r10k 1> /dev/null
echo "Done"

## Install powerline fonts
echo -n "Installing powerline fonts... "
if [ ! -d /usr/local/share/fonts/powerline ]; then
  sudo git clone -q https://github.com/powerline/fonts.git /usr/local/share/fonts/powerline
  sudo wget -qO /usr/local/share/fonts/powerline/PowerlineSymbols.otf \
    https://raw.githubusercontent.com/powerline/powerline/develop/font/PowerlineSymbols.otf
  sudo wget -qO /etc/fonts/conf.d/10-powerline-symbols.conf \
    https://raw.githubusercontent.com/powerline/powerline/develop/font/10-powerline-symbols.conf
else
  cd /usr/local/share/fonts/powerline
  sudo git pull -q
fi
sudo fc-cache -f
echo "Done"

## check for /opt/vim-ide and clone with submodules
echo -n "Installing VIM-IDE... "
if [ ! -d /opt/vim-ide ];then
  sudo git clone https://github.com/ack81/vim-ide.git /opt/vim-ide
  cd /opt/vim-ide
  sudo git submodule --quiet update --init
else
  cd /opt/vim-ide
  sudo git pull -q
fi
sudo cp -Rfu /opt/vim-ide/vim /etc/
sudo cp -fu /opt/vim-ide/skel/.irbrc /etc/skel/
sudo cp -fu /opt/vim-ide/skel/.pythonrc /etc/skel/
sudo cp -fu /opt/vim-ide/skel/.vimrc /etc/skel/
sudo cp -fu /opt/vim-ide/profile.d/* /etc/profile.d/
echo "Done"

## clone and install oh-my-zsh
echo -n "Installing oh-my-zsh... "
if [ ! -d /opt/oh-my-zsh ];then
  sudo git clone -q git://github.com/robbyrussell/oh-my-zsh.git /opt/oh-my-zsh
else
  cd /opt/oh-my-zsh
  sudo git pull -q
fi
if [ ! -e ~/.oh-my-zsh ];then
  cp -f ~/.zshrc ~/.zshrc.orig
  cp -f /opt/oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  sudo chsh -s /bin/zsh ${LOGNAME}
fi
echo "Done"
