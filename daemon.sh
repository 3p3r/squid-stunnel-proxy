#!/usr/bin/dumb-init /bin/sh

service squid restart &
stunnel /stunnel-client.conf &
stunnel /stunnel-server.conf
