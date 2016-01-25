#!/bin/bash

NAME=$1
PRODUCER_NAME=producer-$1
PROVIDER_SOAP=provider-$1

HOST=$2
ADDRESS="example"
SERVICE_SOAP=$NAME
INTERFACE_SOAP="SoapProvider"$1
PORT_SOAP=$INTERFACE_SOAP"Port"

cat << EOF
<?xml version="1.0" encoding="UTF-8"?>
<jbi:jbi version="1.0"
	xmlns="http://java.sun.com/xml/ns/jbi"
	xmlns:jbi="http://java.sun.com/xml/ns/jbi">

	<jbi:service-assembly>
		<jbi:identification>
			<jbi:name>sa-SOAP-$PROVIDER_SOAP-provide</jbi:name>
			<jbi:description></jbi:description>
		</jbi:identification>

		<!-- New service-unit -->
		<jbi:service-unit>
			<jbi:identification>
				<jbi:name>su-SOAP-$PROVIDER_SOAP-provide</jbi:name>
				<jbi:description></jbi:description>
			</jbi:identification>

			<jbi:target>
				<jbi:artifacts-zip>su-SOAP-$PROVIDER_SOAP-provide.zip</jbi:artifacts-zip>
				<jbi:component-name>petals-bc-soap</jbi:component-name>
			</jbi:target>
		</jbi:service-unit>
	</jbi:service-assembly>
</jbi:jbi>
EOF