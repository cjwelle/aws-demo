#!/bin/sh

/usr/local/bin/s3cmd sync /var/log/ s3://{{ s3_log_bucket }}/`curl --silent http://169.254.169.254/latest/meta-data/instance-id | sed -e "s/i-//"`/`date +"%Y/%m/%d/%T"`/var/log/
