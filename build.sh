#! /usr/bin/env bash
set -e
set -x

apt-get update -qq
apt-get install -y --no-install-recommends dumb-init stunnel4 squid

# generate certifacte used stunnel (can override from outside with mounts)
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 -subj '/CN=squid-proxy/O=NULL/C=AU'
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
