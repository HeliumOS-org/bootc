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
		./iso/config.ks \
		./out/config.ks

	sed -i \
    "s,<URL>,$(IMAGE):$(TAG),g" \
    ./out/config.ks

	wget https://repo.almalinux.org/almalinux/10/isos/x86_64/AlmaLinux-10.1-x86_64-boot.iso
	mv AlmaLinux-10.1-x86_64-boot.iso ./out/upstream.iso

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
			--ks /output/config.ks \
			--add /images \
			--volid heliumos-${VERSION}-boot \
			--replace "vmlinuz" "vmlinuz inst.resolution=1280x800" \
			/output/upstream.iso \
			/output/HeliumOS-${VERSION}-${ARCH}-boot.iso'
