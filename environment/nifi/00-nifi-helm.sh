#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

echo ${1}
NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

kubectl create namespace ${NAMESPACE}
helm repo add cetic https://cetic.github.io/helm-charts
#helm -n ${NAMESPACE} install nifi-helm cetic/nifi
