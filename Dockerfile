FROM janrk/debian-tester:latest

RUN apt-get install -y --no-install-recommends ca-certificates curl gzip libc6 libgcc1 libgcrypt20 libgpg-error0 liblz4-1 liblzma5 libsasl2-2 libssl1.1 libsystemd0 procps tar wget zlib1g; \
    apt-get purge -y --auto-remove; \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/fluent-bit-1.4.5-0-linux-amd64-debian-10.tar.gz && \
    echo "88e8728354e60075d6dc60fa633dd66ac7779967461deab456deb254dd3a825c  /tmp/bitnami/pkg/cache/fluent-bit-1.4.5-0-linux-amd64-debian-10.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/fluent-bit-1.4.5-0-linux-amd64-debian-10.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/fluent-bit-1.4.5-0-linux-amd64-debian-10.tar.gz

EXPOSE 2020

WORKDIR /opt/bitnami/fluent-bit
ENTRYPOINT [ "fluent-bit" ]
CMD [ "-c", "/opt/bitnami/fluent-bit/conf/fluent-bit.conf" ]