#!/bin/bash

# Get current file location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)
NAMESPACE="druid-streaming-dev"

kubectl -n "${NAMESPACE}" delete statefulset spark-enrichment
kubectl -n "${NAMESPACE}" apply -f "${BASEDIR}/spark-enrichment-k8s.yaml"