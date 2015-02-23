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

stagedChanges=`git diff --name-only --cached`

if [ "$stagedChanges" == "" ] ; then
    echo "Nothing to commit"
    exit 1
fi

# Path of the version file
versionFile="${PWD}/VERSION"

# Read the first line to determine current version
oldVersion=$(head -n 1 $versionFile)

# Obtain current git information
strDescribe=`git describe --tags --long`

# Establish variables
version=$(echo $strDescribe | cut -f1 -d-)
buildNumber=$(echo $strDescribe | cut -f2 -d-)
commitdate=`date "+%m%d"`
fullDate=`date "+%A, %d/%m/%Y %T"`

# Increment by one as it commits
buildNumber=$((buildNumber +1))

# Establish new version format. i.e v1.01.14.1028
newVersion=$(echo $version Build $buildNumber.$commitdate)

# Only add to commit if there is changes 
if [ "$newVersion" != "$oldVersion" ]; then
    echo 
    echo "Auto generating Build Number"
    echo -------------------------------------
    echo 
    echo -e $fullDate
    echo -e $newVersion'\r' > "$versionFile"
    echo -e $fullDate >> "$versionFile"
    git add $versionFile
    echo "Version updated to $newVersion"
    echo ""
fi
exit 0
