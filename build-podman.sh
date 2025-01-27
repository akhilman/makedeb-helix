#!/bin/bash
podman run \
  --pull newer \
  -i \
  --rm \
  -v $(dirname $0)/:/pkg/:rw \
  --name helix-makedeb \
  ghcr.io/makedeb/makedeb:debian-bullseye \
  bash -c "cp /pkg/PKGBUILD ./ && makedeb -s --no-confirm && sudo cp *.deb /pkg/"
