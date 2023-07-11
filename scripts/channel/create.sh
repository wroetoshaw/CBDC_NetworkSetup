function channel_create {
    org=${1:-centralbank}
    channelName=${2:-regulatory}
    TLS_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/peers/peer0.${org}.islab.re.kr/tls
    docker exec -i -t \
        -e CORE_PEER_ID=peer0.${org}.islab.re.kr \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        -e CORE_PEER_CHAINCODEADDRESS=peer0.${org}.islab.re.kr:7052 \
        -e CORE_PEER_GOSSIP_BOOTSTRAP=peer0.${org}.islab.re.kr:7051 \
        -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.${org}.islab.re.kr:7051 \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer channel create \
            -o orderer0.islab.re.kr:7050 \
            -c ${channelName}-channel \
            -f /opt/gopath/src/github.com/hyperledger/fabric/peer/tx/${channelName}-channel.tx \
            --outputBlock /opt/gopath/src/github.com/hyperledger/fabric/peer/block/${channelName}-channel.block \
            --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/islab.re.kr/msp/tlscacerts/tlsca.islab.re.kr-cert.pem
}

channel_create "$@" 