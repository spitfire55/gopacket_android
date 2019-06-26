REPO=gopacketdroid
NAME=$(shell basename $(shell pwd))
TAG=latest
FULL_NAME=${REPO}/${NAME}:${TAG}

all:
	${MAKE} build
	${MAKE} create
	${MAKE} deploy
	${MAKE} run

build:
	docker build -t ${FULL_NAME} .

create:
	docker create -ti --name ${NAME} ${FULL_NAME} bash
	docker cp ${NAME}:/app/main .
	docker rm -fv ${NAME}

deploy:
	adb push ./main /sdcard/gopacket_android
	adb shell "su -c 'mount -o rw,remount /system; mv /sdcard/gopacket_android /system/bin; chmod +x /system/bin/gopacket_android'"

run:
	adb shell "su -c 'gopacket_android'"
