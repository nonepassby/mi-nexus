#!/usr/bin/bash

if /usr/sbin/mdata-get pkgsrc 1>/dev/null 2>&1; then
    PKGSRC=$(/usr/sbin/mdata-get pkgsrc)
    if sed -i "s|^http.*|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf 1>/dev/null 2>&1; then
        sed -i "s|^PKG_PATH=.*|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf;
    else
        sed -i '' "s|^http.*|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf;
        sed -i '' "s|^PKG_PATH=.*|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf
    fi
else 
    if /usr/sbin/mdata-get pkgsrc_base 1>/dev/null 2>&1; then
        PKGSRC=$(/usr/sbin/mdata-get pkgsrc_base)
        PKGSRC=${PKGSRC%*/}
        if sed -i "s|^https://pkgsrc.joyent.com|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf 1>/dev/null 2>&1; then
            sed -i "s|^PKG_PATH=https://pkgsrc.joyent.com|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf;
        else
            sed -i '' "s|^https://pkgsrc.joyent.com|${PKGSRC}|" /opt/local/etc/pkgin/repositories.conf;
            sed -i '' "s|^PKG_PATH=https://pkgsrc.joyent.com|PKG_PATH=${PKGSRC}|" /opt/local/etc/pkg_install.conf
        fi
    fi
    
fi