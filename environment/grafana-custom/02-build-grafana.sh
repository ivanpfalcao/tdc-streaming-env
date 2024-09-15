# Define the namespace for Kubernetes deployment (if not already set)
NAMESPACE="druid-streaming-dev"

# Define the base directory relative to the script location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)


pushd "${BASEDIR}/grafana-11.0.0/packaging/docker/custom"
docker build \
    -t "ivanpfalcao/druid-grafana:11.0.0" \
    --build-arg "GRAFANA_VERSION=11.0.0" \
    --build-arg "GF_INSTALL_PLUGINS=grafadruid-druid-datasource" \
    --progress=plain \
    .
popd