#!/bin/bash

VERSION=1.2.11
wget https://github.com/madler/zlib/archive/v$VERSION.tar.gz -O zlib-$VERSION.tar.gz
tar xf zlib-$VERSION.tar.gz
cd zlib-$VERSION
sed -i '199d' CMakeLists.txt
sed -i '189d' CMakeLists.txt
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/home/out ..
make
make install
cd ../..
rm zlib-$VERSION.tar.gz
rm -rf zlib-$VERSION
