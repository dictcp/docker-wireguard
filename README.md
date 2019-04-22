docker-wireguard
====
A docker image based on wireguard go (userspace implementation), to avoid depending on kernel module. with the user management script `wg_config`. It should be useful for building a VPN gateway for multiple users.


Usage
----
```
docker-compose up -d
docker-compose exec wireguard /bin/bash -c 'cd /root; umask 077; wg genkey > privatekey; wg set wg0 listen-port 51820 private-key privatekey'
docker-compose exec wireguard /bin/bash -c 'ip address add dev wg0 192.168.88.1/24; ip link set up dev wg0; iptables -t nat -A POSTROUTING -s 192.168.88.1/24 -o eth0 -j MASQUERADE'
docker-compose exec wireguard /bin/bash # update /root/wg_config/wg.def from sample, then execute /root/wg_config/user.sh -a userABC
docker-compose exec wireguard wg showconf wg0
```
