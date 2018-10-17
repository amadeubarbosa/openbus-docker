FROM ubuntu:18.10
LABEL maintainer="OpenBus Users <openbus-users@tecgraf.puc-rio.br>"

# Versions
ENV BOOST_VERSION=1_68_0
ENV BOOST_REMOTE_VERSION=1.68.0
ENV OPENSSL_VERSION=1.0.2p
ENV UUID_VERSION=1.0.3
ENV LDAP_VERSION=2.4.39

# Directories
ENV WORKDIR=/openbus-dev
ENV PACKAGES=$WORKDIR/packages
ENV BOOST_DIR=$WORKDIR/boost_$BOOST_VERSION
ENV OPENSSL_PACKAGE_DIR=$PACKAGES/openssl
ENV OPENLDAP_PACKAGE_DIR=$PACKAGES/openldap
ENV LIBUUID_PACKAGE_DIR=$PACKAGES/libuuid

RUN apt-get update
# Purpose of packages dependencies:
# git: bring dependencies and favor development
# curl: bring packages from urls
# build-essential: ubuntu set of development tools and headers
# groff groff-base: required by soelim in ldap compiling
# libreadline-dev: required by lua compiling

RUN apt-get -y install git curl build-essential groff groff-base libreadline-dev

# Boost dependency (https://boostorg.github.io/build/tutorial.html)
# Unpack boost and Install boost build only
RUN mkdir -p $BOOST_DIR \
  && cd $WORKDIR \
  && curl -L https://dl.bintray.com/boostorg/release/${BOOST_REMOTE_VERSION}/source/boost_${BOOST_VERSION}.tar.bz2 -o boost_${BOOST_VERSION}.tar.bz2 \
  && tar jxf boost_$BOOST_VERSION.tar.bz2 -C $WORKDIR \
  && cd $BOOST_DIR/tools/build \
  && ./bootstrap.sh \
  && ./b2 install \
  && rm $WORKDIR/boost_$BOOST_VERSION.tar.bz2 \
  && rm -Rf $BOOST_DIR

# Install openssl
# OpenSsl are internal in tecgraf
RUN cd $WORKDIR \
  && curl -L http://webserver2.tecgraf.puc-rio.br/ftp_pub/openbus/repository/openssl-$OPENSSL_VERSION.tar.gz -o openssl-$OPENSSL_VERSION.tar.gz \
  && tar zxf $WORKDIR/openssl-$OPENSSL_VERSION.tar.gz -C $WORKDIR \
  && cd $WORKDIR/openssl-$OPENSSL_VERSION \
  && ./config shared --openssldir=$OPENSSL_PACKAGE_DIR \
  && make \
  && make install \
  && rm $WORKDIR/openssl-$OPENSSL_VERSION.tar.gz \
  && rm -rf $WORKDIR/openssl-$OPENSSL_VERSION

# Install LDAP
# LDAP are internal in tecgraf
RUN cd $WORKDIR \
  && curl -L http://webserver2.tecgraf.puc-rio.br/ftp_pub/openbus/repository/openldap-$LDAP_VERSION.tgz -o openldap-$LDAP_VERSION.tgz \
  && tar zxf $WORKDIR/openldap-$LDAP_VERSION.tgz -C $WORKDIR \
  && cd $WORKDIR/openldap-$LDAP_VERSION \
  && ./configure --disable-slapd --with-tls=openssl --with-cyrus-sasl=no --prefix=$OPENLDAP_PACKAGE_DIR LDFLAGS=-L$OPENSSL_PACKAGE_DIR/lib CPPFLAGS=-I$OPENSSL_PACKAGE_DIR/include \
  && make \
  && make install \
  && rm $WORKDIR/openldap-$LDAP_VERSION.tgz \
  && rm -rf $WORKDIR/openldap-$LDAP_VERSION

# Install UUID
# UUID are internal in tecgraf
RUN cd $WORKDIR \
  && curl -L http://webserver2.tecgraf.puc-rio.br/ftp_pub/openbus/repository/libuuid-$UUID_VERSION.tar.gz -o libuuid-$UUID_VERSION.tar.gz \
  && tar zxf libuuid-$UUID_VERSION.tar.gz -C $WORKDIR \
  && cd $WORKDIR/libuuid-$UUID_VERSION \
  && ./configure --prefix=$LIBUUID_PACKAGE_DIR \
  && make \
  && make install \
  && rm $WORKDIR/libuuid-$UUID_VERSION.tar.gz \
  && rm -rf $WORKDIR/libuuid-$UUID_VERSION

# Source functions
ADD scripts/tecgraf_deps.sh $WORKDIR

# Bringing up openbus dependencies
RUN cd $PACKAGES \
  && echo -e "172.30.4.37 git.tecgraf.puc-rio.br\n" >> /etc/hosts \
  && $WORKDIR"/tecgraf_deps.sh"

WORKDIR $WORKDIR/packages/openbus-core/bbuild

# Issue banner
ADD openbus.issue /root

# Hint from interactive prompt
RUN echo "cat /root/openbus.issue" >> /root/.bashrc