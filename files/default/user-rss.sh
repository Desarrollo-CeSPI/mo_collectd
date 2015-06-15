#!/bin/bash
set -e
USER=$1
[ -z "$USER" ] && ( echo "You must specify which username to get memory usage"; exit 1 )
HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
INTERVAL="${COLLECTD_INTERVAL:-60}"

while sleep "$INTERVAL" ; do
  VALUE=`ps -fU $USER -orss --noheaders 2> /dev/null | (tr '\n' +; echo 0)  | bc`
  echo "PUTVAL \"$HOSTNAME/exec-user-$USER/gauge-memory_rss\" interval=$INTERVAL N:$VALUE"
done
