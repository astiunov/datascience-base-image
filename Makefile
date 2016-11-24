VERSION=latest
IMAGE_NAME=data-science:$(VERSION)

build: Dockerfile
	docker build -t $(IMAGE_NAME) .

test:
	docker run $(IMAGE_NAME) /bin/bash -c "source activate py3_env && python --version && source activate py2_env && python --version && source activate r_env && R --version"

tag:
	docker tag $(IMAGE_NAME) astiunov/$(IMAGE_NAME)
push: tag
	docker login -e="$(DOCKER_EMAIL)" -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)" && \
	docker push astiunov/$(IMAGE_NAME)
