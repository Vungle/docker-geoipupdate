# Tag: vungle/geoipupdate
FROM garukun/geoipupdate
MAINTAINER Steve Jiang <steve.jiang@vungle.com>

ENTRYPOINT ["/bin/bash", "-c", "while true; do update.sh /etc/conf/maxmind.conf; echo 'Sleeping for a day...'; sleep 86400; done"]
