#!/bin/bash

set -e
export NDK=/opt/android-ndk

[ ! -f zlib-1.2.8.tar.gz ] && {
wget http://prdownloads.sourceforge.net/libpng/zlib-1.2.8.tar.gz
}

[ ! -f zlib-1.2.8 ] && {
tar xf zlib-1.2.8.tar.gz
}

echo $"Choose arch you like to build, arm(1) or arm64(2)? (1/2)"
read ans;

case $ans in
    1)
        ARCH=arm
        TOOLCHAIN_NAME=arm-linux-android-4.9
        TOOL_PREFIX=arm-linux-androideabi;;
    2)
       	ARCH=arm64
       	TOOLCHAIN_NAME=aarch64-linux-android-4.9
       	TOOL_PREFIX=aarch64-linux-android;;
    *)
        exit;;
esac

# create a local android toolchain
$NDK/build/tools/make-standalone-toolchain.sh \
   --force \
   --arch=$ARCH \
   --platform=android-21 \
   --toolchain=$TOOLCHAIN_NAME \
   --install-dir=`pwd`/$ARCH
 
  # setup environment to use the gcc/ld from the android toolchain
 export TOOLCHAIN_PATH=`pwd`/$ARCH/bin
 export TOOL=$TOOL_PREFIX
 export NDK_TOOLCHAIN_BASENAME=${TOOLCHAIN_PATH}/${TOOL}
 export CC=$NDK_TOOLCHAIN_BASENAME-gcc
 export CXX=$NDK_TOOLCHAIN_BASENAME-g++
 export LINK=${CXX}
 export LD=$NDK_TOOLCHAIN_BASENAME-ld
 export AR=$NDK_TOOLCHAIN_BASENAME-ar
 export RANLIB=$NDK_TOOLCHAIN_BASENAME-ranlib
 export STRIP=$NDK_TOOLCHAIN_BASENAME-strip

 cd zlib-1.2.8
 PATH=$TOOLCHAIN_PATH:$PATH ./configure --static --prefix=$TOOLCHAIN_PATH/..
 PATH=$TOOLCHAIN_PATH:$PATH make
 PATH=$TOOLCHAIN_PATH:$PATH make install


