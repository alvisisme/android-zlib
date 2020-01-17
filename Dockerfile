FROM alvisisme/android-ndk:r13b

RUN /bin/bash /android-ndk-r13b/build/tools/make-standalone-toolchain.sh --arch=arm64 \
    --platform=android-21 --toolchain=aarch64-linux-android-4.9 --stl=libc++ --install-dir=/opt/arm64-android-toolchain

ENV PATH=$PATH:/opt/arm64-android-toolchain/bin
ENV CC=/opt/arm64-android-toolchain/bin/aarch64-linux-android-gcc
ENV CXX=/opt/arm64-android-toolchain/bin/aarch64-linux-android-g++
ENV LINK=/opt/arm64-android-toolchain/bin/aarch64-linux-android-g++
ENV LD=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ld
ENV AR=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ar
ENV RANLIB=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ranlib
ENV STRIP=/opt/arm64-android-toolchain/bin/aarch64-linux-android-strip
ENV OBJCOPY=/opt/arm64-android-toolchain/bin/aarch64-linux-android-objcopy
ENV OBJDUMP=/opt/arm64-android-toolchain/bin/aarch64-linux-android-objdump
ENV NM=/opt/arm64-android-toolchain/bin/aarch64-linux-android-nm
ENV AS=/opt/arm64-android-toolchain/bin/aarch64-linux-android-as
ENV SYSROOT=/opt/arm64-android-toolchain/sysroot

USER root
WORKDIR /out
VOLUME ["/out"]
CMD ["/bin/bash","/out/build.sh"]
