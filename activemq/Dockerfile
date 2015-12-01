FROM hitsoft/java

ENV ACTIVEMQ_VERSION 5.12.1
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION

ENV ACTIVEMQ_HOME /opt/activemq

RUN set -x \
    && curl http://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz -o activemq.tar.gz \
    && mkdir -p /opt \
    && tar xf activemq.tar.gz -C /opt/ \
    && rm activemq.tar.gz \
    && ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME

RUN set -x \
    && cd $ACTIVEMQ_HOME \
    && mv conf conf.orig \
    && mv data data.orig

WORKDIR $ACTIVEMQ_HOME

EXPOSE 61616 61613 8161

VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh

COPY activemq.sh /activemq.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/activemq.sh"]