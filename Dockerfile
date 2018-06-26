FROM alvisisme/arm64-android-toolchain

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y binutils

COPY build.sh /build.sh

VOLUME ["/home/out"]
CMD ["/bin/bash", "/build.sh"]
