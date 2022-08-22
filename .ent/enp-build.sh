#!/bin/bash

. .ent/enp-prereq.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_log_i "Running build"

_log_i "Building \"$ENTANDO_OPT_DOCKER_ORG/$ENTANDO_PRJ_IMAGE_NAME:$ENTANDO_PRJ_VERSION\""

docker build -t "$ENTANDO_OPT_DOCKER_ORG/$ENTANDO_PRJ_IMAGE_NAME:$ENTANDO_PRJ_VERSION" .