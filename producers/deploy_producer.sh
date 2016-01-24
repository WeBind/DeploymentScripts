#!/bin/bash

CONSUMER_FOLDER_PATH="/home/magicmicky/IdeaProjects/TestProducer1/out/artifacts/TestProducer1_war_exploded";
GLASSFISH_DEPLOYER_PATH="/opt/glassfish4/bin/asadmin";
PROJECT_FOLDER="/home/magicmicky/IdeaProjects/TestProducer1/SoapJavaProducer/";
TEMPLATE_GENERATOR="/opt/Plasson/petals/producers/SoapProvider_template.sh";

JAVA_FOLDER="src/main/java/example/";
INSTALLED_FOLDER="target/SoapJavaProducer";

id=$1
exchange=$2
broadcast=$3
all=$4
echo "Using id $id, exc $exchange, broadcast $broadcast"
mkdir /tmp/webind
cd /tmp/webind
cp -R $PROJECT_FOLDER ./producer-src-$id
cd producer-src-$id/SoapJavaProducer
pushd $JAVA_FOLDER
	rm SoapProvider.java
	${TEMPLATE_GENERATOR} $id > SoapProvider.java
popd
mvn install
mv $INSTALLED_FOLDER /tmp/webind/producer-$id;

cd /tmp/webind/

echo $id > ./producer-$id/number.txt
echo $exchange >> ./producer-$id/number.txt
echo $broadcast >> ./producer-$id/number.txt
echo $all >> ./producer-$id/number.txt
${GLASSFISH_DEPLOYER_PATH} deploy ./producer-$id
cd
#rm -rf /tmp/webind
