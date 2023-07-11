source ../channel/create.sh
source ../channel/join.sh


function channel {
    case $1 in
        create | join )
            cmd=$1
            shift
            channel_$cmd $@
            ;;
        *)
            channel_usage
			exit
            ;;
    esac
}