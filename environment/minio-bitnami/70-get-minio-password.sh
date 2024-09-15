#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

echo ${1}
NAMESPACE="druid-streaming-dev"
if [ "$1" != "" ]
then
    NAMESPACE="${1}"
fi

export ROOT_USER=$(kubectl get secret --namespace ${NAMESPACE} minio-cluster -o jsonpath="{.data.root-user}" | base64 -d)
export ROOT_PASSWORD=$(kubectl get secret --namespace ${NAMESPACE} minio-cluster -o jsonpath="{.data.root-password}" | base64 -d)

echo "User: ${ROOT_USER}"
echo "Password: ${ROOT_PASSWORD}"
