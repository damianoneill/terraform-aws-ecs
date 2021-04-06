#!/bin/bash
#
# Push Trust images to an AWS ECR repository

set -e

source_image="$1"
target_image="$2"

# e.g. XXXXXXX.dkr.ecr.us-west-2.amazonaws.com/repository1:latest
registry="$(echo "$target_image" | cut -d/ -f1 | cut -d: -f1)"
region="$(echo "$target_image" | cut -d. -f4)"

# login to ecr
aws ecr get-login-password --region "$region" --profile saml | docker login --username AWS --password-stdin "$registry"

# tag image
docker tag "$source_image" "$target_image"

# push image
docker push "$target_image"