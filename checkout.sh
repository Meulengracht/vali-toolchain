#!/bin/sh

mkdir -p sources
cd sources
  
if [ ! -d ./llvm-project ]; then
  echo Checking out llvm
  git clone https://github.com/umbrella-c/llvm-project
  cd llvm-project
  git checkout 108db006bde2fbe31fae792ed9a451c5d894cf14
  cd ..
  echo Checkout done
fi

cd ..
