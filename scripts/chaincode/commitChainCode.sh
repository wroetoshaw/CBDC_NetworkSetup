
function allcheckCommitReadiness() {
    checkCommitReadiness centralbank
    checkCommitReadiness commercialbank
    checkCommitReadiness consumer
}

function checkCommitReadiness() {
    org=${1:-centralbank}
    chaincodeName=${2:-userchaincode}
    channel=${3:-user-channel}
    policy="OR('centralbankOrg.peer'"
    if [ "$channel" == "user-channel" ]; then
        policy+=",'commercialbankOrg.peer','consumerOrg.peer'"
    elif [ "$channel" == "regulatory-channel" ]; then
        policy+=",'commercialbankOrg.peer'"
    fi
    
    policy+=')'

    TLS_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/peers/peer0.${org}.islab.re.kr/tls
    ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/islab.re.kr/orderers/orderer0.islab.re.kr/msp/tlscacerts/tlsca.islab.re.kr-cert.pem
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode checkcommitreadiness \
        -o orderer0.islab.re.kr:7050 \
        --channelID ${channel} \
        --tls --cafile $ORDERER_CA \
        --name ${chaincodeName} \
        --version 1.0 \
        --sequence 1 \
        --signature-policy $policy
        # "OR('centralbankOrg.peer','commercialbankOrg.peer','consumerOrg.peer')"
}


checkCommitReadiness "$@"