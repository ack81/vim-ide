#!/bin/bash

if [ ! -d vim-ide ];then
  git clone https://github.com/ack81/vim-ide.git
  cd vim-ide
  git submodule update --init
fi
