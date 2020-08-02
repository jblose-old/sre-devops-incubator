FROM graylog/graylog:2.4

USER root
RUN mkdir /usr/share/graylog/plugin
COPY plugins/metrics-reporter-prometheus-2.4.0-beta.4-SNAPSHOT.jar /usr/share/graylog-server/plugin/.
run chown graylog:graylog 
