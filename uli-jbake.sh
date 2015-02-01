#!/bin/sh
#set -x
JBAKE_HOME="${JBAKE_HOME:-$(ls -d /opt/jbake*|sort|tail -1)}"
JAVA_HOME="${JAVA_HOME:-$(ls -d /opt/jdk*1.7.0*|sort|tail -1)}"
export PATH="${JAVA_HOME}/bin:${PATH}"

BASE_FOLDER="$(dirname "$0")"
OUTPUT_FOLDER="${BASE_FOLDER}/output"
CONTENT_FOLDER="${BASE_FOLDER}/content"

(
  cd "${CONTENT_FOLDER}"
  find "." -type d
)|while read d; do
  D="${OUTPUT_FOLDER}/${d}"
  if [ ! -d "${D}" ]; then
    mkdir -p "${D}"
  fi
done

(
  cd "${CONTENT_FOLDER}"
  find "." -type f\
   ! -name "*.adoc"\
   ! -name "*~" \
   ! -name "*.md"
)|while read f; do
  F="${CONTENT_FOLDER}/${f}"
  T="${OUTPUT_FOLDER}/${f}"
  cp -u "${F}" "${T}"
done


cp -ru "${CONTENT_FOLDER}/." "${OUTPUT_FOLDER}/."
"${JBAKE_HOME}/bin/jbake" "$@"
