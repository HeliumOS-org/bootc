#!/usr/bin/env sh


set -e


mkdir -p /usr/lib/systemd/system/


cp /workdir/systemd_services/*.service /usr/lib/systemd/system/ | true
