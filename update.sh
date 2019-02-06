#!/bin/sh

cd sources

if [ -d ./llvm ]; then
  echo Updating llvm
  cd llvm
  git pull
  cd tools/clang
  echo Updating clang
  git pull

  cd tools/extra
  echo Updating clang-extra
  git pull
  cd ../../../..

  cd projects
  echo Updating compiler-rt
  cd compiler-rt
  git pull
  cd ..
  echo Updating libcxxabi
  cd libcxxabi
  git pull
  cd ..
  echo Updating libcxx
  cd libcxx
  git pull
  cd ..
  echo Updating openmp
  cd openmp
  git pull
  cd ..
  echo Updating lld
  cd lld
  git pull
  cd ..
  echo Update done
  cd ../..
fi

cd ..
