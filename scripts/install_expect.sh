#!/bin/bash

curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get update && apt-get install -y apt-transport-https expect lsb-release nodejs
apt-get autoclean