
function packageChaincode() {
    # sample chaincode

    docker exec -i -t \
        -w /opt/gopath/src/github.com/asset-transfer-basic/chaincode-go \
        cli go mod vendor

    docker exec -i -t \
        cli peer lifecycle chaincode package mychaincode.tar.gz \
            --path /opt/gopath/src/github.com/asset-transfer-basic/chaincode-go \
            --label mychaincode_1.0

    docker exec -i -t \
        -w /opt/gopath/src/github.com/asset-transfer-basic/chaincode-user \
        cli go mod vendor

    docker exec -i -t \
        cli peer lifecycle chaincode package userchaincode.tar.gz \
            --path /opt/gopath/src/github.com/asset-transfer-basic/chaincode-user \
            --label userchaincode_1.0
    
    docker exec -i -t \
        -w /opt/gopath/src/github.com/asset-transfer-basic/chaincode-regulatory \
        cli go mod vendor

    docker exec -i -t \
        cli peer lifecycle chaincode package regulatorychaincode.tar.gz \
            --path /opt/gopath/src/github.com/asset-transfer-basic/chaincode-regulatory \
            --label regulatorychaincode_1.0

    echo "packaging ~~~"
}

packageChaincode "$@"
