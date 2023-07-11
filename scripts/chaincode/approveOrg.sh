function approveForMyOrg() {
    org=${1:-centralbank}
    chaincodeName=${2:-userchaincode}
    channel=${3:-user-channel}
    packid=${4:-0064fb1abbfc96d67a80bd05353bc4e7cc77d0e7bdd1effa1aa12683c7f22152}
    policy="OR('centralbankOrg.peer'"
    if [ "$channel" == "user-channel" ]; then
        policy+=",'commercialbankOrg.peer','consumerOrg.peer'"
    elif [ "$channel" == "regulatory-channel" ]; then
        policy+=",'commercialbankOrg.peer'"
    fi
    
    policy+=')'

    TLS_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/peers/peer0.${org}.islab.re.kr/tls
    ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/islab.re.kr/orderers/orderer0.islab.re.kr/msp/tlscacerts/tlsca.islab.re.kr-cert.pem
    # sample chaincode
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode approveformyorg \
            -o orderer0.islab.re.kr:7050 \
            --tls --cafile $ORDERER_CA \
            --channelID ${channel} \
            --name ${chaincodeName} \
            --version 1.0 \
            --package-id ${chaincodeName}_1.0:${packid} \
            --sequence 1 \
            --signature-policy ${policy}

    # my chaincode
    # docker exec -i -t \
    #     -e CORE_PEER_LOCALMSPID=${org}Org \
    #     -e CORE_PEER_TLS_ENABLED=true \
    #     -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
    #     -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
    #     -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
    #     -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
    #     -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
    #     cli peer lifecycle chaincode approveformyorg \
    #         -o orderer0.islab.re.kr:7050 \
    #         --tls --cafile $ORDERER_CA \
    #         --channelID dev-channel \
    #         --name mychaincode \
    #         --version 1.0 \
    #         --package-id mychaincode_1.0:3e94de7b2e34af5406a24b16335a04310d7953f8019268dee9947c655d8f9186 \
    #         --sequence 1 \
    #         --signature-policy "OR('blockchainOrg.member','aiOrg.member','securityOrg.member')"
}

aprroveOrg "$@"