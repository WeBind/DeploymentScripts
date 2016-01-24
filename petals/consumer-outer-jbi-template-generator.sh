#!/bin/bash
NAME=$1
PROVIDER_NAME=provider-$NAME

cat << EOF
<?xml version="1.0" encoding="UTF-8"?>
<jbi:jbi version="1.0"
	xmlns="http://java.sun.com/xml/ns/jbi"
	xmlns:jbi="http://java.sun.com/xml/ns/jbi">

	<jbi:service-assembly>
		<jbi:identification>
			<jbi:name>sa-SOAP-$PROVIDER_NAME-consume</jbi:name>
			<jbi:description></jbi:description>
		</jbi:identification>

		<!-- New service-unit -->
		<jbi:service-unit>
			<jbi:identification>
				<jbi:name>su-SOAP-$PROVIDER_NAME-consume</jbi:name>
				<jbi:description></jbi:description>
			</jbi:identification>

			<jbi:target>
				<jbi:artifacts-zip>su-SOAP-$PROVIDER_NAME-consume.zip</jbi:artifacts-zip>
				<jbi:component-name>petals-bc-soap</jbi:component-name>
			</jbi:target>
		</jbi:service-unit>
	</jbi:service
EOF