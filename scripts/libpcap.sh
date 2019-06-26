#!/bin/bash

git clone https://github.com/android/platform_external_libpcap
mv platform_external_libpcap libpcap

cd libpcap
CC=arm-linux-gnueabi-gcc
./configure --host=arm-linux-androideabi --with-pcap=linux
make
