
function installChaincode() {
    number=${1:-0}
    org=${2:-centralbank}
    chaincodeName=${3:-userchaincode}
    TLS_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/peers/peer${number}.${org}.islab.re.kr/tls
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer${number}.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode install ${chaincodeName}.tar.gz \
            --peerAddresses peer${number}.${org}.islab.re.kr:7051 \
            --tlsRootCertFiles ${TLS_PATH}/server.crt
}
installChaincode "$@"
