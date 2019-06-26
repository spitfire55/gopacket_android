FROM openjdk:8

# Install dependencies
RUN  apt-get update && apt-get install -y curl wget unzip file git make byacc bison flex

# Install expect for Android license scripting
COPY scripts/install_expect.sh /scripts/install_expect.sh
RUN /scripts/install_expect.sh

# Download Android SDK
COPY scripts/setup_android_sdk.sh /scripts/setup_android_sdk.sh
RUN /scripts/setup_android_sdk.sh
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=${PATH}:/scripts:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Auto-accept Android SDK/NDK licenses scripts
COPY scripts/accept_license.sh /scripts/accept_license.sh
COPY scripts/accept_android_licenses.sh /scripts/accept_android_licenses.sh
RUN /scripts/accept_android_licenses.sh

# Install NDK and make standalone toolchain
ENV ANDROID_NDK "ndk-bundle" "cmake;3.6.4111459" "lldb;3.1"
RUN accept_license.sh "sdkmanager --verbose ${ANDROID_NDK}"
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
RUN ${ANDROID_NDK_HOME}/build/tools/make-standalone-toolchain.sh --platform=21 --install-dir=/standalone --toolchain=arm-linux-androideabi-4.9
ENV PATH /standalone/bin:${PATH}

# Install Go and related dependencies
RUN wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
RUN tar xzf go1.12.6.linux-amd64.tar.gz

# Build custom libpcap for Android use
COPY /scripts/libpcap.sh .
RUN ./libpcap.sh

# Download gopacket libraries
RUN /go/bin/go get -d github.com/google/gopacket/...

WORKDIR /app
COPY go/ .
RUN CGO_CFLAGS="-I/standalone/include -I/libpcap" \
    CGO_LDFLAGS="-L/standalone/lib -L/libpcap" \
    CC=arm-linux-androideabi-gcc \
    CGO_ENABLED=1 \
    GOOS=android \
    GOARCH=arm \
    GOARM=7 \
    /go/bin/go build -o main
