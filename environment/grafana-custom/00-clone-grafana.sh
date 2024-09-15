# Define the base directory relative to the script location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)

curl -L -o "${BASEDIR}/grafana-11.0.0.tar.gz" https://github.com/grafana/grafana/archive/refs/tags/v11.0.0.tar.gz