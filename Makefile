BINARY = java-applet-player
GITHUB_USERNAME=sysincz
VERSION?=latest
COMMIT=$(shell git rev-parse --short HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
BUILD_DATE=$(shell date +%FT%T%z)


docker: 
	docker build -t $(GITHUB_USERNAME)/$(BINARY):$(VERSION) .

docker-push: docker
	docker push $(GITHUB_USERNAME)/$(BINARY):$(VERSION)


