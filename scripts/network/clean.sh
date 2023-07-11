function clean {
    down
    rm -Rf $BDIR
    rm -Rf channel-artifacts
    rm -Rf ./chaincode-go/vendor
    rm -Rf ./chaincode-user/vendor
    rm -Rf ./chaincode-regulatory/vendor
    rm -Rf ./atcc/vendor
}