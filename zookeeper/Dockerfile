FROM hitsoft/java

ENV LEIN_ROOT=yes

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install --assume-yes --no-install-recommends \
        zookeeper \
    && rm -rf /var/lib/apt/lists/*
RUN cd /opt \
    && wget http://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz \
    && tar xzvf apache-maven-3.3.3-bin.tar.gz \
    && git clone https://github.com/DeemOpen/zkui.git zkui.src \
    && cd zkui.src \
    && /opt/apache-maven-3.3.3/bin/mvn clean install \
    && cd .. \
    && mkdir zkui \
    && mv zkui.src/target/zkui-2.0-SNAPSHOT-jar-with-dependencies.jar zkui \
    && rm -rf apache-maven-3.3.3 \
    && rm apache-maven-3.3.3-bin.tar.gz \
    && rm -rf zkui.src \
    && rm -rf /root/.m2 \
    && mkdir -p /etc/zkui \
    && ln -s /etc/zkui/config.cfg /opt/zkui/config.cfg
COPY config.cfg /etc/zkui/config.cfg

VOLUME [ "/data" ]

COPY docker-entrypoint.sh /entrypoint.sh
COPY zoo.cfg /etc/zookeeper/conf/zoo.cfg

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 2888 3888 2181 9090

CMD ["zkServer"]