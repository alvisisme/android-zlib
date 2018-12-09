#!/bin/bash
ZLIB_VERSION=1.2.11

CWD=$PWD
mkdir -p $CWD/build

cd $CWD/build
if [ ! -f zlib.tar.gz ];then
wget https://github.com/madler/zlib/archive/v$ZLIB_VERSION.tar.gz -O zlib.tar.gz
fi
if [ -d zlib ];then
rm -rf zlib
fi

tar xf zlib.tar.gz
mv zlib-$ZLIB_VERSION zlib
cd zlib
# 删除199和189行关于生成so库版本后缀的语句
sed -i '199d' CMakeLists.txt
sed -i '189d' CMakeLists.txt
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$CWD/build ..
make
make install

cd $CWD
