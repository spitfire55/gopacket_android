#!/bin/bash

ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
wget -O /opt/android-sdk.zip --quiet $ANDROID_SDK_URL
unzip -d /opt/android-sdk /opt/android-sdk.zip
rm -f /opt/android-sdk.zip
chown -R root:root /opt/android-sdk