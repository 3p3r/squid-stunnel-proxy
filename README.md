# squid-stunnel-proxy

SSL Tunnel Using STunnel, Squid Proxy Server, and Docker.

## quick start

Server side:

```bash
$ docker run -it sepehrl/squid-stunnel-proxy
$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -lq)
172.17.0.2
```

Server side (running across restarts):

```bash
$ docker run --name stunnel-server --detach=true --restart=on-failure:10 --net=host sepehrl/squid-stunnel-proxy
```

Client side (sample configuration):

```bash
$ cat /etc/stunnel/stunnel.conf
cert = /etc/stunnel/stunnel.pem
foreground = yes
client = yes
[squid]
accept = 127.0.0.1:8080
connect = 172.17.0.2:8888
```

Client side (sample invocation):

```bash
$ docker cp $(docker ps -lq):/etc/stunnel/stunnel.pem /etc/stunnel/stunnel.pem
$ sudo stunnel
...
2018.08.09 17:05:08 LOG5[ui]: Configuration successful
```

## overriding `stunnel.pem`

you can mount an external certificate file using Docker volume mount into
`/etc/stunnel/stunnel.pem`. By default this image uses a pre-generated pem file
inside the container image.

## automated healthchecks

A second instance of stunnel is running inside the container to perform a health
check request once in a while (every five minutes). Port of the healthcheck proc
is exposed so you can reach it from outside world as well. In other words, you
can start using the proxy server as-is without having stunnel installed client
side to just test drive things.
