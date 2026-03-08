#!/bin/bash
RELEASE=walnascar

if [[ -z $KERNEL ]]; then
    KERNEL=linux-mono
fi

if [[ -z $IMAGE ]]; then
    IMAGE=monogateway-image
fi

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
    if [[ "$INIT" -eq "repo" ]]; then
        repo init -u https://github.com/nxp-qoriq/yocto-sdk -b walnascar
    fi
    repo sync

    cd sources
    git clone https://github.com/egrissino/meta-monogateway.git -b MonoSupport
    git clone https://github.com/we-are-mono/meta-mono.git
    cd ../
fi

mkdir -p build
mkdir -p build/conf

cp ./sources/meta-monogateway/conf/local.conf $BUILD_DIR/conf/local.conf
cp ./sources/meta-monogateway/conf/bblayers.conf $BUILD_DIR/conf/bblayers.conf

source sources/poky/oe-init-build-env

if [[ ! -z "$CLEAN" ]]; then
    bitbake -c cleanall $KERNEL
    bitbake -c cleanall $IMAGE
fi

bitbake $IMAGE $BITBAKE_OPTS