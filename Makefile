VERSION=latest
IMAGE_NAME=data-science:$(VERSION)
IMAGE_NAME_JUPYTER=data-science-jupyter:$(VERSION)

build_base: Dockerfile
	docker build -t $(IMAGE_NAME) .

tag_base: build_base
	docker tag $(IMAGE_NAME) astiunov/$(IMAGE_NAME)

login:
	docker login -e="$(DOCKER_EMAIL)" -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)"

push_base: build_base tag_base login
	docker push astiunov/$(IMAGE_NAME)

build_jupyter: Dockerfile-jupyter tag_base
	docker build -t $(IMAGE_NAME_JUPYTER) -f Dockerfile-jupyter .

tag_jupyter: build_jupyter
	docker tag $(IMAGE_NAME_JUPYTER) astiunov/$(IMAGE_NAME_JUPYTER)

push_jupyter: build_jupyter tag_jupyter login
	docker push astiunov/$(IMAGE_NAME_JUPYTER)

build: build_base build_jupyter ;

test:
	docker run $(IMAGE_NAME_JUPYTER) /bin/bash -c "source activate py3_env && python --version && source activate py2_env && python --version && source activate r_env && R --version"

push: push_base push_jupyter ;
