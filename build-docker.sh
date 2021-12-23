#!/bin/bash
set -e

conio_projects_path="/opt/projects/Conio"
volume_path=$conio_projects_path"/algod-local/sandbox/algod_data"

image="algo-sandbox:prova2"

# build algod image
docker image build -t $image -f ./images/algod/Dockerfile .

# save generated node data inside a local volume directory to be mounted on the container
container_name=`docker create -ti $image bash` && docker cp $container_name:/opt/testnetwork $volume_path && docker rm -f $container_name
