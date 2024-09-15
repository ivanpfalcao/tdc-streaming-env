# Define the namespace for Kubernetes deployment (if not already set)
NAMESPACE="druid-streaming-dev"

# Define the base directory relative to the script location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)


pushd "${BASEDIR}"
docker build \
    -f spark-enrichment.dockerfile \
    -t "ivanpfalcao/spark-enrichment:1.0.0" \
    --progress=plain \
    ..
popd