# Tag: vungle/geoipupdate
FROM vungle/awscli
MAINTAINER Steve Jiang <steve.jiang@vungle.com>

COPY files/geoipupdate /usr/local/bin/geoipupdate

ENTRYPOINT ["geoipupdate"]
