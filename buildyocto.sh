#!/bin/bash
RELEASE=kirkstone

if [[ ! -z "$DRY_RUN" ]]; then
    BITBAKE_OPTS+=" --dry-run"
fi

if [[ ! -z "$SDK" ]]; then
    BITBAKE_OPTS+=" -C meta-toolchain"
fi

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="build"
fi

if [[ ! -z "$INIT" ]]; then
    # Download sources
    # TODO : Move this to gerrit repo manifest
    mkdir -p sources && cd sources
    git clone git://git.yoctoproject.org/git/poky
    git clone git://git.yoctoproject.org/meta-freescale
    git clone git://git.openembedded.org/meta-openembedded
    git clone https://github.com/egrissino/meta-monogateway.git

    cd poky && git switch $RELEASE && cd ..
    cd meta-freescale && git switch $RELEASE && cd ..
    cd meta-openembedded && git switch $RELEASE && cd ..
    cd meta-monogateway && git switch machine-ls1046a-gateway && cd ..
    cd ..

    echo $BUILD_DIR
    mkdir -p $BUILD_DIR
fi

cp ./sources/meta-monogateway/conf/local.conf $BUILD_DIR/conf/local.conf
cp ./sources/meta-monogateway/conf/bblayers.conf $BUILD_DIR/conf/bblayers.conf
cp -r ./sources/meta-monogateway/conf/machine/* $BUILD_DIR/conf/machine

source sources/poky/oe-init-build-env

bitbake core-image-minimal $BITBAKE_OPTS