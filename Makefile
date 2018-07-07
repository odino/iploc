DOCKER_IMAGE_NAME=iploc

test:
	docker run -ti \
		-e LOG_LEVEL=DEBUG \
		-v $$(pwd):/go/src/github.com/odino/${DOCKER_IMAGE_NAME} \
		--net=host \
		${DOCKER_IMAGE_NAME} \
		bash
build:
	docker build -t ${DOCKER_IMAGE_NAME} .
release_simple:
	rm -rf builds/
	docker run -ti --net host -v $$(pwd):/go/src/github.com/odino/${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_NAME} go build -o builds/simple main.go
release: release_simple
	docker run -ti --net host -v $$(pwd):/go/src/github.com/odino/${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_NAME} gox -output="builds/{{.Dir}}_{{.OS}}_{{.Arch}}_$$(./builds/simple version)"
	sudo chown $$USER:$$USER builds
	sudo chown $$USER:$$USER builds/*
	cd builds; ls -la . | grep -v ".tar.gz" | grep ${DOCKER_IMAGE_NAME} | awk '{print "tar -czf " $$9 ".tar.gz " $$9}' | bash
	cd builds; ls -la . | grep -v ".tar.gz" | grep ${DOCKER_IMAGE_NAME} | awk '{print "rm " $$9}' | bash
	ls -la builds
