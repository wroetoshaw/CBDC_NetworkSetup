source aprroveOrg.sh
source commitChaincode.sh

function allapproveForMyOrg() {
    approveForMyOrg centralbank
    sleep 1
    allcheckCommitReadiness
    approveForMyOrg commercialbank
    sleep 1
    allcheckCommitReadiness
    sleep 1
    approveForMyOrg consumer
    allcheckCommitReadiness

    sleep 1

    approveForMyOrg centralbank mychaincode centralbank-channel e8092266ff3b775215fbca08c6fdaa78ba757bb445276c7633446ddd61474f51
    sleep 1
    checkCommitReadiness centralbank mychaincode centralbank-channel
    
    sleep 1
    approveForMyOrg centralbank regulatorychaincode regulatory-channel 170daa7a0c014f7a93a7c521c8024c8833e7a7bf8700758e0eabdfd62d1225e6
    sleep 1
    checkCommitReadiness centralbank regulatorychaincode regulatory-channel
    checkCommitReadiness commercialbank regulatorychaincode regulatory-channel
    
    sleep 1
    approveForMyOrg commercialbank regulatorychaincode regulatory-channel 170daa7a0c014f7a93a7c521c8024c8833e7a7bf8700758e0eabdfd62d1225e6
    sleep 1
    checkCommitReadiness centralbank regulatorychaincode regulatory-channel
    checkCommitReadiness commercialbank regulatorychaincode regulatory-channel
}