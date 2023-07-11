function query_help {

    mode=$1

    echo " "
    if [ "$mode" == "centralbank" ]; then
        echo "centralbank is Three query functions are possible"
        echo "viewRecordRegulatory, viewRecordCentral, viewCentralBankAccount"
        echo " "
        echo "viewRecordRegulatory is a function to inquire about a bank's CBDC transaction record."
        echo "ex) chaincode query centralbank viewRecordRegulatory"
        echo " "
        echo "viewRecordCentral is a function to inquire about a central bank's CBDC transaction record."
        echo "ex) chaincode query centralbank viewRecordCentral"        
        echo " "
        echo "viewCentralBankAccount is a method that shows the central bank's CBDC balance."
        echo "ex) chaincode query centralbank viewCentralBankAccount"
    elif [ "$mode" == "regulatory" ]; then
        echo "ragulatory is Three query functions are possible"
        echo "viewBankAccount, viewRecordAccount, viewRecordUser"
        echo " "
        echo "viewBankAccount is a function to check the current balance of commercial banks."
        echo "It is Requires the bank code parameter."
        echo "ex) chaincode query regulatory viewBankAccount 0"
        echo " "
        echo "viewRecordAccount is function checks the CBDC transaction record of a commercial bank."
        echo "ex) chaincode query regulatory viewRecordAccount"
        echo " "
        echo "viewRecordUser is a function to inquire about a user's CBDC transaction record."
        echo "ex) chaincode query regulatory viewRecordUser"
    elif [ "$mode" == "consumer" ]; then
        echo "consumer is two query functions are possible"
        echo "viewUserAccount, viewRecordAccount"
        echo " "
        echo "viewUserAccount is a function to check the current balance of user."
        echo "It is Requires the user code parameter."
        echo "ex) chaincode query consumer viewUserAccount 0"
        echo " "
        echo "viewRecordAccount is a function that can check the user's transaction record."
        echo "It is Requires the user code parameter."
        echo "ex) chaincode query consumer viewRecordAccount 0"
    else 
        echo 'Please enter the valid user'
        echo 'Type are centralbank, regulatory, consumer'
    fi

}

query_help "$@"