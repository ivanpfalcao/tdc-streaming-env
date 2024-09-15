#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

TOPIC_NAME="nifi-output-topic"
BOOTSTRAP_SERVER="kafka-cluster-kafka-bootstrap:9092"

NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi
echo "${NAMESPACE}"

kubectl -n "${NAMESPACE}" delete $(kubectl get strimzi -o name -n "${NAMESPACE}")
kubectl -n "${NAMESPACE}" delete pvc -l strimzi.io/name=kafka-cluster-kafka 