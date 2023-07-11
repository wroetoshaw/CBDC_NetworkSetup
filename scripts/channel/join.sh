function channel_join() {
    number=${1:-0}
    org=${2:-centralbank}
    channelName=${3:-regulatory}
    TLS_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/peers/peer${number}.${org}.islab.re.kr/tls
    docker exec -i -t \
        -e CORE_PEER_ID=peer${number}.${org}.islab.re.kr \
        -e CORE_PEER_ADDRESS=peer${number}.${org}.islab.re.kr:7051 \
        -e CORE_PEER_CHAINCODEADDRESS=peer${number}.${org}.islab.re.kr:7052 \
        -e CORE_PEER_GOSSIP_BOOTSTRAP=peer${number}.${org}.islab.re.kr:7051 \
        -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer${number}.${org}.islab.re.kr:7051 \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer${number}.${org}.islab.re.kr:7051 \
        cli peer channel join \
            -b /opt/gopath/src/github.com/hyperledger/fabric/peer/block/${channelName}-channel.block
}

channel_join "$@" 
