#!/bin/bash

# All toolchain can be obtained from kali nethunter kernel builder
# Clone it and run build.sh select Set up environment & download toolchains
# Finally change the paths based on your situation 

if [ $# -eq 0  ];then
    echo "Usage: build.sh <prd> {clean}"
    exit
fi

PRD=$1
OUT=out
DEFCONFIG=${PRD}_defconfig

if [ "$2" = "clean" ];then
    echo "Clean out dir: $OUT"
    rm -rf $OUT
    mkdir $OUT
fi

export ARCH=arm64
export SUBARCH=arm64

export KBUILD_BUILD_VERSION=1
export KBUILD_USER=linlinger
export LOCALVERSION="ddqdqdq-dev"

make O=$OUT $DEFCONFIG

PATH="/home/linlinger/android/toolchains/clang-10.0/bin:$PATH" \
make -j4 O=$OUT \
CC=clang \
CLANG_TRIPLE=aarch64-linux-gnu- \
CROSS_COMPILE=/home/linlinger/android/toolchains/aarch64-4.9/bin/aarch64-linux-android- \
CROSS_COMPILE_ARM32=/home/linlinger/android/toolchains/armhf-4.9/bin/arm-linux-androideabi- \
CLANG_TRIPLE=aarch64-linux-gnu- \
AR=llvm-ar \
NM=llvm-nm \
OBJCOPY=llvm-objcopy \
OBJDUMP=llvm-objdump \
STRIP=llvm-strip \
| tee kernel.log
