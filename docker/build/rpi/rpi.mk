BOARDS += rpi

local-rpi: version local
	docker buildx build --tag frigate:latest-rpi --build-arg BASE_IMAGE=frigate:latest --load --file docker/build/rpi/Dockerfile .

build-rpi: arm64
	docker buildx build --platform linux/arm64 --build-arg BASE_IMAGE=$(IMAGE_REPO):${VERSION}-$(COMMIT_HASH) --tag $(IMAGE_REPO):${VERSION}-$(COMMIT_HASH)-rpi --file docker/build/rpi/Dockerfile .

push-rpi: build-rpi
	docker buildx build --push --platform linux/arm64 --build-arg BASE_IMAGE=$(IMAGE_REPO):${VERSION}-$(COMMIT_HASH) --tag $(IMAGE_REPO):${GITHUB_REF_NAME}-$(COMMIT_HASH)-rpi --file docker/build/rpi/Dockerfile .