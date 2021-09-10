#!/bin/sh

mkdir -p sources
cd sources
  
if [ ! -d ./llvm-project ]; then
  echo Checking out llvm
  git clone https://github.com/umbrella-c/llvm-project
  echo Checkout done
fi

cd ..
