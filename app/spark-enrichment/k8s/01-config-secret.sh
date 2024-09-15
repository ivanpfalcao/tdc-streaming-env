#!/bin/bash

NAMESPACE="druid-streaming-dev"

BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)

SECRET_NAME="spark-config-secret"

CONFIG_FILE_PATH="${BASEDIR}/../config.yaml"

if [ ! -f "$CONFIG_FILE_PATH" ]; then
    echo "Error: $CONFIG_FILE_PATH not found!"
    exit 1
fi

kubectl -n "${NAMESPACE}" delete secret "${SECRET_NAME}"

kubectl -n "${NAMESPACE}" create secret generic "${SECRET_NAME}" \
    --from-file=config.yaml="${CONFIG_FILE_PATH}"