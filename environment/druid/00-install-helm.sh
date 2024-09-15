# Define the namespace for Kubernetes deployment (if not already set)
NAMESPACE="druid-streaming-dev"

helm repo add datainfra https://charts.datainfra.io
helm repo update
helm -n ${NAMESPACE} upgrade -i --create-namespace cluster-druid-operator datainfra/druid-operator