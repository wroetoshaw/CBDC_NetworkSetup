DIR="$( cd "$( dirname "$0" )" && pwd )"
CDIR=$DIR/config
BDIR=$DIR/build
ADIR=$BDIR/artifacts
ACDIR=$ADIR/crypto-config
CADIR=$ACDIR/fabric-ca
TDIR=$ADIR/tx
BLKDIR=$ADIR/block
ORDIR=$ACDIR/ordererOrganizations

COMPOSE_FILE_PEER=dockercompose/docker-compose-peer.yaml
COMPOSE_FILE_ORDERER=dockercompose/docker-compose-orderer.yaml
COMPOSE_FILE_COUCH=dockercompose/docker-compose-couch.yaml
COMPOSE_FILE_CLI=dockercompose/docker-compose-cli.yaml
COMPOSE_FILE_CA=dockercompose/docker-compose-ca.yaml
IMAGETAG="2.2"
CA_IMAGETAG="1.4.9"
usermod -aG docker $USER

function up {
    COMPOSE_FILES="-f ${COMPOSE_FILE_PEER}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_ORDERER}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_COUCH}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_CLI}"
    IMAGE_TAG=$IMAGETAG docker-compose ${COMPOSE_FILES} up -d 2>&1
    docker ps -a
}
