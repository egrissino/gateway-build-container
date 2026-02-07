#!/bin/bash
RELEASE=walnascar

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
    repo init -u https://github.com/nxp-qoriq/yocto-sdk -b walnascar
    repo sync

    cd sources
    git clone https://github.com/egrissino/meta-monogateway.git -b machine-ls1046a-gateway

    cd ../
fi

mkdir -p build
mkdir -p build/conf

cp ./sources/meta-monogateway/conf/local.conf $BUILD_DIR/conf/local.conf
cp ./sources/meta-monogateway/conf/bblayers.conf $BUILD_DIR/conf/bblayers.conf
cp -r ./sources/meta-monogateway/conf/machine/* $BUILD_DIR/conf/machine

source sources/poky/oe-init-build-env

bitbake core-image-minimal $BITBAKE_OPTS