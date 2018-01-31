#!/bin/bash
wget http://prdownloads.sourceforge.net/libpng/zlib-1.2.8.tar.gz && \
tar xf zlib-1.2.8.tar.gz && \
cd zlib-1.2.8 && \
./configure --static --prefix=/home/dev/out && \
make && \
sudo make install && \
cd /home/dev && \
rm zlib-1.2.8.tar.gz && \
rm -rf zlib-1.2.8