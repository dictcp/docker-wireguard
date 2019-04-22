FROM debian:stretch

# base on: https://github.com/masipcat/wireguard-go-docker
# need --cap-add=NET_ADMIN and --device=/dev/net/tun

# debian install
# https://www.wireguard.com/install/
# extra golang-1.12
RUN echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable.list && \
    echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list && \
    printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' > /etc/apt/preferences.d/limit-unstable && \
    apt update && \
    apt -y install vim git wget curl golang-1.12 make busybox qrencode iptables && \
    apt -y --no-install-recommends install wireguard-tools && \
    ln -s /usr/lib/go-1.12/bin/go /usr/bin/go

# wireguard-go
# https://git.zx2c4.com/wireguard-go/about/
RUN cd /root && \
    git clone https://git.zx2c4.com/wireguard-go && \
    cd wireguard-go && \
    make && \
    cp wireguard-go /usr/bin/

# tools: https://github.com/faicker/wg_config
RUN cd /root && \
    git clone https://github.com/adrianmihalko/wg_config

CMD wireguard-go -f wg0
