function invoke_help {

    mode=$1

    echo " "
    if [ "$mode" == "centralbank" ]; then
        echo "centralbank is Two invoke functions are possible"
        echo "issuanceCentralbank, newIssuance"
        echo " "
        echo "issuanceCentralbank is transfer the issued CBDC to the regulatory bank"
        echo "It is requires the bank code and the amount parameter."
        echo "ex) chaincode invoke centralbank issuanceCentralbank 0 4000"
        echo " "
        echo "newIssuance is It is a function to issue a new CBDC."
        echo "It is requires the amount parameter."
        echo "ex) chaincode invoke centralbank newIssuance 3000"
    elif [ "$mode" == "regulatory" ]; then
        echo "regulatory is Two invoke functions are possible"
        echo "issuanceRegulatory, transferToBank"
        echo " "
        echo "issuanceRegulatory is transfer the issued CBDC to the user"
        echo "It is requires the bank code receive user code and the amount parameter."
        echo "ex) chaincode invoke regulatory issuanceRegulatory 0 1 1000"
        echo " "
        echo "transferToBank is transfer to other bank function."
        echo "It is requires the bank code, receive bank code and amount parameter."
        echo "ex) chaincode invoke regulatory transferToBank 0 1 2000"
    elif [ "$mode" == "consumer" ]; then
        echo "consumer is one invoke functions are possible"
        echo "issuanceUser"
        echo " "
        echo "issuanceUser is transfer CBDC the other user"
        echo "It is requires the user code, receiver user code and the amount parameter."
        echo "ex) chaincode invoke centralbank issuanceUser 0 1 300"
        echo " "
    else 
        echo 'Please enter the valid user'
        echo 'Type are centralbank, regulatory, consumer'
    fi

}