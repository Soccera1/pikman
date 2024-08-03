#! /bin/bash

set -e

VERSION="1.25.2.0.1"

source ./pika-build-config.sh

echo "$PIKA_BUILD_ARCH" > pika-build-arch

# Clone Upstream
mkdir -p ./pikman
cp -rvf ./* ./pikman || true
cd ./pikman

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p pikman_"$VERSION" || echo "dh-make: Ignoring Last Error"
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
