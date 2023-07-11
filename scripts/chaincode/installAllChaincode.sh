source installChaincode.sh

function allinstallChaincode() {
    installChaincode 0 centralbank
    installChaincode 0 commercialbank
    installChaincode 1 commercialbank
    installChaincode 0 consumer
    installChaincode 1 consumer
    installChaincode 2 consumer

    installChaincode 0 centralbank mychaincode
    installChaincode 0 centralbank regulatorychaincode
    installChaincode 0 commercialbank regulatorychaincode
    installChaincode 1 commercialbank regulatorychaincode
}