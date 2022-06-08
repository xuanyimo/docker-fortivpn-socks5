#!/bin/sh
/usr/bin/glider -listen :8443 &
ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@" &
echo "http/socks5 proxy server: $(hostname -i):8443"
exec "$@"
