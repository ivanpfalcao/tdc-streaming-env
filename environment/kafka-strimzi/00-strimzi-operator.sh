#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"


NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

echo ${NAMESPACE}

kubectl create namespace "${NAMESPACE}"

kubectl -n "${NAMESPACE}" apply -f "https://strimzi.io/install/latest?namespace=${NAMESPACE}"