FROM centos:centos7
MAINTAINER Chesnokov Dmitriy <dachesnokov@outlook.com>
RUN yum -y install deltarpm
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y groupinstall "Development Tools"
RUN yum -y install libedit-devel sqlite-devel psmisc gmime-devel ncurses-devel \
  libtermcap-devel sox newt-devel libxml2-devel libtiff-devel audiofile-devel \
  gtk2-devel uuid-devel libtool libuuid-devel subversion kernel-devel \
  kernel-devel-$(uname -r) git subversion kernel-devel \
  crontabs cronie cronie-anacron wget

# Install jansson
WORKDIR /usr/src
RUN wget http://www.digip.org/jansson/releases/jansson-2.12.tar.gz
RUN tar xvfz jansson-2.12.tar.gz
WORKDIR /usr/src/jansson-2.12
RUN autoreconf -fi
RUN ./configure --libdir=/usr/lib64
RUN make
RUN make check
RUN make install

# Install pjproject
WORKDIR /usr/src
RUN wget http://www.pjsip.org/release/2.9/pjproject-2.9.tar.bz2
RUN tar -xjvf pjproject-2.9.tar.bz2
WORKDIR /usr/src/pjproject-2.9
RUN ./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr \
  --libdir=/usr/lib64 --enable-shared --disable-video \
  --disable-sound --disable-opencore-amr
RUN make dep
RUN make
RUN make install
RUN ldconfig

# Install Asterisk 16:
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar xvfz asterisk-16-current.tar.gz
WORKDIR /usr/src/asterisk-16.9.0
RUN contrib/scripts/install_prereq install
RUN contrib/scripts/get_mp3_source.sh
RUN ./configure --libdir=/usr/lib64 --with-jansson-bundled --with-pjproject-bundled \
  --with-crypto --with-ssl=ssl --with-srtp
RUN make menuselect.makeopts
RUN menuselect/menuselect \
  --enable format_mp3 \
  --enable res_config_mysql \
  --enable app_mysql \
  --enable cdr_mysql \
  --enable CORE-SOUNDS-RU-WAV \
  --enable MOH-OPSOUND-WAV \
  --enable EXTRA-SOUNDS-EN-WAV \
  menuselect.makeopts
RUN make
RUN make install
RUN make samples
RUN make config
RUN ldconfig

# Install RU-WAV
WORKDIR /var/lib/asterisk/sounds
RUN wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-ru-wav-current.tar.gz \
  && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz \
  && tar xvf asterisk-core-sounds-ru-wav-current.tar.gz \
  && tar xvf asterisk-extra-sounds-en-wav-current.tar.gz
WORKDIR /

RUN rm -f /usr/src/jansson-2.12.tar.gz
RUN rm -f /usr/src/pjproject-2.9.tar.bz2
RUN rm -f /usr/src/asterisk-16-current.tar.gz
RUN rm -f /var/lib/asterisk/sounds/asterisk-core-sounds-ru-wav-current.tar.gz
RUN rm -f /var/lib/asterisk/sounds/asterisk-extra-sounds-en-wav-current.tar.gz
RUN rm -rf /usr/src/jansson-2.12
RUN rm -rf /usr/src/pjproject-2.9
RUN rm -rf /usr/src/asterisk-16.9.0
RUN rm -rf /tmp/*

RUN useradd -m asterisk -s /sbin/nologin
RUN chown asterisk:asterisk /var/run/asterisk
RUN chown -R asterisk:asterisk /etc/asterisk/
RUN chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
RUN chown -R asterisk:asterisk /usr/lib64/asterisk/

ADD start_aster.sh /start_aster.sh
RUN chmod +x /start_aster.sh
CMD ["/start_aster.sh"]
