#!/bin/sh
[ -z "$CROSS" ] && echo "Need to set CROSS directory" && exit 1;

# Execute scripts in correct order
./depends.sh
./checkout.sh
./build-cross.sh

# Zip up resulting builds so they can be imported
publish_path=$(pwd)
cd $CROSS
zip -r cross-compiler.zip .
cd $(publish_path)
mv $(CROSS)/cross-compiler.zip .