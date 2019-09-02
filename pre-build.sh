#!/bin/bash
#检查是否在debian系统上运行，安装相应包,否则退出
set -e
set -u
set -o pipefail

if [[ ! -f /etc/debian_version ]]; then
  echo "minideb can currently only be built on debian based distros, aborting..."
  exit 1
fi

apt-get update
apt-get install -y debootstrap debian-archive-keyring jq dpkg-dev
