#!/bin/sh
# armacode pre-commit Hook
# Increment Build number every commit, to keep track of builds.
#
# Installation
# ------------
#
# For developers, please install this hook using SYMBOLIC LINK into:
# .git/hooks/
# It is mandatory to keep track of the Versions for every commit.

$(git fetch origin master)

LOCAL=$(git rev-parse @)

REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

echo "LOCAL"
echo "-----"
echo $LOCAL
echo ""
echo "REMOTE"
echo "-----"
echo $REMOTE
echo ""
echo "BASE"
echo "-----"
echo $BASE
if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi