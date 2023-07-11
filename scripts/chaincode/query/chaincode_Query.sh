source chaincodeQuery.sh

function chaincode_query {
    object=$1
    shift
    method=$1
    shift

    # if [ "$method" == 'viewRecordUser' ]; then
    #         chaincodeQuery centralbank userchaincode user-channel ReadTransferHistory
    #     el

    if [ "$object" == 'centralbank' ]; then
        if [ "$method" == 'viewRecordRegulatory' ]; then 
            chaincodeQuery centralbank regulatorychaincode regulatory-channel ReadTransferHistory
        elif [ "$method" == 'viewRecordCentral' ]; then 
            chaincodeQuery centralbank mychaincode centralbank-channel ReadTransferHistory
        elif [ "$method" == 'viewCentralBankAccount' ]; then 
            chaincodeQuery centralbank mychaincode centralbank-channel ReadTotalBalance
        else
            query_help $object
        fi
    elif [ "$object" == 'regulatory' ]; then
        if [ "$method" == 'viewBankAccount' ]; then
            chaincodeQuery commercialbank regulatorychaincode regulatory-channel ReadAccount Bank$1
        elif [ "$method" == 'viewRecordAccount' ]; then
            chaincodeQuery commercialbank regulatorychaincode regulatory-channel ReadTransferHistory
        elif [ "$method" == 'viewRecordUser' ]; then
            chaincodeQuery commercialbank userchaincode user-channel ReadTransferHistory
        else
            query_help $object
        fi
    elif [ "$object" == 'consumer' ]; then
        if [ "$method" == 'viewUserAccount' ]; then
            chaincodeQuery commercialbank userchaincode user-channel ReadAccount User$1
        elif [ "$method" == 'viewRecordAccount' ]; then
            chaincodeQuery commercialbank userchaincode user-channel ReadHistoryUserOnly User$1
        else
            query_help $object
        fi
    else
        query_help
    fi
}

chaincode_query "$@"