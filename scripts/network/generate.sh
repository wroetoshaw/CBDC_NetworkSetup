function generate {
    CRYPTO=${1:-ca}
    mkdir -p $TDIR 2>&1
    mkdir -p $BLKDIR 2>&1

    if [ "$CRYPTO" = "cryptogen" ]; then
        echo "cryptogen ~~~~~~~~~~~~"
        docker run --rm --name fabric-tools \
            -v $CDIR:/tmp \
            -w /tmp \
            hyperledger/fabric-tools:2.2 \
            cryptogen generate --config=/tmp/crypto-config.yaml \
            --output="crypto-config"

        mv $CDIR/crypto-config $ADIR

    fi

    if [ "$CRYPTO" = "ca" ]; then
        echo "Fabric CA ~~~~~~~~~~~~~~"

        IMAGE_TAG=${CA_IMAGETAG} docker-compose -f $COMPOSE_FILE_CA up -d 2>&1
        enrollOrgCA blockchain
        enrollOrgCA security
        enrollOrgCA ai
        enrollOrdererCA
    fi

    echo "systemchannel"
    docker run --rm --name fabric-tools \
        -v $ADIR/crypto-config:/tmp/crypto-config \
        -v $CDIR:/tmp/config \
        -v $BLKDIR:/tmp/block \
        -w /tmp/block \
        hyperledger/fabric-tools:2.2 \
        configtxgen -configPath /tmp/config \
        -profile SystemChannel -channelID system-channel -outputBlock ./genesis.block

    echo "CentralbankChannel"
    docker run --rm --name fabric-tools \
        -v $ADIR/crypto-config:/tmp/crypto-config \
        -v $CDIR:/tmp/config \
        -v $TDIR:/tmp/tx \
        -w /tmp/tx \
        hyperledger/fabric-tools:2.2 \
        configtxgen -configPath /tmp/config \
        -profile CentralbankChannel -channelID centralbank-channel -outputCreateChannelTx ./centralbank-channel.tx

    echo "RegulatoryChannel"
    docker run --rm --name fabric-tools \
        -v $ADIR/crypto-config:/tmp/crypto-config \
        -v $CDIR:/tmp/config \
        -v $TDIR:/tmp/tx \
        -w /tmp/tx \
        hyperledger/fabric-tools:2.2 \
        configtxgen -configPath /tmp/config \
        -profile RegulatoryChannel -channelID regulatory-channel -outputCreateChannelTx ./regulatory-channel.tx

    echo "Userchannel"
    docker run --rm --name fabric-tools \
        -v $ADIR/crypto-config:/tmp/crypto-config \
        -v $CDIR:/tmp/config \
        -v $TDIR:/tmp/tx \
        -w /tmp/tx \
        hyperledger/fabric-tools:2.2 \
        configtxgen -configPath /tmp/config \
        -profile UserChannel -channelID user-channel -outputCreateChannelTx ./user-channel.tx
}

generate "$@"