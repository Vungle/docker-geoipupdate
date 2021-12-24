# Tag: vungle/geoipupdate
FROM vungle/awscli:1.17

COPY files/geoipupdate /usr/local/bin/geoipupdate

ENTRYPOINT ["geoipupdate"]
