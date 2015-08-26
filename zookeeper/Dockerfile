FROM hitsoft/java

ENV LEIN_ROOT=yes

RUN apt-get update && apt-get -y upgrade && \
    apt-get install  --assume-yes --no-install-recommends \
        zookeeper wget curl git && \
    apt-get clean
RUN cd /opt && \
    wget http://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
    tar xzvf apache-maven-3.3.3-bin.tar.gz && \
    git clone https://github.com/DeemOpen/zkui.git zkui.src && \
    cd zkui.src && \
    /opt/apache-maven-3.3.3/bin/mvn clean install && \
    cd .. && \
    mkdir zkui && \
    mv zkui.src/target/zkui-2.0-SNAPSHOT-jar-with-dependencies.jar zkui && \
    rm -rf apache-maven-3.3.3 && \
    rm apache-maven-3.3.3-bin.tar.gz && \
    rm -rf zkui.src && \
    rm -rf /root/.m2
COPY config.cfg /opt/zkui/config.cfg

#RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/bin/lein && \
#   chmod 755 /usr/bin/lein && \
#    cd /opt && \
#    git clone https://github.com/qiuxiafei/zk-web.git && \
#    cd zk-web && \
#    lein deps

VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
COPY zoo.cfg /etc/zookeeper/conf/zoo.cfg

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 2888 3888 2181 9090

CMD ["zkServer"]