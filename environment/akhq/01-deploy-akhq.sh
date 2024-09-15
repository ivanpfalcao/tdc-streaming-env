#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"
NAMESPACE="druid-streaming-dev"

kubectl -n "${NAMESPACE}" apply -f "${BASEDIR}/akhq.yaml"