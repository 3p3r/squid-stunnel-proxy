FROM ubuntu

ADD build.sh daemon.sh stunnel.conf /
RUN bash build.sh && rm build.sh

ENTRYPOINT ["/daemon.sh"]
