#!/bin/bash

set -exu

export OPENCV_DOWNLOAD_PATH=/workspace/dlcache
export CCACHE_DIR=/workspace/ccache
export PATH=/usr/lib/ccache:${PATH}

NAME=$1
shift 1

D=/workspace/build_${NAME}
mkdir -p ${D}
pushd ${D} && rm -rf *
cmake -GNinja /opencv \
    -DENABLE_CONFIG_VERIFICATION=ON \
    -DWITH_GSTREAMER=OFF \
    -DWITH_FFMPEG=OFF \
    -DWITH_V4L=OFF \
    -DWITH_1394=OFF \
    -DWITH_VTK=OFF \
    -DWITH_EIGEN=OFF \
    -DWITH_GTK=OFF \
    -DWITH_OPENCLAMDFFT=OFF \
    -DWITH_OPENCLAMDBLAS=OFF \
    -DWITH_LAPACK=OFF \
    -DWITH_VA=OFF \
    -DWITH_VA_INTEL=OFF \
    -DWITH_JASPER=OFF \
    $@
ninja
popd
