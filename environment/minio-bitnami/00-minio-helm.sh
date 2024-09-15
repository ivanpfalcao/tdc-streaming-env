#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

echo ${1}
NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

kubectl create namespace ${NAMESPACE}

helm repo add bitnami https://charts.bitnami.com/bitnami

helm -n "${NAMESPACE}" install minio-cluster \
    -f "${BASEDIR}/values.yaml" \
    --version 14.7.1 \
    bitnami/minio
