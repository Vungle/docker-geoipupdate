# Tag: vungle/geoipupdate
FROM vungle/awscli
LABEL maintainer="Steve Jiang <steve.jiang@vungle.com>"

COPY files/geoipupdate /usr/local/bin/geoipupdate

ENTRYPOINT ["geoipupdate"]
