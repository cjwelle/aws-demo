#! /bin/sh
### BEGIN INIT INFO
# Provides:          s3_sync
# Required-Start:
# Required-Stop:     sendsigs
# Default-Start:
# Default-Stop:      0 6
# Short-Description: Sync /var/log to an S3 bucket on shutdown.
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/lsb/init-functions

do_stop () {
    /usr/local/bin/s3_sync.sh >> /var/log/s3_sync.log 2>&1
}

case "$1" in
  start)
    # No-op
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    do_stop
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    exit 3
    ;;
esac

:
