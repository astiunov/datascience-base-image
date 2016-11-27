VERSION=latest
IMAGE_NAME=data-science:$(VERSION)
IMAGE_NAME_JUPYTER=data-science-jupyter:$(VERSION)

build_contest: Dockerfile
	docker build -t $(IMAGE_NAME) .

build_jupyter: Dockerfile-jupyter build_contest
	docker build -t $(IMAGE_NAME_JUPYTER) -f Dockerfile-jupyter .

build: build_contest build_jupyter ;

test:
	docker run $(IMAGE_NAME_JUPYTER) /bin/bash -c "source activate py3_env && python --version && source activate py2_env && python --version && source activate r_env && R --version"

tag:
	docker tag $(IMAGE_NAME) astiunov/$(IMAGE_NAME) && \
	docker tag $(IMAGE_NAME_JUPYTER) astiunov/$(IMAGE_NAME_JUPYTER)

push: tag
	docker login -e="$(DOCKER_EMAIL)" -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)" && \
	docker push astiunov/$(IMAGE_NAME) && \
	docker push astiunov/$(IMAGE_NAME_JUPYTER)
