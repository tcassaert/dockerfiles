FROM centos:centos7

MAINTAINER Thomas Cassaert "tcassaert@inuits.eu"

RUN yum update -y \
  && yum -y install ruby-devel rubygems gcc make rpmdevtools \
  && yum clean all

RUN gem install --no-ri --no-rdoc fpm

WORKDIR /src

CMD "/src/fpm.sh"
