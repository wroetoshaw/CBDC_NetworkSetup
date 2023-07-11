source invoke.sh
source invokeCentral.sh
source invokeRegulatory.sh
source invokeHelp.sh


function chaincode_invoke {
    object=$1
    shift
    method=$1
    shift
    if [ "$object" == 'centralbank' ]; then
        if [ "$method" == 'issuanceCentralbank' ]; then
            chaincode_transfer_admin $@
        elif [ "$method" == 'newIssuance' ]; then 
            chaincode_invoke_central centralbank mychaincode centralbank-channel $method $1
        else
            invoke_help $object
        fi
    elif [ "$object" == 'regulatory' ]; then
        if [ "$method" == 'issuanceRegulatory' ]; then
            chaincode_transfer_regulatory $@
        elif [ "$method" == 'transferToBank' ]; then
            chaincode_invoke_regulatory commercialbank regulatorychaincode regulatory-channel $method $1 $2 $3
        else
            invoke_help $object
        fi
    elif [ "$object" == 'consumer' ]; then
        if [ "$method" == 'issuanceUser' ]; then
            chaincode_transfer_cbdc_user $1 $2 $3
        else
            invoke_help $object
        fi
    else
        invoke_help
    fi
}