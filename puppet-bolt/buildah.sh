#!/bin/bash

set -ex

container=$(buildah from centos:centos7)

buildah run "$container" useradd -U puppet
buildah run "$container" yum --setopt=tsflags=nodocs update -y
buildah run "$container" rpm -Uhv https://yum.puppetlabs.com/puppet6-release-el-7.noarch.rpm
buildah run "$container" yum --setopt=tsflags=nodocs install -y puppet-bolt-1.31.1
buildah run "$container" bash -c 'mkdir -p /home/puppet/.puppetlabs/bolt && touch /home/puppet/.puppetlabs/bolt/analytics.yaml && echo "disabled: true" >> /home/puppet/.puppetlabs/bolt/analytics.yaml'
buildah run "$container" bash -c 'yum clean all && rm -rf /var/cache/yum'

buildah config --user puppet "$container"
buildah config --entrypoint '["/usr/local/bin/bolt"]' "$container"
buildah config --created-by 'tcassaert' "$container"
buildah config --author 'tcassaert at inuits.eu @tcassaert' --label name=centos7-puppet-bolt:1.31.1 "$container"

buildah commit "$container" quay.io/tcassaert/centos7-puppet-bolt:1.31.1

buildah rm "$container"

