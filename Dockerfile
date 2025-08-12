# Tag: vungle/geoipupdate
FROM vungle/awscli
LABEL maintainer="Platform Supply <platform-ssp@liftoff.io>"

COPY files/geoipupdate /usr/local/bin/geoipupdate

ENTRYPOINT ["geoipupdate"]
