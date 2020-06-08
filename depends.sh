#!/bin/bash

mkdir -p sources
cd sources

# Dev-libraries
sudo apt-get -qq install zip libelf1 libelf-dev libffi7 libffi-dev make gcc g++ git flex bison python libyaml-dev
sudo python get-pip.py
pip install prettytable Mako pyaml dateutils --upgrade

# cmake version 3 is required
CMAKE_VERSION="$(cmake --version)";
if [[ $CMAKE_VERSION != *"3.13.0"* ]]; then
  if [ ! -f ./cmake-3.13.0-rc3 ]; then
    wget https://cmake.org/files/v3.13/cmake-3.13.0-rc3.tar.gz
    tar xzf cmake-3.13.0-rc3.tar.gz
    rm cmake-3.13.0-rc3.tar.gz
  fi
  cd cmake-3.13.0-rc3
  if [ -x "$(command -v cmake)" ]; then
    apt-get -qq remove "^cmake.*" 
  fi
  ./bootstrap
  make
  sudo make install
  cd ..
fi

# Leave sources
cd ..
