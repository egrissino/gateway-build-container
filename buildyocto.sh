#!/bin/bash
RELEASE=kirstone

mkdir -p sources

git clone -b $RELEASE https://git.yoctoproject.org/git/poky
git clone -b $RELEASE git://git.yoctoproject.org/meta-freescale
git clone -b $RELEASE git://git.openembedded.org/meta-openembedded
git clone -b $RELEASE https://github.com/egrissino/meta-monogateway.git

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="build"
fi

echo $BUILD_DIR

mkdir -p $BUILD_DIR

cp -r ./sources/meta-monogateway/conf $BUILD_DIR

source sources/poky/oe-init-build-env

bitbake core-image-minimal