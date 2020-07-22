#!/bin/sh

if [[ "${CONFIGURATION}" == *"Debug"* ]] ; then
TAGS="TODO|FIXME"
DIR="${SRCROOT}"
echo "searching ${DIR} for ${TAGS}"
find "${DIR}" \( -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
fi
