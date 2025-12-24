SUDO := sudo
PODMAN := $(SUDO) podman
IMAGE := quay.io/heliumos/bootc
IS_CANARY := true
IS_EDGE := false
VERSION := 10
ARCH := x86_64

TAG := $(VERSION)
ifeq ($(IS_CANARY),true)
	TAG := $(TAG)-canary
endif
ifeq ($(IS_EDGE),true)
	TAG := $(TAG)-edge
endif

PLAYBOOK := $(VERSION)
ifeq ($(IS_EDGE),true)
	PLAYBOOK := $(PLAYBOOK)-edge
endif

.PHONY: echo-image echo-tag image push iso

echo-image:
	@echo $(IMAGE)

echo-tag:
	@echo $(TAG)

image:
	$(PODMAN) build \
		--build-arg BASE=quay.io/almalinuxorg/almalinux-bootc:$(VERSION) \
		--build-arg PLAYBOOK=$(PLAYBOOK).yaml \
		--network host \
		-f Containerfile \
		-t $(IMAGE):$(TAG) \
		.

rechunk:
	$(SUDO) IMAGE=$(IMAGE):$(TAG) ./rechunk.sh

push:
	$(PODMAN) push \
		$(IMAGE):$(TAG)

iso:
	$(SUDO) rm -rf ./out
	mkdir ./out

	cp \
		./iso/config.toml \
		./out/config.toml

	sed -i \
    "s,<URL>,$(IMAGE):$(TAG),g" \
    ./out/config.toml

	$(PODMAN) pull $(IMAGE):$(TAG)

	$(PODMAN) run \
		--rm \
		-it \
		--privileged \
		--pull=newer \
		--security-opt label=type:unconfined_t \
		-v ./out/config.toml:/config.toml:ro \
		-v ./out:/output \
		-v /var/lib/containers/storage:/var/lib/containers/storage \
		quay.io/centos-bootc/bootc-image-builder:sha256-6b0433acb5819d62d9afdd8fd735cf3c7cc11dcf9bcc343e7df593423b3994fb \
		--type anaconda-iso \
		--use-librepo=False \
		$(IMAGE):$(TAG)

	mv \
	    /output/bootiso/install.iso \
		/output/upstream.iso

	$(PODMAN) run \
		--rm \
		-it \
		--pull=newer \
		--privileged \
		-v ./out:/output \
		-v ./iso:/iso \
		quay.io/almalinuxorg/almalinux:10.1 \
		bash -c '\
			dnf install -y lorax \
		&& rm -rf /images && mkdir /images \
		&& rm -f /output/HeliumOS-${VERSION}-${ARCH}-boot.iso \
		&& cd /iso/product && find . | cpio -c -o | gzip -9cv > /images/product.img && cd / \
		&& mkksiso \
			--add /images \
			--volid heliumos-${VERSION}-boot \
			--replace "vmlinuz" "vmlinuz inst.resolution=1280x800" \
			/output/upstream.iso \
			/output/HeliumOS-${VERSION}-${ARCH}-boot.iso'
