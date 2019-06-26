# GoDroideka

## Introduction

GoDroideka is a project that enables cross-compiling Go code that uses Google's [gopacket](https://godoc.org/github.com/google/gopacket) library for Android on *rooted devices*.

### Technical Notes
- To dynamically compile ELF binaries for Android, you have to use the [Native Development Kit (NDK)](https://developer.android.com/ndk/). The NDK is designed for C/C++ code.
- The Go build tools provide a lot of functionality. Cgo and a variety of Go environment variables allows devlopers to gain greater control over how Go compiles their code.
- Libpcap does not exist on Android. We need to cross-compile both libpcap from source and our Go code together in order for gopacket to work on Android.

## Instructions

## 1. Root your Android Device and Enable ADB in Developer Options

Consult [XDA-Developers](https://www.xda-developers.com) and the Googlez for assistance if you are unfamiliar. Difficulty varies across devices and OS versions.

## 3. Run the gopacketdroid build system

- Simply run `make` to build, copy, deploy, and run your Go code. Your Go code should be placed in the `go/` folder. An example `main.go` file has been provided.
