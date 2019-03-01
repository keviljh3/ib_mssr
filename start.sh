killall python                                                                                                  
killall java
nohup python /opt/ssr/shadowsocksr-akkariiin-dev/shadowsocks/server.py -p 17520 -k Ssr123456 -m chacha20-ietf -O auth_chain_a -o tls1.2_ticket_auth_compatible -G 32 -g www.yahoo.com > ssr.log 2>&1 &
