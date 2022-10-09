#!/bin/bash

set -e

if [[ $GITHUB_ACTIONS == "true" ]];
then
  CI="true"
else
  CI="false"
fi

jq -n --arg ci "$CI" '{ "ci": $ci }'
