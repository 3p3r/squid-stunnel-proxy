#!/usr/bin/dumb-init /bin/sh

service squid restart &
stunnel /stunnel.conf
