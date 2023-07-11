function main {
    case $1 in
        all | up | clean | down | generate | channel | chaincodeinstall | chaincode )
            cmd=$1
            shift
            $cmd $@
            ;;
        *)

            usage
			exit
            ;;
    esac
}

main $@