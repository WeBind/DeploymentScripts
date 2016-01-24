#!/bin/bash
PRODUCER_INNER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/producer-inner-jbi-template-generator.sh"
PRODUCER_OUTER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/producer-outer-jbi-template-generator.sh"
CONSUMER_INNER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/consumer-inner-jbi-template-generator.sh"
CONSUMER_OUTER_JBI_TEMPLATE_GENERATOR="/opt/Plasson/petals/consumer-outer-jbi-template-generator.sh"
HOST="127.0.0.1"
REMOTE_HOST="192.168.0.105"
REMOTE_HOST_FOLDER="/root/petals-esb-enterprise-edition-5.0.0-SNAPSHOT/esb/petals-esb-default-zip-5.0.1-SNAPSHOT/data/install/"
NAME=$1
PROD_NAME=producer-$NAME
PROV_NAME=provider-$NAME
mkdir /tmp/webind-petals
mkdir /tmp/webind-petals/$PROD_NAME
cd /tmp/webind-petals/$PROD_NAME

#produce
ROOT=su-SOAP-SoapProviderService-provide
mkdir $ROOT
mkdir $ROOT/META-INF

#Creation du inner zip
${PRODUCER_INNER_JBI_TEMPLATE_GENERATOR} $NAME $HOST > $ROOT/META-INF/jbi.xml
wget -O $ROOT/SoapProviderService.wsdl http://$HOST:8080/$PROD_NAME/$PROV_NAME?wsdl
wget -O $ROOT/1.xsd http://$HOST:8080/$PROD_NAME/$PROV_NAME??xsd=1

#outer zip
ROOT2=sa-SOAP-SoapProviderService-provide
mkdir $ROOT2/
mkdir $ROOT2/META-INF
${PRODUCER_OUTER_JBI_TEMPLATE_GENERATOR} $NAME > $ROOT2/META-INF/jbi.xml

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
scp $ROOT2/$ROOT2.zip root@$REMOTE_HOST:$REMOTE_HOST_FOLDER

#consume
ROOT=su-SOAP-SoapProviderService-consume
mkdir $ROOT
mkdir $ROOT/META-INF
${CONSUMER_INNER_JBI_TEMPLATE_GENERATOR} $NAME > $ROOT/META-INF/jbi.xml

#outer zip
ROOT2=sa-SOAP-SoapProviderService-consume
mkdir $ROOT2
mkdir $ROOT2/META-INF
${CONSUMER_OUTER_JBI_TEMPLATE_GENERATOR} $NAME > $ROOT2/META-INF/jbi.xml

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
scp $ROOT2/$ROOT2.zip root@$REMOTE_HOST:$REMOTE_HOST_FOLDER
