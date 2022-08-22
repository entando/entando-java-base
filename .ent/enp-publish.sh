#!/bin/bash

. .ent/enp-prereq.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_log_i "Running publication"

docker login "$ENTANDO_PRJ_IMAGE_REGISTRY" \
  --username "$ENTANDO_OPT_DOCKER_USERNAME" \
  --password-stdin <<< "$ENTANDO_OPT_DOCKER_PASSWORD"
  
IMAGE="$ENTANDO_OPT_DOCKER_ORG/$ENTANDO_PRJ_NAME:$ENTANDO_PRJ_VERSION"

_log_i "Publishing \"$IMAGE\" to \"$ENTANDO_PRJ_IMAGE_REGISTRY\""

docker tag "$IMAGE" "$ENTANDO_PRJ_IMAGE_REGISTRY/$IMAGE"
docker push "$ENTANDO_PRJ_IMAGE_REGISTRY/$IMAGE"