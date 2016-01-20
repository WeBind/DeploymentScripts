#!/bin/bash
ADDRESS="example"
INTERFACE_SOAP="SoapProvider"
SERVICE_SOAP="SoapProviderService"

cat << EOF
<?xml version="1.0" encoding="UTF-8"?>
<jbi:jbi xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:$ADDRESS="http://$ADDRESS/" xmlns:cdk5="http://petals.ow2.org/components/extensions/version-5" xmlns:jbi="http://java.sun.com/xml/ns/jbi" xmlns:soap="http://petals.ow2.org/components/soap/version-4" version="1.0">
  <jbi:services binding-component="true">
    <jbi:consumes interface-name="$ADDRESS:$INTERFACE_SOAP" service-name="$SERVICE_NAME">
      <cdk5:timeout>30000</cdk5:timeout>
      <cdk5:mep xsi:nil="true"/>
      <soap:service-name>$SERVICE_SOAP</soap:service-name>
      <soap:mode>SOAP</soap:mode>
      <soap:enable-http-transport>true</soap:enable-http-transport>
      <soap:enable-jms-transport>false</soap:enable-jms-transport>
    </jbi:consumes>
  </jbi:services>
</jbi:jbi>
EOF