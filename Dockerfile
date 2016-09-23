# Build a minimal distribution container

FROM ppc64le/ubuntu 
ENV GOPATH /go
ENV PATH $PATH:/go/bin

RUN apt-get update && apt-get install -yqq golang git
RUN go get github.com/docker/distribution/cmd/registry
RUN cd /go/src/github.com/docker/distribution && \
    git checkout v2.4.1

COPY ./registry/config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
