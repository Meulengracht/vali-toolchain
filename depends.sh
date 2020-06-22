#!/bin/bash

mkdir -p sources
cd sources

# Dev-libraries
sudo apt-get -qq install cmake zip libelf1 libelf-dev libffi7 libffi-dev make gcc g++ git flex bison python libyaml-dev
sudo python get-pip.py
pip install prettytable Mako pyaml dateutils --upgrade

# Leave sources
cd ..
