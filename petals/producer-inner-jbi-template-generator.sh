#!/bin/bash
NAME=$1
PRODUCER_NAME=producer-$1
PROVIDER_SOAP=provider-$1

HOST=$2
ADDRESS="example"
SERVICE_SOAP=$NAME
INTERFACE_SOAP=$PROVIDER_SOAP
PORT_SOAP=$INTERFACE_SOAP"Port"

cat << EOF
<?xml version="1.0" encoding="UTF-8"?>
<jbi:jbi xmlns:$ADDRESS="http://$ADDRESS/" xmlns:cdk5="http://petals.ow2.org/components/extensions/version-5" xmlns:jbi="http://java.sun.com/xml/ns/jbi" xmlns:soap="http://petals.ow2.org/components/soap/version-4" version="1.0">
  <jbi:services binding-component="true">
    <jbi:provides endpoint-name="$PORT_SOAP" interface-name="$ADDRESS:$INTERFACE_SOAP" service-name="$ADDRESS:$PROVIDER_SOAP">
      <cdk5:timeout>30000</cdk5:timeout>
      <cdk5:validate-wsdl>true</cdk5:validate-wsdl>
      <cdk5:forward-security-subject>false</cdk5:forward-security-subject>
      <cdk5:forward-message-properties>false</cdk5:forward-message-properties>
      <cdk5:forward-attachments>false</cdk5:forward-attachments>
      <cdk5:wsdl>$PROVIDER_SOAP.wsdl</cdk5:wsdl>
      <soap:address>http://$HOST:8080/$PRODUCER_NAME/$PROVIDER_SOAP</soap:address>
      <soap:soap-version>1.1</soap:soap-version>
      <soap:chunked-mode>false</soap:chunked-mode>
      <soap:cleanup-transport>true</soap:cleanup-transport>
      <soap:mode>SOAP</soap:mode>
    </jbi:provides>
  </jbi:services>
</jbi:jbi>
EOF