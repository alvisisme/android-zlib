all: env build

env:
	docker build -t android-zlib-build .

build:
	docker run --rm -v `pwd`/out:/home/dev/out android-zlib-build
