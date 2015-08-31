FROM hitsoft/base

ENV NGINX_VERSION 1.9.4
ENV NGINX_DEB_VERSION 1.9.4-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install  --assume-yes --no-install-recommends \
        nginx=${NGINX_DEB_VERSION} \
        build-essential \
        libpcre++-dev \
        libssl-dev \
        libgeoip-dev \
        libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*
RUN cd /opt \
    && git clone https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng.git \
    && git clone https://github.com/GUI/nginx-upstream-dyanmic-servers.git \
    && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz.asc \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys A1C052F8 \
    && gpg --verify nginx-${NGINX_VERSION}.tar.gz.asc \
    && tar xzvf nginx-${NGINX_VERSION}.tar.gz \
    && cd nginx-${NGINX_VERSION} \
    && ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module \
        --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module \
        --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module \
        --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-threads \
        --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-file-aio \
        --with-http_spdy_module --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security \
        -Wp,-D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' --with-ipv6 \
        --add-module=/opt/nginx-sticky-module-ng \
        --add-module=/opt/nginx-upstream-dyanmic-servers \
    && make \
    && make install

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx", "/var/log/nginx", "/etc/nginx", "/data"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]