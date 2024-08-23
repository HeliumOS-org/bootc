## bootc image for HeliumOS

[![OCI Repository](https://quay.io/repository/heliumos/bootc/status "OCI Repository")](https://quay.io/repository/heliumos/bootc)

## Usage

Building version 9

```bash
podman build -t localhost/heliumos-bootc:9 -f 9/Containerfile .
```

Building version 9-edge

```bash
podman build -t localhost/heliumos-bootc:9-edge -f 9/Containerfile.edge .
```
