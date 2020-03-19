
log "set mem size"
if mdata-get mem_xms 1>/dev/null 2>&1; then
    MEMXMS=`mdata-get mem_xms`
    gsed -i "s|2703m|${MEMXMS}|g" /opt/nexus/bin/nexus.vmoptions
fi


log "creating /data directory"

if [[ ! -e /nexus-data ]]; then
  if [[ -e /opt/sonatype-work ]]; then
    mv /opt/sonatype-work/nexus3 /nexus-data
  else
    mkdir /nexus-data
  fi
fi
#if [[ -e /opt/sonatype-work ]]; then
#  rm -r /opt/sonatype-work
#fi

log "force correct ownership of /nexus-data directory"
chown -R nexus:nexus /nexus-data

log "starting nexus"
/usr/sbin/svcadm enable nexus
