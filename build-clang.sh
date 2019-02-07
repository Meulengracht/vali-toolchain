#!/bin/sh

mkdir -p output
cd output

if ! [ -x "$(command -v clang)" ]; then
  if [ ! -d ./build ]; then
    mkdir -p build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_EH=True -DLLVM_ENABLE_RTTI=True ../../sources/llvm
  else
  cd build
  fi
  make
  sudo make install
  cd ..
fi
