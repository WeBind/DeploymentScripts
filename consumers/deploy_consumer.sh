#!/bin/bash

CONSUMER_JAR=/opt/SoapJavaConsumer/target/SoapJavaConsumer.jar

id=$1
exchange=$2
broadcast=$3
all=$4

java -jar ${CONSUMER_JAR} $id $exchange $broadcast $all
