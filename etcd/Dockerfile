FROM hitsoft/base

# prepare debian packages
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install --assume-yes --no-install-recommends \
        nodejs \
        npm \
        golang \
		make \
    && rm -rf /var/lib/apt/lists/* \
    && cd /usr/bin \
    && ln -s nodejs node \
    && mkdir -p /opt

ENV ETCD_VER 2.1.2

# install etcd
RUN cd /opt \
    && curl -L  https://github.com/coreos/etcd/releases/download/v${ETCD_VER}/etcd-v${ETCD_VER}-linux-amd64.tar.gz.gpg -o etcd.tar.gz.gpg \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys CC22F12F \
    && gpg --decrypt --output etcd.tar.gz etcd.tar.gz.gpg \
    && tar xzvf etcd.tar.gz \
    && rm etcd.tar.gz \
    && rm etcd.tar.gz.gpg \
    && mv etcd-v${ETCD_VER}-linux-amd64 etcd \
    && ln -s /opt/etcd/etcd /usr/bin/ \
    && ln -s /opt/etcd/etcdctl /usr/bin/

# install etcd-browser
RUN cd /opt \
    && git clone https://github.com/henszey/etcd-browser.git \
    && cd etcd-browser \
    && rm -rf .git \
    && rm .gitignore \
    && rm Dockerfile \
    && rm etcd-browser.service

# install etcd-dump
RUN npm install -g etcd-dump \
    && npm install -g jsonlint

# install etcd-fs
RUN cd /opt \
    && git clone https://github.com/xetorthio/etcd-fs.git etcd-fs.src \
    && cd etcd-fs.src \
    && export GOPATH=$(pwd) \
    && go get github.com/franela/goblin \
    && go get github.com/coreos/go-etcd/etcd \
    && go get github.com/hanwen/go-fuse/fuse \
    && make build \
    && mkdir -p /opt/etcd-fs \
    && mv etcdfs /opt/etcd-fs \
    && ln -s /opt/etcd-fs/etcdfs /usr/bin/ \
    && rm -rf /opt/etcd-fs.src

COPY docker-entrypoint.sh /entrypoint.sh

COPY etcd-pdump.sh /usr/bin/etcd-pdump

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 4001 8000

CMD ["etcd", "--cors", "*", "--listen-client-urls", "http://0.0.0.0:4001", "--advertise-client-urls", "http://0.0.0.0:4001"]