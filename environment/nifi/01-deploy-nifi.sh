#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

echo ${1}
NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

kubectl create namespace ${NAMESPACE}

helm -n ${NAMESPACE} install -f "${BASEDIR}/values.yaml" nifi-helm cetic/nifi
