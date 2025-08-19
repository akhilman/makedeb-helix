#!/bin/bash
podman run \
  --pull newer \
  -i \
  --rm \
  -v $(dirname $0)/:/pkg/:rw \
  --name helix-makedeb \
  $@ \
  ghcr.io/makedeb/makedeb:debian-trixie \
  bash -c "sudo -E apt update && sudo -E apt dist-upgrade -y && cp /pkg/PKGBUILD ./ && makedeb -s --no-confirm && sudo cp *.deb /pkg/"
