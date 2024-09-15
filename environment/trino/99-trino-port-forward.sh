#!/bin/bash

# Get current file location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)
NAMESPACE="druid-streaming-dev"


#helm repo add trino https://trinodb.github.io/charts

kubectl -n "${NAMESPACE}" port-forward svc/trino-cluster 8080:8080
