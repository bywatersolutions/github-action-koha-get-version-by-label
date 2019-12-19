#!/bin/bash

echo "1: $1";
echo "2: $2";

VERSION_LABEL=$1

echo "VERSION LABEL: $VERSION_LABEL"

if [[ "$VERSION_LABEL" == "master" ]]; then
    KOHA_VERSION_BRANCH_NAME='master'
elif [[ "$VERSION_LABEL" == "stable" ]]; then
    KOHA_VERSION_LINE=$(git ls-remote --heads git://git.koha-community.org/koha.git | grep '[0-9]\{2\}\.[0-9]\{2\}\.x' | tac | sed '1q;d')
    echo "KOHA VERSION LINE: $KOHA_VERSION_LINE"
    IFS='/' read -ra KOHA_VERSION_LINE_PARTS <<< "$KOHA_VERSION_LINE"
    KOHA_VERSION_BRANCH_NAME=${KOHA_VERSION_LINE_PARTS[2]}
elif [[ "$VERSION_LABEL" == "oldstable" ]]; then
    KOHA_VERSION_LINE=$(git ls-remote --heads git://git.koha-community.org/koha.git | grep '[0-9]\{2\}\.[0-9]\{2\}\.x' | tac | sed '2q;d')
    echo "KOHA VERSION LINE: $KOHA_VERSION_LINE"
    IFS='/' read -ra KOHA_VERSION_LINE_PARTS <<< "$KOHA_VERSION_LINE"
    KOHA_VERSION_BRANCH_NAME=${KOHA_VERSION_LINE_PARTS[2]}
fi

echo "KOHA VERSION BRANCH NAME: $KOHA_VERSION_BRANCH_NAME"

echo ::set-output name=current-branch-name::${KOHA_VERSION_BRANCH_NAME}
