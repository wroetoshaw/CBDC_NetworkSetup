function chaincode_transfer {
    org=${1:-centralbank}
    chaincodeName=${2:-mychaincode}
    channel=${3:-centralbank-channel}
    bank=$4
    price=$5

    if [ "$channel" == "centralbank-channel" ]; then
        QUERY_TYPE='TransferBalance'
    elif [ "$channel" == "regulatory-channel" ]; then
        QUERY_TYPE='UpdateAccount'
    fi

    if [ "$bank" == "" ] || [ "$price" == "" ]; then
        echo "Please input the bank and price date"
        echo "ex) chaincode invoke centralbank issuanceCentralbank 0 5000"
        exit 0
    fi

    query={'"'Args'"':['"'$QUERY_TYPE'"','"'Bank$bank'"','"'$price'"']}
    
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
        cli peer chaincode invoke \
            -o orderer0.islab.re.kr:7050 \
            --tls --cafile $ORDERER_CA \
            --channelID ${channel} \
            --name ${chaincodeName} \
            -c $query
}

chaincode_transfer "$@"
