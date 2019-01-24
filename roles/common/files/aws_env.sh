#!/bin/sh

#Sets Environmental information from AWS Instance information and set to global environmental variables.
export REGION=`/usr/bin/curl --silent http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//'`
export INSTANCE_ID=`/usr/bin/curl --silent http://169.254.169.254/latest/meta-data/instance-id`
export HOSTZONE=`/usr/bin/aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID"  "Name=key,Values=Domain" --output=text | sed -r 's/TAGS\t(.*)\t.*\t.*\t(.*)/\2/'`
export TAG_NAME=`aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID"  "Name=key,Values=Name" --output=text | sed -r 's/TAGS\t(.*)\t.*\t.*\t(.*)/\2/'`
HOSTNAME=$TAG_NAME.$HOSTZONE
/bin/hostname $HOSTNAME
/bin/echo $HOSTNAME > /etc/hostname
# /bin/sh -c -e "echo '127.0.0.1 $HOSTNAME' >> /etc/hosts";
/bin/sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts
