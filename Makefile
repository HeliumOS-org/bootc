help:
	@echo -- HeliumOS bootc --
	@echo make build - Build new image
	@echo make upload - Upload image to quay.io
build:
	podman build -t quay.io/heliumos/bootc:latest .
upload:
	podman push quay.io/heliumos/bootc:latest
