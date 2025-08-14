#!/bin/bash

VERSION_LABEL=$1

echo "VERSION LABEL: $VERSION_LABEL"

if [[ "$VERSION_LABEL" == "main" ]]; then
    KOHA_VERSION_BRANCH_NAME='main'
elif [[ "$VERSION_LABEL" == "stable" ]]; then
    KOHA_VERSION_LINE=$(git ls-remote --heads https://github.com/Koha-Community/Koha.git | grep '[0-9]\{2\}\.[0-9]\{2\}\.x' | tac | sed '1q;d')
    echo "KOHA VERSION LINE: $KOHA_VERSION_LINE"
    IFS='/' read -ra KOHA_VERSION_LINE_PARTS <<< "$KOHA_VERSION_LINE"
    KOHA_VERSION_BRANCH_NAME=${KOHA_VERSION_LINE_PARTS[2]}
elif [[ "$VERSION_LABEL" == "oldstable" ]]; then
    KOHA_VERSION_LINE=$(git ls-remote --heads https://github.com/Koha-Community/Koha.git | grep '[0-9]\{2\}\.[0-9]\{2\}\.x' | tac | sed '2q;d')
    echo "KOHA VERSION LINE: $KOHA_VERSION_LINE"
    IFS='/' read -ra KOHA_VERSION_LINE_PARTS <<< "$KOHA_VERSION_LINE"
    KOHA_VERSION_BRANCH_NAME=${KOHA_VERSION_LINE_PARTS[2]}
fi

IFS='.' read -ra KOHA_VERSION_PARTS <<< "$KOHA_VERSION_BRANCH_NAME"
KOHA_VERSION_MAJOR=${KOHA_VERSION_PARTS[0]}
KOHA_VERSION_MINOR=${KOHA_VERSION_PARTS[1]}
KOHA_VERSION_MAJOR_MINOR="$KOHA_VERSION_MAJOR.$KOHA_VERSION_MINOR"

echo "KOHA VERSION BRANCH NAME: $KOHA_VERSION_BRANCH_NAME"
echo "KOHA VERSION MAJOR MINOR: $KOHA_VERSION_MAJOR_MINOR"
echo "KOHA VERSION MAJOR: $KOHA_VERSION_MAJOR"
echo "KOHA VERSION MINOR: $KOHA_VERSION_MINOR"

# Use modern GitHub Actions output syntax instead of deprecated ::set-output
echo "current-branch-name=${KOHA_VERSION_BRANCH_NAME}" >> $GITHUB_OUTPUT
echo "branch-name=${KOHA_VERSION_BRANCH_NAME}" >> $GITHUB_OUTPUT
echo "version-major-minor=${KOHA_VERSION_MAJOR_MINOR}" >> $GITHUB_OUTPUT
echo "version-major=${KOHA_VERSION_MAJOR}" >> $GITHUB_OUTPUT
echo "version-minor=${KOHA_VERSION_MINOR}" >> $GITHUB_OUTPUT
