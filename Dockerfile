# Tag: vungle/geoipupdate
FROM garukun/geoipupdate:v0.1.0
MAINTAINER Steve Jiang <steve.jiang@vungle.com>

COPY files/checkup /usr/local/bin/checkup
COPY files/livecheck /usr/local/bin/livecheck

ENTRYPOINT ["checkup", "/etc/conf/maxmind.conf"]
