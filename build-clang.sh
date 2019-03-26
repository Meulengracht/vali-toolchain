#!/bin/sh

mkdir -p output
cd output

if [ ! -d ./build ]; then
  mkdir -p build
  cd build
  cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_EH=True -DLLVM_ENABLE_RTTI=True ../../sources/llvm
  make
  sudo make install
  cd ..
  cd ..
else
  cd build
  make
  sudo make install
  cd ..
  cd ..
fi
