function chaincode_transfer_user {
    org=${1:-consumer}
    chaincodeName=${2:-userchaincode}
    channel=${3:-user-channel}
    bank=$4
    user=$5
    price=$6

    if [ "$channel" == "user-channel" ]; then
        QUERY_TYPE='UpdateAccount'
    elif [ "$channel" == "regulatory-channel" ]; then
        QUERY_TYPE='UpdateSendBalance'
    fi

    if [ "$bank" == "" ] || [ "$user" == "" ] || [ "$price" == "" ]; then
        echo "Please input the bank, user and price data"
        echo "ex) chaincode invoke regulatory issuanceRegulatory 0 0 5000"
        exit 0
    fi

    query={'"'Args'"':['"'$QUERY_TYPE'"','"'Bank$bank'"','"'User$user'"','"'$price'"']}
    
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
chaincode_transfer_user "$@" 