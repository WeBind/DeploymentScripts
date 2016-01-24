#!/bin/bash
BASE="producer-"

GLASSFISH_INSTALL="/usr/local/glassfish4"
GLASSFISH_ASADMIN="$GLASSFISH_INSTALL/bin/asadmin"
DOMAIN_PATH="$GLASSFISH_INSTALL/glassfish/domains/domain1/applications/*"
for cur in "$@"
do
  ${GLASSFISH_ASADMIN} undeploy --user admin --passwordfile ~/.passowrd_file $BASE$cur
done
rm -rf $DOMAIN_PATH

${GLASSFISH_ASADMIN} restart-domain

