#!/bin/bash

apt-get update
apt-get install -y git

apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker*
apt-get install -y docker-engine

service docker stop
rm -rf /var/lib/docker/*
cd /var/lib
dd if=/dev/zero of=disk bs=1 count=0 seek=50G
apt-get install -y btrfs-tools
mkfs.btrfs disk
mount -o loop disk docker
service docker start
