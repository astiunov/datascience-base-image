VERSION=latest
IMAGE_NAME=contest/data-science:$(VERSION)

build: Dockerfile
	docker build -t $(IMAGE_NAME) .
