killall python
killall kcps64_170120
killall udp2raw_amd64
#killall java
nohup python /opt/ssr/shadowsocksr-akkariiin-dev/shadowsocks/server.py -p 8339 -k Ssr123456 -m aes-256-cfb -O auth_aes128_sha1 -o tls1.2_ticket_auth_compatible -G 32 -g www.bing.com > ssr.log 2>&1 &
nohup /root/kcps64_170120 -t "0.0.0.0:8339" -l ":151" -key test -mtu 1350 -sndwnd 2048 -rcvwnd 2048 -crypt none -mode fast2 -dscp 46 -datashard 10 -parityshard 3 -keepalive 10 -nocomp> kcptun.log 2>&1 &
nohup /root/udp2raw_amd64 -s -l0.0.0.0:152 -r 127.0.0.1:151 -k "passwd" --raw-mode faketcp -a > udpkcp.log 2>&1 &
