#!/bin/bash
BASE="producer-"

GLASSFISH_INSTALL="/usr/local/glassfish4"
GLASSFISH_ASADMIN="$GLASSFISH_INSTALL/bin/asadmin"
DOMAIN_PATH="$GLASSFISH_INSTALL/glassfish/domains/domain1/applications/*"

REMOTE_HOST="192.168.0.105"
REMOTE_HOST_FOLDER="/root/petals-esb-enterprise-edition-5.0.0-SNAPSHOT/esb/petals-esb-default-zip-5.0.1-SNAPSHOT/data/installed"

for cur in "$@"
do
  ${GLASSFISH_ASADMIN} undeploy --user admin --passwordfile ~/.passowrd_file $BASE$cur
  ssh root@$REMOTE_HOST 'rm -rf $REMOTE_HOST_FOLDER/sa-SOAP-$BASE$cur-*'
done
rm -rf $DOMAIN_PATH
rm -rf /tmp/webind/*
rm -rf /tmp/webind-petals/


${GLASSFISH_ASADMIN} restart-domain

