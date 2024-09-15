# Define the base directory relative to the script location
BASEDIR=$(cd -P -- "$(dirname -- "${0}")" && pwd -P)

tar -xzf "${BASEDIR}/grafana-11.0.0.tar.gz" -C "${BASEDIR}"