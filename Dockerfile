# Tag: vungle/geoipupdate
# PE-9740: the previous base (vungle/awscli) is built on alpine:3.8 with Python 2.7 and
# cannot receive a fixed ca-certificates package (EOL; no fixed Alpine 3.8 build exists), so
# build on a supported Alpine release with the distro aws-cli instead. 20261020-r0 is the
# first ca-certificates release that drops the compromised eMudhra roots.
FROM alpine:3.24
LABEL maintainer="Platform Supply <platform-ssp@liftoff.io>"

RUN apk add --no-cache aws-cli "ca-certificates>=20261020-r0" \
    # aws-cli vendors its own botocore CA bundle that still has the affected roots; point it at the OS bundle
    && find /usr/lib -path '*/botocore/cacert.pem' -exec ln -sf /etc/ssl/certs/ca-certificates.crt {} +

COPY files/geoipupdate /usr/local/bin/geoipupdate

ENTRYPOINT ["geoipupdate"]
