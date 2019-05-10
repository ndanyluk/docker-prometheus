#!/bin/sh -e

#chown -R $PUID:$PGID /etc/prometheus /prometheus

set -- /bin/prometheus "$@"

exec "$@"

