function chaincode_transfer_cbdc_user_fn {
    org=${1:-consumer}
    chaincodeName=${2:-userchaincode}
    channel=${3:-user-channel}
    sender=$4
    receiver=$5
    price=$6
    arg=$7

    QUERY_TYPE=''
    if [ "$channel" == "user-channel" ]; then
        QUERY_TYPE='TransferBalanceUser'
    elif [ "$channel" == "regulatory-channel" ]; then
        QUERY_TYPE='UpdateAccountUser'
    fi

    if [ "$sender" == "" ] || [ "$receiver" == "" ] || [ "$price" == "" ]; then
        echo "Please input the send user, receiver user and price data"
        echo "ex) chaincode invoke consumer issuanceUser 0 1 500"
        exit 0
    fi

    query={'"'Args'"':['"'$QUERY_TYPE'"'
    
    if [ "$QUERY_TYPE" == "TransferBalanceUser" ]; then
        query+=,'"'$sender'"','"'User$receiver'"','"'User$price'"','"'$arg'"']}
    elif [ "$QUERY_TYPE" == "UpdateAccountUser" ]; then
        query+=,'"'$sender'"','"'User$receiver'"','"'$arg'"']}
    fi 
    
    
    
    # ,'"'User$sender'"','"'User$receiver'"','"'$price'"']}
    
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

chaincode_transfer_cbdc_user_fn "$@"