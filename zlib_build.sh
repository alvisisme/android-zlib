#!/bin/bash -e

ZLIB_VERSION=1.2.11

ANDROID_TARGET_API=$1
ANDROID_TARGET_ABI=$2

if [ "$ANDROID_TARGET_ABI" == "armeabi-v7a" ]
then
    export TARGET=armv7a-linux-androideabi

elif [ "$ANDROID_TARGET_ABI" == "arm64-v8a" ]
then
    export TARGET=aarch64-linux-android

elif [ "$ANDROID_TARGET_ABI" == "x86" ]
then
    export TARGET=i686-linux-android

elif [ "$ANDROID_TARGET_ABI" == "x86_64" ]
then
    export TARGET=x86_64-linux-android

else
    echo "Unsupported target ABI: $ANDROID_TARGET_ABI"
    exit 1
fi

WORK_PATH=$(cd "$(dirname "$0")";pwd)
OUTPUT_PATH=${WORK_PATH}/builds/${ANDROID_TARGET_ABI}/

export TOOLCHAIN=${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-x86_64
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/${TARGET}${ANDROID_TARGET_API}-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/${TARGET}${ANDROID_TARGET_API}-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

function build_library {
    if [ -d ${OUTPUT_PATH} ];then
    rm -rf ${OUTPUT_PATH}
    fi

    mkdir -p ${OUTPUT_PATH}

    if [ ! -f zlib-${ZLIB_VERSION}.tar.gz ];then
    # wget http://nexus3.alvisisme.site/repository/zlib/zlib-${ZLIB_VERSION}.tar.gz
    wget https://github.com/madler/zlib/archive/v${ZLIB_VERSION}.tar.gz -O zlib-${ZLIB_VERSION}.tar.gz
    fi

    if [ -d zlib-${ZLIB_VERSION} ];then
    rm -rf zlib-${ZLIB_VERSION}
    fi

    tar xf zlib-${ZLIB_VERSION}.tar.gz

    cd zlib-${ZLIB_VERSION}

    # Fix symbol 'gz_intmax' failed error
    # See https://github.com/madler/zlib/issues/856
    sed -i '18d' zlib.map

    cmake \
        -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$TARANDROID_TARGET_ABIGET \
        -DANDROID_PLATFORM=android-$ANDROID_TARGET_API \
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_PATH} .
    make && make install

    echo "Build completed! Check output libraries in ${OUTPUT_PATH}"
}

build_library
