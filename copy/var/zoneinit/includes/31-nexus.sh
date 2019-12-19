
log "set mem size"
if mdata-get mem_xms 1>/dev/null 2>&1; then
    MEMXMS=`mdata-get mem_xms`
    gsed -i "s|2703m|${MEMXMS}|g" /opt/nexus/bin/nexus.vmoptions
fi


log "creating /data directory"

if [[ ! -e /data/nexus3 ]]; then
  if [[ ! -e /data ]]; then
    mkdir /data
  fi
  if [[ -e /opt/sonatype-work ]]; then
    mv /opt/sonatype-work/nexus3 /data
  else
    mkdir /data/nexus3
  fi
fi
if [[ -e /opt/sonatype-work ]]; then
  rm -r /opt/sonatype-work
fi

log "force correct ownership of /data directory"
chown -R nexus:nexus /data

log "starting nexus"
/usr/sbin/svcadm enable nexus
