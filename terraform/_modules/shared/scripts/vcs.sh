#!/bin/bash

set -e

if [[ $GITHUB_ACTIONS == "true" ]];
then

  REPO="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

  if [[ $GITHUB_REF_TYPE == "branch" && $GITHUB_HEAD_REF != "" ]];
  then
    VERSION=$GITHUB_HEAD_REF
  elif [[ $GITHUB_REF_TYPE == "branch" && $GITHUB_HEAD_REF == "" ]];
  then
    VERSION=$GITHUB_REF_NAME
  elif [[ $GITHUB_REF_TYPE == "tag" ]];
  then
    VERSION=$GITHUB_REF_NAME
  fi

  COMMIT=$GITHUB_SHA

else

  REPO=$(git remote get-url origin)
  VERSION=$(git describe --tags --exact-match || git symbolic-ref --short HEAD)
  COMMIT=$(git rev-parse --verify HEAD)

fi

jq -n --arg repo "$REPO" --arg version "$VERSION" --arg commit "$COMMIT" '{ "repo": $repo, "version": $version, "commit": $commit }'
