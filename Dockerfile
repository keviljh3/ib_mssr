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
RUN apt-get install iptables -y

RUN wget -O /root/finalspeed_server.zip https://github.com/kevinljh11/finalspeed/raw/master/finalspeed_server10.zip
RUN wget -O /root/ssr.zip https://github.com/shadowsocksrr/shadowsocksr/archive/akkariiin/dev.zip
RUN wget -O /root/udp2raw_amd64 https://github.com/kevinljh11/kcp_udp_fs/raw/master/udp2raw_amd64
RUN wget -O /root/kcps64_170120 https://github.com/kevinljh11/kcp_udp_fs/raw/master/kcps64_170120

RUN apt-get purge git build-essential autoconf libtool libssl-dev -y  && apt-get autoremove -y && apt-get autoclean -y
RUN mkdir -p /opt/finalspeed && cd /opt/finalspeed && unzip /root/finalspeed_server.zip
RUN mkdir -p /opt/ssr && cd /opt/ssr && unzip /root/ssr.zip
#RUN rm -rf /root/shadowsocks-libev
COPY start_finalspeed /opt/finalspeed/start_finalspeed
COPY supervisord.conf /etc/supervisord.conf
#COPY server_linux_amd64 /root/server_linux_amd64
#RUN chmod a+x /root/server_linux_amd64
RUN chmod a+x /opt/finalspeed/start_finalspeed
RUN chmod a+x /root/udp2raw_amd64
ADD start.sh /start.sh
RUN chmod a+x /start.sh
RUN chmod a+x /root/kcps64_170120
#EXPOSE 150/udp 151/udp 8339/tcp 17517/tcp
EXPOSE 150/udp 151/udp 152/tcp
RUN uname -a
RUN iptables -V
#RUN /root/udp2raw_amd64 -s -l0.0.0.0:152 -r 127.0.0.1:151 -k "passwd" --raw-mode faketcp -a
RUN ls /root

#CMD ["sh", "-c", "/start.sh"]
CMD ["/usr/bin/supervisord"]
