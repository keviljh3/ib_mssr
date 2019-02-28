# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yourtion, Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

MAINTAINER kammy <xxxxxxxx@gmail.com>

# Commands to update the image
RUN apt-get -y update && apt-get -y upgrade

#build-essential

RUN apt-get install build-essential autoconf libtool libssl-dev git openjdk-8-jre unzip \
	libpcap-dev wget supervisor -y

RUN wget -O /root/finalspeed_server.zip https://github.com/kevinljh11/finalspeed/raw/master/finalspeed_server10.zip
RUN wget -O /root/ssr.zip https://github.com/shadowsocksrr/shadowsocksr/archive/akkariiin/dev.zip
RUN wget -O /root/udp2raw_amd64 https://github.com/kevinljh11/kcp_udp_fs/raw/master/udp2raw_amd64

RUN apt-get purge git build-essential autoconf libtool libssl-dev -y  && apt-get autoremove -y && apt-get autoclean -y
RUN mkdir -p /opt/finalspeed && cd /opt/finalspeed && unzip /root/finalspeed_server.zip
RUN mkdir -p /opt/ssr && cd /opt/ssr && unzip /root/ssr.zip
#RUN rm -rf /root/shadowsocks-libev
COPY start_finalspeed /opt/finalspeed/start_finalspeed
COPY supervisord.conf /etc/supervisord.conf
COPY server_linux_amd64 /root/server_linux_amd64
RUN chmod a+x /root/server_linux_amd64
RUN chmod a+x /opt/finalspeed/start_finalspeed
#RUN chmod +x /root/udp2raw_amd64
#EXPOSE 150/udp 151/udp 8339/tcp 17517/tcp
EXPOSE 150/udp 151/udp
RUN uname -a

CMD ["/usr/bin/supervisord"]
