CGO_ENABLED=0
GOOS=linux
GOARCH=amd64
TAG?=latest
REPO=nsteph/docker-demo

all: build

test:
	@go test -v ./...

binary:
	@go build -o docker-demo .

build:
	@docker build -t ${REPO}:${TAG} .

.PHONY: build binary
