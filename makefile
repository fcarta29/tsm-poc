build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build --rm -f tsm-poc.dockerfile -t fcarta29/tsm-poc:$$TAG .; \
	docker tag fcarta29/tsm-poc:$$TAG fcarta29/tsm-poc:latest

clean:
	docker stop tsm-poc
	docker rm tsm-poc

rebuild: clean build

run:
	docker run --name tsm-poc -v $$PWD/config/kube.conf:/root/.kube/config -v $$PWD/tsm-poc:/tsm-poc -td fcarta29/tsm-poc:latest
	docker exec -it tsm-poc bash -l

join:
	docker exec -it tsm-poc bash -l
start:
	docker start tsm-poc
stop:
	docker stop tsm-poc

default: build
