.PHONY: clean test run

NAME := awesome-app
ORG := acmesoft
IMAGE := $(ORG)/$(NAME)

VERSION := $(shell date '+%y%m%d.%H%M%S')
TAG_VERSION := $(IMAGE):$(VERSION)
TAG_LATEST := $(IMAGE):latest
TAG_LAST_SUCCESS = $(IMAGE):`cat $(BUILD_FILE)`

INSTANCE := $(NAME)-default
BUILD_DIR := .build
BUILD_FILE := $(BUILD_DIR)/version.txt

default:
	make clean
	go get
	make build
	make test

test:
	sonar-scanner \
    	-Dsonar.projectKey=APP \
    	-Dsonar.sources=. \
    	-Dsonar.host.url=http://sonar.103.206.24.85.nip.io:9000 \
    	-Dsonar.branch=`git rev-parse --abbrev-ref HEAD` \
    	-Dsonar.report.export.pat=. \
    	-Dsonar.login=10aa0cbbac8c58ef73cff33a0239dd8692a51211

build:
	mkdir -p $(BUILD_DIR)
	docker build --no-cache --tag $(TAG_VERSION) .
	echo $(VERSION) > $(BUILD_FILE)

push:
	docker tag $(TAG_LAST_SUCCESS) $(TAG_LATEST)
	docker push $(TAG_LAST_SUCCESS)
	docker push $(TAG_LATEST)

deploy_dev:
	ansible-playbook -vv -l dev deploy.yml

deploy_staging:
	ansible-playbook -vv -l staging deploy.yml

deploy_prod:
	ansible-playbook -vv -l prod deploy.yml

clean:
	rm -rf bin/*

run:
	./bin/app


