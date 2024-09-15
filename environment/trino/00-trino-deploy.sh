#!/bin/bash

# Get current file location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)
NAMESPACE="druid-streaming-dev"


helm repo add trino https://trinodb.github.io/charts

helm -n "${NAMESPACE}" uninstall trino-cluster
helm -n "${NAMESPACE}" install -f "${BASEDIR}/values.yaml" --version "0.12.0" trino-cluster trino/trino