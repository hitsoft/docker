FROM hitsoft/java

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y zookeeper && \
    apt-get clean

VOLUME /etc/zookeeper/

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 2888 3888 2181

CMD ["mongod"]