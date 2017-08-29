#!/bin/bash

REGTOKEN=$1
CONTAINER=$2
MACHINETAG=$3
GITLAB_REGISTER_CMD="gitlab-runner register --non-interactive --url http://gitlab-ce:17777/ --registration-token $REGTOKEN --limit 1 --executor shell --name $HOSTNAME --run-untagged --tag-list shell,$MACHINETAG"

echo "registering container $CONTAINER with tag $MACHINETAG"
docker exec -it -t $CONTAINER bash -c "$GITLAB_REGISTER_CMD"
echo "starting gitlab-runner service"
docker exec -it $CONTAINER bash -c 'gitlab-runner start'
