#!/bin/bash
RELEASE=kirkstone

if [[ ! -z "$DRY_RUN" ]]; then
    BITBAKE_OPTS+=" --dry-run"
fi

mkdir -p sources && cd sources

git clone git://git.yoctoproject.org/git/poky
git clone git://git.yoctoproject.org/meta-freescale
git clone git://git.openembedded.org/meta-openembedded
git clone https://github.com/egrissino/meta-monogateway.git

cd poky && git switch $RELEASE && cd ..
cd meta-freescale && git switch $RELEASE && cd ..
cd meta-openembedded && git switch $RELEASE && cd ..

cd ..

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="build"
fi

echo $BUILD_DIR

mkdir -p $BUILD_DIR

cp -r ./sources/meta-monogateway/conf $BUILD_DIR

source sources/poky/oe-init-build-env

bitbake core-image-minimal $BITBAKE_OPTS