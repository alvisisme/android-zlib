#!/bin/bash

VERSION=1.2.11
wget https://github.com/madler/zlib/archive/v$VERSION.tar.gz -O zlib-$VERSION.tar.gz
tar xf zlib-$VERSION.tar.gz
cd zlib-$VERSION
./configure --static --prefix=/home/out
make
make install
cd ..
rm zlib-$VERSION.tar.gz
rm -rf zlib-$VERSION
