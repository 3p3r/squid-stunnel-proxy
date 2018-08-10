FROM ubuntu

ADD build.sh daemon.sh stunnel-server.conf stunnel-client.conf /
RUN bash build.sh && rm build.sh

# healthcheck makes sure the proxy server is actually running correctly and tunneling TLS
HEALTHCHECK --interval=5m --timeout=5s \
  CMD curl -x http://127.0.0.1:8080/ -f https://www.google.com/ || exit 1

EXPOSE 8080
ENTRYPOINT ["/daemon.sh"]
