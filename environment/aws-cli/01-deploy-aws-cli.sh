#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

echo ${1}
NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

kubectl create namespace ${NAMESPACE}

kubectl -n ${NAMESPACE} apply -f "${BASEDIR}/aws-cli.yaml"
