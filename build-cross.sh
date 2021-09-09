#!/bin/sh

mkdir -p output
cd output 

if [ ! -d ./cross-build ]; then
  mkdir -p cross-build
  cd cross-build
  cmake -G "Unix Makefiles" -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=True -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld' -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=Off -DLLVM_INCLUDE_EXAMPLES=Off -DCMAKE_INSTALL_PREFIX=$CROSS -DLLVM_DEFAULT_TARGET_TRIPLE=amd64-uml-vali ../../sources/llvm-project
  
  #$(eval CPU_COUNT = $(shell nproc))
  #make -j$(CPU_COUNT)
  make
  sudo make install
  cd ../..
else
  cd cross-build
  make
  sudo make install
  cd ../..
fi
