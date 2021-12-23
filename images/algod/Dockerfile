ARG GO_VERSION=1.17.5
FROM golang:$GO_VERSION

ARG CHANNEL=stable
ENV BIN_DIR="$HOME/node"
ENV ALGORAND_DATA="/opt/data"

# Options for algod config
ARG ALGOD_PORT="4001"
ARG KMD_PORT="4002"
ARG TOKEN="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
ARG CDT_PORT="9392"
ARG TEMPLATE="images/algod/template.json"

# Basic dependencies.
WORKDIR /opt
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils curl git git-core bsdmainutils python3

RUN curl -L https://github.com/algorand/go-algorand-doc/raw/master/downloads/installers/linux_amd64/install_master_linux-amd64.tar.gz --output /opt/install_master_linux-amd64.tar.gz
RUN tar -xf install_master_linux-amd64.tar.gz

RUN ./update.sh -i -c $CHANNEL -p $BIN_DIR -d $BIN_DIR/data -n

COPY . /tmp

# Configure network and setup data dir -> testnetwork
RUN /tmp/images/algod/setup.py \
 --bin-dir "$BIN_DIR" \
 --data-dir "/opt/data" \
 --start-script "/opt/start_algod.sh" \
 --network-dir "/opt/testnetwork" \
 --network-template "/tmp/${TEMPLATE}" \
 --network-token "${TOKEN}" \
 --algod-port "${ALGOD_PORT}" \
 --kmd-port "${KMD_PORT}" \
 --bootstrap-url "${BOOTSTRAP_URL}" \
 --genesis-file "/tmp/${GENESIS_FILE}"

# cleanup
RUN rm -r install_master_linux-amd64.tar.gz

ENV PATH="$BIN_DIR:${PATH}"

# Start algod
CMD ["/opt/start_algod.sh"]