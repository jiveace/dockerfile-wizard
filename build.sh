#!/usr/bin/env bash

IMAGE_NAME="terraform-aws"
TAG="0.12.21"
DOCKER_USERNAME=imaxwellisatwork

docker build -t ${IMAGE_NAME} . && \
docker tag ${IMAGE_NAME} ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG} && \
docker tag ${IMAGE_NAME} ${DOCKER_USERNAME}/${IMAGE_NAME}:latest && \
docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG} && \
docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:latest