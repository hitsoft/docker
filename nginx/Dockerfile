FROM hitsoft/base

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.4-1~jessie

RUN apt-get update \
    && apt-get install  --assume-yes --no-install-recommends \
        nginx=${NGINX_VERSION} \
        build-essential \
    && rm -rf /var/lib/apt/lists/*
    && cd /opt \
    && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx", "/var/log/nginx", "/etc/nginx", "/data"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]