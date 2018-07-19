#!/bin/sh

echo "ipset -n list bogon4 1>/dev/null 2>/dev/null || ipset create bogon4 hash:net family inet"
echo "ipset -n list bogon6 1>/dev/null 2>/dev/null || ipset create bogon6 hash:net family inet6"

echo "ipset -n list bogon4tmp 1>/dev/null 2>/dev/null && ipset destroy bogon4tmp"
echo "ipset -n list bogon6tmp 1>/dev/null 2>/dev/null && ipset destroy bogon6tmp"

echo "ipset restore <<EOF"

	echo "create bogon4tmp hash:net family inet hashsize 1024 maxelem 65536"
	echo "create bogon6tmp hash:net family inet6 hashsize 1024 maxelem 131072"

	wget -qO- https://www.team-cymru.org/Services/Bogons/fullbogons-ipv4.txt | tr -d '\r' | grep -vE '^(#|;|$)' | cut -d' ' -f1 | sed 's/^/add bogon4tmp /'
	wget -qO- https://www.team-cymru.org/Services/Bogons/fullbogons-ipv6.txt | tr -d '\r' | grep -vE '^(#|;|$)' | cut -d' ' -f1 | sed 's/^/add bogon6tmp /'

echo "EOF"

echo "ipset swap bogon4 bogon4tmp"
echo "ipset swap bogon6 bogon6tmp"

echo "ipset destroy bogon4tmp"
echo "ipset destroy bogon6tmp"
