#!/bin/sh

AutoUpgrade(){
  if [ -e /etc/alpine-release ]; then
    /sbin/apk --no-cache upgrade
    /bin/rm -rf /var/cache/apk/*
  elif [ -e /etc/os-release ]; then
    if /bin/grep -q "NAME=\"Ubuntu\"" /etc/os-release ; then 
      export DEBIAN_FRONTEND=noninteractive
      /usr/bin/apt update
      /usr/bin/apt -y --no-install-recommends upgrade
      /bin/rm -rf /var/lib/apt/lists/*
    fi
  fi
}

AutoUpgrade

if [ "$1" = 'certbot' ]; then
   if [ -z "${DOCKMAIL}" ]; then
      /usr/bin/logger "ERROR: administrator email is mandatory"
   elif [ -z "${DOCKDOMAINS}" ]; then
      /usr/bin/logger "ERROR: at least one domain must be specified"
   else
      exec /usr/bin/certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${DOCKMAIL}" -d "${DOCKDOMAINS}" 
   fi
elif [ "$1" = 'certbot-renew' ]; then
   exec /usr/bin/certbot renew
fi

"$@"
