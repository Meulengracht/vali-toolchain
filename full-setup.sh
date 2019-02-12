#!/bin/sh
[ -z "$CROSS" ] && echo "Need to set CROSS directory" && exit 1;

# Execute scripts in correct order
./depends.sh
./checkout.sh
./build-clang.sh
./build-cross.sh

# Zip up resulting builds so they can be imported
zip -jr cross-compiler.zip $CROSS
