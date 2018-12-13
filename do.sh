#!/bin/bash

set -e

LBL=videoio

test_one()
{
set -e
TAG=${LBL}_$1
DFILE=Dockerfile-$1
shift 1
cowsay "Build image: ${TAG}"
docker build \
    --build-arg http_proxy \
    --build-arg https_proxy \
    --build-arg BASE=${LBL}_base \
    -f ${DFILE}  \
    -t ${TAG} \
    .
cowsay "Test build: ${TAG}"
docker run -it \
    -v $(readlink -f ../opencv):/opencv:ro \
    -v $(readlink -f .):/scripts:ro \
    -v ${LBL}_cache:/cache \
    ${TAG} \
    /scripts/build.sh $@
}

#=====================================

test_one base
test_one ffmpeg -DWITH_FFMPEG=ON
test_one gstreamer -DWITH_GSTREAMER=ON
test_one v4l -DWITH_V4L=ON
test_one aravis -DWITH_ARAVIS=ON
test_one dc1394 -DWITH_1394=ON
test_one gphoto -DWITH_GPHOTO2=ON
test_one openni -DWITH_OPENNI2=ON
test_one mediasdk -DWITH_MFX=ON
test_one realsense -DWITH_LIBREALSENSE=ON
test_one ximea -DWITH_XIMEA=ON
test_one xine -DWITH_XINE=ON
test_one pvapi -DWITH_PVAPI=ON
