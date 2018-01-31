# https://github.com/alvisisme/docker-android-ndk/blob/r13b/Dockerfile
FROM alvisisme/docker-android-ndk:r13b

ENTRYPOINT []
CMD ["/bin/bash","/home/dev/arm64/bin/build.sh"]
VOLUME ["/home/dev/out"]

ENV PATH=$PATH:/home/dev/arm64/bin
ENV CC=/home/dev/arm64/bin/aarch64-linux-android-gcc
ENV CXX=/home/dev/arm64/bin/aarch64-linux-android-g++
ENV LINK=/home/dev/arm64/bin/aarch64-linux-android-g++
ENV LD=/home/dev/arm64/bin/aarch64-linux-android-ld
ENV AR=/home/dev/arm64/bin/aarch64-linux-android-ar
ENV RANLIB=/home/dev/arm64/bin/aarch64-linux-android-ranlib
ENV STRIP=/home/dev/arm64/bin/aarch64-linux-android-strip
ENV OBJCOPY=/home/dev/arm64/bin/aarch64-linux-android-objcopy
ENV OBJDUMP=/home/dev/arm64/bin/aarch64-linux-android-objdump
ENV NM=/home/dev/arm64/bin/aarch64-linux-android-nm
ENV AS=/home/dev/arm64/bin/aarch64-linux-android-as

RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y binutils
RUN /usr/local/android-ndk-r13b/build/tools/make_standalone_toolchain.py --arch arm64 --api 21 --stl gnustl --force --install-dir /home/dev/arm64
RUN wget https://raw.githubusercontent.com/alvisisme/android-zlib/master/build.sh -O /home/dev/arm64/bin/build.sh

