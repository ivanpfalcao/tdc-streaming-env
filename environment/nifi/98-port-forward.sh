#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"
NAMESPACE="druid-streaming-dev"

kubectl -n "${NAMESPACE}" port-forward svc/nifi-helm 8443:8443