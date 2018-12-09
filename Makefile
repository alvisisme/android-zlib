all: build

env:
	docker-compose build

build: env
	docker-compose run android-build-zlib

# TODO: 权限不足时需要先改变权限： sudo chown -R $USER:$USER build
dist:
	rm -rf dist/*
	cp -r build/lib/ dist/lib
	cp -r build/include dist/include

.PHONY: env build dist