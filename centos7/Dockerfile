FROM centos:centos7
MAINTAINER Chesnokov Dmitriy <dachesnokov@outlook.com>
RUN yum -y install deltarpm \
  && yum -y update \
  && yum -y install epel-release \
  && yum -y groupinstall "Development Tools" \
  && yum -y install libedit-devel sqlite-devel psmisc gmime-devel ncurses-devel \
  libtermcap-devel sox newt-devel libxml2-devel libtiff-devel audiofile-devel \
  gtk2-devel uuid-devel libtool libuuid-devel subversion kernel-devel \
  kernel-devel-$(uname -r) git subversion kernel-devel \
  crontabs cronie cronie-anacron wget

# Install jansson
WORKDIR /usr/src
RUN wget http://www.digip.org/jansson/releases/jansson-2.12.tar.gz \
  && tar xvfz jansson-2.12.tar.gz \
  && cd /usr/src/jansson-2.12 \
  && autoreconf -fi \
  && ./configure --libdir=/usr/lib64 \
  && make \
  && make check \
  && make install \
  && cd / \
  && rm -f /usr/src/jansson-2.12.tar.gz \
  && rm -rf /usr/src/jansson-2.12


# Install pjproject
WORKDIR /usr/src
RUN wget http://www.pjsip.org/release/2.9/pjproject-2.9.tar.bz2 \
  && tar -xjvf pjproject-2.9.tar.bz2 \
  && cd /usr/src/pjproject-2.9 \
  && ./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr \
  --libdir=/usr/lib64 --enable-shared --disable-video \
  --disable-sound --disable-opencore-amr \
  && make dep \
  && make \
  && make install \
  && ldconfig \
  && cd / \
  && rm -f /usr/src/pjproject-2.9.tar.bz2 \
  && rm -rf /usr/src/pjproject-2.9

# Install Asterisk 16:
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz \
  && tar xvfz asterisk-16-current.tar.gz \
  && cd /usr/src/asterisk-16.9.0 \
  && contrib/scripts/install_prereq install \
  && contrib/scripts/get_mp3_source.sh \
  && ./configure --libdir=/usr/lib64 --with-jansson-bundled --with-pjproject-bundled \
  --with-crypto --with-ssl=ssl --with-srtp \
  && make menuselect.makeopts \
  && menuselect/menuselect \
  --enable format_mp3 \
  --enable res_config_mysql \
  --enable app_mysql \
  --enable cdr_mysql \
  --enable CORE-SOUNDS-RU-WAV \
  --enable MOH-OPSOUND-WAV \
  --enable EXTRA-SOUNDS-EN-WAV \
  menuselect.makeopts \
  && make \
  && make install \
  && make samples \
  && make config \
  && ldconfig \
  && cd / \
  && rm -f /usr/src/asterisk-16-current.tar.gz \
  && rm -rf /usr/src/asterisk-16.9.0 \
  && rm -rf /tmp/*

# Install RU-WAV
WORKDIR /var/lib/asterisk/sounds
RUN wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-ru-wav-current.tar.gz \
  && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz \
  && tar xvf asterisk-core-sounds-ru-wav-current.tar.gz \
  && tar xvf asterisk-extra-sounds-en-wav-current.tar.gz \
  && rm -f /var/lib/asterisk/sounds/asterisk-core-sounds-ru-wav-current.tar.gz \
  && rm -f /var/lib/asterisk/sounds/asterisk-extra-sounds-en-wav-current.tar.gz \
  rm -rf /tmp/*

WORKDIR /
ADD start_aster.sh /start_aster.sh
RUN chmod +x /start_aster.sh
CMD ["/start_aster.sh"]
