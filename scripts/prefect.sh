#!/bin/bash
# Variables and settings
# Argument(s):
# ENV - The environment to run
for ARGUMENT in "$@"
do
   KEY=$(echo "$ARGUMENT" | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# options
set -a
set -e
set +x

ROOT_FOLDER=$(dirname "$0")
pushd "${ROOT_FOLDER}" > /dev/null 2>&1

# files and folders
VOLUMES_FOLDER=../volumes
LOCAL_ENV_FILE=../.env

# shellcheck source=/dev/null
source ${LOCAL_ENV_FILE}

# Functions
function docker_build() {
    if [ -d ${VOLUMES_FOLDER} ]; then
        sudo chown -R "$USER" ${VOLUMES_FOLDER}
    fi
}

function status() {
    if [ "$ENV" == "LOCAL" ]; then
        docker-compose -f ../docker-compose-local.yml ps
    else
        docker-compose ps
    fi
}

function stop() {
    if [ "$ENV" == "LOCAL" ]; then
        docker-compose -f ../docker-compose-local.yml down
    else
        docker-compose down
    fi
}

function reset() {
    echo 'Deleting ALL Prefect data...'
    sudo rm -rf ../volumes
    echo 'Done.'
}

function start_server() {
    if [ "$ENV" == "LOCAL" ]; then
        docker-compose -f ../docker-compose-local.yml up -d --force-recreate --no-deps postgres 
        docker-compose -f ../docker-compose-local.yml up -d --force-recreate --no-deps prefect-server 
    else
        docker-compose up -d --force-recreate --no-deps postgres 
        docker-compose up -d --force-recreate --no-deps prefect-server 
    fi   
}

function initialize() {
    echo "Environment needs to be initialized..."
    rm -rf ${VOLUMES_FOLDER} && \
    mkdir -p ${VOLUMES_FOLDER}/postgres && \
    mkdir -p ${VOLUMES_FOLDER}/prefect > /dev/null 2>&1 
    
    start_server
}

function start() {
    if [ ! -d "${VOLUMES_FOLDER}" ]; then
        initialize
    else
        start_server
    fi

    if [ "$ENV" == "LOCAL" ]; then
        docker-compose -f ../docker-compose-local.yml up -d --force-recreate --no-deps prefect-agent  
    else
        docker-compose up -d --force-recreate --no-deps prefect-agent  
    fi

    status
}

case "$1" in
    "start")
        start
        ;;
    "status")
        status
        ;;
    "stop")
        stop
        ;;
    "restart")
        stop
        start
        ;;
    "reset")
        stop
        reset
        ;;
    "docker_build")
        docker_build
        ;;
    *)
        echo "Unknown option <$1>. Valid options: [ start, stop, restart, status, reset, docker_build ]"
        exit 1
        ;;
esac

popd > /dev/null 2>&1


