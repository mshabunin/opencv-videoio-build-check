#!/bin/bash

set -exu

mkdir -p workspace

LBL=opencv-videoio-build-checker

test_one()
{
set -e
NAME=$1
TAG=${LBL}_$1
DFILE=Dockerfile-$1
shift 1
docker build \
    --build-arg BASE=${LBL}_base \
    -f ${DFILE}  \
    -t ${TAG} \
    .
docker run -it \
    -u $(id -u):$(id -g) \
    -v `pwd`/../opencv:/opencv:ro \
    -v `pwd`/scripts:/scripts:ro \
    -v `pwd`/workspace:/workspace \
    ${TAG} \
    /scripts/build.sh $NAME $@
}

#=====================================

test_one base
test_one ffmpeg -DWITH_FFMPEG=ON
test_one gstreamer -DWITH_GSTREAMER=ON
test_one v4l -DWITH_V4L=ON
# test_one aravis -DWITH_ARAVIS=ON
test_one dc1394 -DWITH_1394=ON
test_one gphoto -DWITH_GPHOTO2=ON
test_one openni -DWITH_OPENNI2=ON
test_one mediasdk -DWITH_MFX=ON -DWITH_LIBVA=ON
test_one realsense -DWITH_LIBREALSENSE=ON
test_one ximea -DWITH_XIMEA=ON
test_one xine -DWITH_XINE=ON
test_one pvapi -DWITH_PVAPI=ON
