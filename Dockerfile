FROM alpine:3.9.3

COPY prometheus          /bin/prometheus
COPY promtool            /bin/promtool
COPY console_libraries/  /usr/share/prometheus/console_libraries/
COPY consoles/           /usr/share/prometheus/consoles/
COPY conf/               /etc/prometheus/

RUN ln -s /usr/share/prometheus/console_libraries/ /usr/share/prometheus/consoles/ /etc/prometheus/
RUN mkdir -p /prometheus && \
    chown -R 1000.1000 etc/prometheus /prometheus

USER       1000
EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/etc/prometheus/docker-entrypoint.sh" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]
