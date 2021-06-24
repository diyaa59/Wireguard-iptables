#!/bin/bash
# server parameters can be read from /etc/wireguard/params
#
##ipv4 rules
# rules in the FORWARD chain
iptables -D WIREGUARD-FORWARD -i ${SERVER_PUB_NIC} -o ${SERVER_WG_NIC} -j ACCEPT
iptables -D WIREGUARD-FORWARD -i ${SERVER_WG_NIC} -j ACCEPT
iptables -D WIREGUARD-FORWARD -i ${SERVER_WG_NIC} -o ${SERVER_WG_NIC} -j ACCEPT
iptables -D FORWARD 1 WIREGUARD-FORWARD
iptables -X WIREGUARD-FORWARD
# rules in the POSTROUTING chain
iptables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
# rules in the input chain
iptables -D WIREGUARD-INPUT -i ${SERVER_WG_NIC} -j ACCEPT
iptables -D WIREGUARD-INPUT -i ${SERVER_PUB_NIC} -p udp -m udp --dport ${SERVER_PORT} -j ACCEPT
iptables -D INPUT 1 WIREGUARD-INPUT
iptables -X WIREGUARD-INPUT
##ipv6 rules
# rules in the FORWARD chain
ip6tables -D WIREGUARD-FORWARD -i ${SERVER_WG_NIC} -j ACCEPT
ip6tables -D WIREGUARD-FORWARD -i ${SERVER_WG_NIC} -o ${SERVER_WG_NIC} -j ACCEPT
ip6tables -D FORWARD 1 WIREGUARD-FORWARD
ip6tables -X WIREGUARD-FORWARD
# rules in the POSTROUTING chain
ip6tables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
# rules in the input chain
ip6tables -D WIREGUARD-INPUT -i ${SERVER_WG_NIC} -j ACCEPT
ip6tables -D WIREGUARD-INPUT -i ${SERVER_PUB_NIC} -p udp -m udp --dport ${SERVER_PORT} -j ACCEPT
ip6tables -D INPUT 1 WIREGUARD-INPUT
ip6tables -X WIREGUARD-INPUT