#!/bin/bash

mkdir -p sources
cd sources

# Dev-libraries
sudo apt-get install cmake zip libelf1 libelf-dev libffi-dev make gcc g++ git flex bison python libyaml-dev
sudo apt-get install libffi6
sudo apt-get install libffi7
sudo python ../get-pip.py
pip install prettytable Mako pyaml dateutils --upgrade

# Leave sources
cd ..
