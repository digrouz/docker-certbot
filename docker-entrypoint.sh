#!/bin/sh

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
