#!/bin/sh
if [ -z ${var+x} ]; then
  export CROSS=$PWD/build
else 
  echo "CROSS was set"
fi

echo "build directory is: '$CROSS'"
mkdir -p $CROSS

# Execute scripts in correct order
./depends.sh
./checkout.sh
./build-cross.sh

# Zip up resulting builds so they can be imported
INIT_PWD=$PWD
cd $CROSS
zip -r cross-compiler.zip .
cd $INIT_PWD
mv $CROSS/cross-compiler.zip .
rm $CROSS/cross-compiler.zip
