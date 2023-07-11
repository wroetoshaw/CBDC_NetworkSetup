function down {
    COMPOSE_FILES="-f ${COMPOSE_FILE_PEER}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_ORDERER}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_COUCH}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_CLI}"
    COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_CA}"
    IMAGE_TAG=$CA_IMAGETAG docker-compose ${COMPOSE_FILES} down -v 2>&1
    IMAGE_TAG=$IMAGETAG docker-compose ${COMPOSE_FILES} down -v 2>&1
    docker volume ls -qf "dangling=true" | xargs docker volume rm
    docker ps -a
}