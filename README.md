# docker-fortivpn-socks5 ![](https://https://github.com/Tosainu/docker-fortivpn-socks5/workflows/Build/badge.svg)

Connect to a Fortinet SSL-VPN via http/socks5 proxy.

## Usage

NOTE: I only tested this image on Linux-based systems. It might not be working on macOS.

1. Create an openfortivpn configuration file.

    ```
    $ cat /path/to/config
    host = vpn.example.com
    port = 443
    username = foo
    password = bar
    trusted-cert = c717f8f4a9c4169619618d690e83e9b086619fa3442fd5eac3453be9732a9b4a
    ```

2. Run the following command to start the container.

    ```
    $ docker container run \
        --cap-add=NET_ADMIN \
        --device=/dev/ppp \
        --rm \
        -v /path/to/config:/etc/openfortivpn/config:ro \
        ghcr.io/tosainu/fortivpn-socks5:master
    ```

3. Now you can use SSL-VPN via `http://<container-ip>:8443` or `socks5://<container-ip>:8443`.

    ```
    $ http_proxy=http://172.17.0.2:8443 curl http://example.com

    $ ssh -o ProxyCommand="nc -x 172.17.0.2:8443 %h %p" foo@example.com
    ```
# 补充
clone完成之后切换到仓库目录执行
`docker build -t xuanyimo/docker-fortivpn-socks5 .`
`mkdir -p /Users/xxx/fortivpn/`
`touch /Users/xxx/fortivpn/config`
参考上面的配置内容，trusted-cert不变
1. 编辑conifg更新安全码
2. 执行下面命令
3. config文件为path/to/config

```shell
docker container run -d  --cap-add=NET_ADMIN --device=/dev/ppp -p 18443:8443 -p 10022:22 --rm -v /Users/xxx/fortivpn/config:/etc/openfortivpn/config:ro xuanyimo/docker-fortivpn-socks5
```
4. 添加公钥到/root/.ssh/authorized_keys (为了mysql走ssh tunnel使用)

## License

[MIT](https://github.com/Tosainu/docker-fortivpn-socks5/blob/master/LICENSE)


