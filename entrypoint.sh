#!/bin/sh
/usr/bin/glider -listen :8443 &
echo "AuthorizedKeysFile	.ssh/authorized_keys
GatewayPorts no
X11Forwarding no
Subsystem	sftp	/usr/lib/ssh/sftp-server
PermitOpen any
AllowAgentForwarding yes
AllowTcpForwarding yes" > /etc/ssh/sshd_config
mkdir -p /root/.ssh/
touch /root/.ssh/authorized_keys
chmod 700 /root/.ssh/authorized_keys

ssh-keygen -A
/usr/sbin/sshd -D -e &
echo "http/socks5 proxy server: $(hostname -i):8443"
exec "$@"
