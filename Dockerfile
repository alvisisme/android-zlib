# See https://github.com/alvisisme/docker-android-ndk
FROM alvisisme/android-ndk:r26

RUN apt-get update \
     && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      wget \
      curl \
      ca-certificates \
      unzip \
      binutils \
      autoconf \
      build-essential \
      cmake

ENV ANDROID_NDK_ROOT=/android-ndk-r26

COPY zlib_build.sh /zlib_build.sh
COPY zlib_build_arm64-v8a.sh /zlib_build_arm64-v8a.sh
COPY zlib_build_armeabi-v7a.sh /zlib_build_armeabi-v7a.sh
COPY zlib_build_x86_64.sh /zlib_build_x86_64.sh
COPY zlib_build_x86.sh /zlib_build_x86.sh

VOLUME ["/builds"]
