#!/bin/bash

/opt/ood/ood-portal-generator/sbin/update_ood_portal --rpm -f --insecure

sudo -u ondemand-dex /usr/sbin/ondemand-dex serve /etc/ood/dex/config.yaml 2>&1 &

/usr/libexec/httpd-ssl-gencerts
/usr/sbin/httpd -DFOREGROUND