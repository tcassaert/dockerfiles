#!/bin/bash

set -ex

container=$(buildah from centos:centos7)

buildah run "${container}" yum -y --setopt=tsflags=nodocs update
buildah run "${container}" yum -y --setopt=tsflags=nodocs install httpd
buildah run "${container}" yum clean all

buildah copy "${container}" run-httpd.sh /run-httpd.sh
buildah run "${container}" chmod -v +x /run-httpd.sh

buildah config --port 80 "${container}"
buildah config --cmd '/run-httpd.sh' "${container}"
buildah config --created-by 'tcassaert' "${container}"
buildah config --author 'tcassaert at inuits.eu @tcassaert' --label name=centos7-httpd "${container}"

buildah commit "${container}" tcassaert/centos7-httpd

buildah rm "${container}"
