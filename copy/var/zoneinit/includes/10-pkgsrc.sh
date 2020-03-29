#!/usr/bin/bash

if /usr/sbin/mdata-get pkgsrc 1>/dev/null 2>&1; then
    PKGSRC=$(/usr/sbin/mdata-get pkgsrc)
    if gsed -i "s|^http.*|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf 1>/dev/null 2>&1; then
        gsed -i "s|^PKG_PATH=.*|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf;
    else
        gsed -i "s|^http.*|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf;
        gsed -i "s|^PKG_PATH=.*|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf
    fi
else 
    if /usr/sbin/mdata-get pkgsrc_base 1>/dev/null 2>&1; then
        PKGSRC=$(/usr/sbin/mdata-get pkgsrc_base)
        PKGSRC=${PKGSRC%*/}
        if gsed -i "s|^https://pkgsrc.joyent.com|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf 1>/dev/null 2>&1; then
            gsed -i "s|^PKG_PATH=https://pkgsrc.joyent.com|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf;
        else
            gsed -i "s|^https://pkgsrc.joyent.com|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf;
            gsed -i "s|^PKG_PATH=https://pkgsrc.joyent.com|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf
        fi
    fi
    
fi