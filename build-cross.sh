#!/bin/sh

mkdir -p output
cd output 

if [ ! -d ./cross-build ]; then
  mkdir -p cross-build
  cd cross-build
  cmake -G "Unix Makefiles" -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=True -DLLVM_ENABLE_EH=True -DLLVM_ENABLE_RTTI=True -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=Off -DLLVM_INCLUDE_EXAMPLES=Off -DCMAKE_INSTALL_PREFIX=$CROSS -DLLVM_DEFAULT_TARGET_TRIPLE=i386-pc-win32-itanium-coff ../../sources/llvm
  
	$(eval CPU_COUNT = $(shell nproc))
  make -j$(CPU_COUNT)
  sudo make install
  cd ../..
else
  cd cross-build
  make
  sudo make install
  cd ../..
fi
