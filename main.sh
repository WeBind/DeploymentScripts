#!/bin/bash
PRODUCER_INNER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/producer-inner-jbi-template-generator.sh"
PRODUCER_OUTER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/producer-outer-jbi-template-generator.sh"
CONSUMER_INNER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/consumer-inner-jbi-template-generator.sh"
CONSUMER_OUTER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/consumer-outer-jbi-template-generator.sh"
HOST="127.0.0.1"

PROD_NAME=producer-$1
mkdir /tmp/webind-petals
mkdir /tmp/webind-petals/$PROD_NAME
cd /tmp/webind-petals/$PROD_NAME

#produce
ROOT=su-SOAP-SoapProviderService-provide
mkdir $ROOT
mkdir $ROOT/META-INF

#Creation du inner zip
${PRODUCER_INNER_JBI_TEMPLATE_GENERATOR} $PROD_NAME $HOST > $ROOT/META-INF/jbi.xml
wget -O $ROOT/SoapProviderService.wsdl http://$HOST:8080/$PROD_NAME/SoapProviderService?wsdl
wget -O $ROOT/1.xsd http://$HOST:8080/$PROD_NAME/SoapProviderService??xsd=1

#outer zip
ROOT2=sa-SOAP-SoapProviderService-provide
mkdir $ROOT2/
mkdir $ROOT2/META-INF
${PRODUCER_OUTER_JBI_TEMPLATE_GENERATOR} > $ROOT2/META-INF/jbi.xml

#zip $ROOT into $ROOT2/$ROOT.zip
pushd $ROOT
zip -r $ROOT.zip .
popd
mv $ROOT/$ROOT.zip $ROOT2
#zip $ROOT2 into /$ROOT2.zip
pushd $ROOT2
zip -r $ROOT2.zip .
popd
mv $ROOT2/$ROOT2.zip .


#consume
ROOT=su-SOAP-SoapProviderService-consume
mkdir $ROOT
mkdir $ROOT/META-INF
${CONSUMER_INNER_JBI_TEMPLATE_GENERATOR} > $ROOT/META-INF/jbi.xml

#outer zip
ROOT2=sa-SOAP-SoapProviderService-consume
mkdir $ROOT2
mkdir $ROOT2/META-INF
${CONSUMER_OUTER_JBI_TEMPLATE_GENERATOR} > $ROOT2/META-INF/jbi.xml

#zip $ROOT into $ROOT2/$ROOT.zip
pushd $ROOT
zip -r $ROOT.zip .
popd
mv $ROOT/$ROOT.zip $ROOT2
#zip $ROOT2 into /$ROOT2.zip
pushd $ROOT2
zip -r $ROOT2.zip .
popd
mv $ROOT2/$ROOT2.zip .