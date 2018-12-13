#!/bin/bash

mkdir /build
pushd /build && rm -rf *
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
    $@
ninja
popd
