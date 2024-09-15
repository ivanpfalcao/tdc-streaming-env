# Define the namespace for Kubernetes deployment (if not already set)
NAMESPACE="druid-streaming-dev"

# Define the base directory relative to the script location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)


kubectl -n "${NAMESPACE}" apply -f "${BASEDIR}/grafana.yaml"