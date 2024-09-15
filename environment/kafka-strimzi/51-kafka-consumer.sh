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

kubectl -n "${NAMESPACE}" apply -f "${BASEDIR}/kafka-node-pool.yaml"

kubectl -n "${NAMESPACE}" delete pod kafka-consumer

kubectl -n "${NAMESPACE}" run kafka-consumer \
    -ti --image=quay.io/strimzi/kafka:0.42.0-kafka-3.7.1 --rm=true --restart=Never \
    -- bin/kafka-console-consumer.sh \
    --bootstrap-server "${BOOTSTRAP_SERVER}" \
    --topic "${TOPIC_NAME}"

kubectl -n "${NAMESPACE}" delete pod kafka-consumer    