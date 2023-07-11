function commitChaincodeDefinition() {
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
    PEER_0_COMMERCIALBANK_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/commercialbank.islab.re.kr/peers/peer0.commercialbank.islab.re.kr/tls/ca.crt
    PEER_1_COMMERCIALBANK_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/commercialbank.islab.re.kr/peers/peer1.commercialbank.islab.re.kr/tls/ca.crt
    PEER_0_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer0.consumer.islab.re.kr/tls/ca.crt
    PEER_1_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer1.consumer.islab.re.kr/tls/ca.crt
    PEER_2_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer2.consumer.islab.re.kr/tls/ca.crt
    PEER_0_CENTRALBANK_TLS_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/centralbank.islab.re.kr/peers/peer0.centralbank.islab.re.kr/tls/ca.crt
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode commit \
            -o orderer0.islab.re.kr:7050 \
            --tls --cafile $ORDERER_CA \
            --channelID ${channel} \
            --name ${chaincodeName} \
            --version 1.0 \
            --peerAddresses peer0.commercialbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_COMMERCIALBANK_TLS_CA_CERT \
            --peerAddresses peer1.commercialbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_1_COMMERCIALBANK_TLS_CA_CERT \
            --peerAddresses peer0.consumer.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_CONSUMER_TLS_CA_CERT \
            --peerAddresses peer1.consumer.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_1_CONSUMER_TLS_CA_CERT \
            --peerAddresses peer2.consumer.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_2_CONSUMER_TLS_CA_CERT \
            --peerAddresses peer0.centralbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_CENTRALBANK_TLS_CA \
            --sequence 1 \
            --signature-policy $policy
}

function commitChaincodeDefinitionTestR() {
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
    PEER_0_COMMERCIALBANK_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/commercialbank.islab.re.kr/peers/peer0.commercialbank.islab.re.kr/tls/ca.crt
    PEER_1_COMMERCIALBANK_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/commercialbank.islab.re.kr/peers/peer1.commercialbank.islab.re.kr/tls/ca.crt
    PEER_0_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer0.consumer.islab.re.kr/tls/ca.crt
    PEER_1_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer1.consumer.islab.re.kr/tls/ca.crt
    PEER_2_CONSUMER_TLS_CA_CERT=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/consumer.islab.re.kr/peers/peer2.consumer.islab.re.kr/tls/ca.crt
    PEER_0_CENTRALBANK_TLS_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/centralbank.islab.re.kr/peers/peer0.centralbank.islab.re.kr/tls/ca.crt
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode commit \
            -o orderer0.islab.re.kr:7050 \
            --tls --cafile $ORDERER_CA \
            --channelID ${channel} \
            --name ${chaincodeName} \
            --version 1.0 \
            --peerAddresses peer0.commercialbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_COMMERCIALBANK_TLS_CA_CERT \
            --peerAddresses peer1.commercialbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_1_COMMERCIALBANK_TLS_CA_CERT \
            --peerAddresses peer0.centralbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_CENTRALBANK_TLS_CA \
            --sequence 1 \
            --signature-policy $policy
}

function commitChaincodeDefinitionTest() {
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
    PEER_0_CENTRALBANK_TLS_CA=$TLS_PATH/ca.crt
    docker exec -i -t \
        -e CORE_PEER_LOCALMSPID=${org}Org \
        -e CORE_PEER_TLS_ENABLED=true \
        -e CORE_PEER_TLS_CERT_FILE=$TLS_PATH/server.crt \
        -e CORE_PEER_TLS_KEY_FILE=$TLS_PATH/server.key \
        -e CORE_PEER_TLS_ROOTCERT_FILE=$TLS_PATH/ca.crt \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/${org}.islab.re.kr/users/Admin@${org}.islab.re.kr/msp \
        -e CORE_PEER_ADDRESS=peer0.${org}.islab.re.kr:7051 \
        cli peer lifecycle chaincode commit \
            -o orderer0.islab.re.kr:7050 \
            --tls --cafile $ORDERER_CA \
            --channelID ${channel} \
            --name ${chaincodeName} \
            --version 1.0 \
            --peerAddresses peer0.centralbank.islab.re.kr:7051 \
            --tlsRootCertFiles $PEER_0_CENTRALBANK_TLS_CA \
            --sequence 1 \
            --signature-policy $policy
}