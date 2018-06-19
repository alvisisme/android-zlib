#!/bin/bash
VERSION=1.2.11
wget http://prdownloads.sourceforge.net/libpng/zlib-$VERSION.tar.gz && \
tar xf zlib-$VERSION.tar.gz && \
cd zlib-$VERSION && \
./configure --static --prefix=/home/dev/out && \
make && \
sudo make install && \
cd /home/dev && \
rm zlib-$VERSION.tar.gz && \
rm -rf zlib-$VERSION
