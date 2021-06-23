#!/bin/bash
# server parameters can be read from /etc/wireguard/params
#
##ipv4 rules
# rules in the FORWARD chain
iptables -N WIREGUARD-FORWARD
iptables -I FORWARD 1 -j WIREGUARD-FORWARD
iptables -A WIREGUARD-FORWARD -i $SERVER_PUB_NIC -o $SERVER_WG_NIC -j ACCEPT
iptables -A WIREGUARD-FORWARD -i $SERVER_WG_NIC -j ACCEPT
iptables -A WIREGUARD-FORWARD -i $SERVER_WG_NIC -o $SERVER_WG_NIC -j ACCEPT
# rules in the POSTROUTING chain
iptables -t nat -A POSTROUTING -o $SERVER_PUB_NIC -j MASQUERADE
# rules in the input chain
iptables -N WIREGUARD-INPUT
iptables -I INPUT 1 -j WIREGUARD-INPUT
iptables -A WIREGUARD-INPUT -i $SERVER_WG_NIC -j ACCEPT
iptables -A WIREGUARD-INPUT -i $SERVER_PUB_NIC -p udp -m udp --dport $SERVER_PORT -j ACCEPT
##ipv6 rules
# rules in the FORWARD chain
ip6tables -N WIREGUARD-FORWARD
ip6tables -I FORWARD 1 -j WIREGUARD-FORWARD
ip6tables -A WIREGUARD-FORWARD -i $SERVER_WG_NIC -j ACCEPT
ip6tables -A WIREGUARD-FORWARD -i $SERVER_WG_NIC -o $SERVER_WG_NIC -j ACCEPT
# rules in the POSTROUTING chain
ip6tables -t nat -A POSTROUTING -o $SERVER_PUB_NIC -j MASQUERADE
# rules in the input chain
ip6tables -N WIREGUARD-INPUT
ip6tables -I INPUT 1 -j WIREGUARD-INPUT
ip6tables -A WIREGUARD-INPUT -i $SERVER_WG_NIC -j ACCEPT
ip6tables -A WIREGUARD-INPUT -i $SERVER_PUB_NIC -p udp -m udp --dport $SERVER_PORT -j ACCEPT
