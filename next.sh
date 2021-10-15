#! /bin/bash

set -e
#set -x

die () {
  echo "$@"
  exit 1
}

which gdate >/dev/null 2>&1 || \
  die "Missing gdate, brew install coreutils"

TODAY=`date +%Y%m%d`
DATE=`date -j "+%a %b %e, %Y" | sed 's/  / /'`
LASTWEEK=`gdate +%V -d 'last week'`
WEEKNUM=`date +%V`
YEAR=`date +%Y`
TOP="./journal"
FORMAT="md"

LASTLOG=`find -s $TOP -type f -ipath "*daylog.${FORMAT}" | sort -V | tail -n1`
LASTDIR="${TOP}/${YEAR}/week-${LASTWEEK}"
DIR="${TOP}/${YEAR}/week-${WEEKNUM}"
NEXTLOG="${DIR}/${TODAY}-daylog.${FORMAT}"

# Make the location for the next log file
if [[ ! -d "${DIR}" ]]; then
  # Note we add new 'year' directives by hand.
  # Set up the new week's TOC file here:
  mkdir -p ${DIR}
  cat >${DIR}/week-${WEEKNUM}.md <<EOF
# Week ${WEEKNUM}

## Week ${WEEKNUM} Goals

## Week ${WEEKNUM} Retrospective

## Week ${WEEKNUM} Journal

\`\`\`{toctree}
---
maxdepth: 1
glob:
---
*
\`\`\`

% wiki links for foam graph
EOF
fi
[[ -f "${NEXTLOG}" ]] && die "Next log already exists: $NEXTLOG"

# Start the file with a template
cp ${TOP}/template.${FORMAT} $NEXTLOG

# Set the title to the current date
sed  -i '' -e "s/Day Month/${DATE}/" $NEXTLOG

# Show myself what I was doing yesterday.
sed -n '/begin-followup/,/end-followup/p' $LASTLOG | tee -a $NEXTLOG

# Open in VSCode
echo code . -a . -g $NEXTLOG
code . -a . -g $NEXTLOG
