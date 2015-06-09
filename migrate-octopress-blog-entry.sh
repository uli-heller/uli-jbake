#!/bin/sh

D="$(dirname "$0")"
BN="$(basename "$0")"
OCTOPRESS_FILE="$1"

if [ ! -s "${OCTOPRESS_FILE}" ]; then
  echo >&2 "${BN}: Unable to read '${OCTOPRESS_FILE}' - ABORTED"
  exit 1
fi

# Extract year, month, day
YEAR="$(basename "${OCTOPRESS_FILE}"|cut -c1-4)"
MONTH="$(basename "${OCTOPRESS_FILE}"|cut -c6-7)"
DAY="$(basename "${OCTOPRESS_FILE}"|cut -c9-10)"

# Extract core name
CORE="$(basename "${OCTOPRESS_FILE}"|cut -c12-)"
CORE="$(basename "${CORE}" .md)"

JBAKE_BLOG_DIR="${D}/content/blog/${YEAR}"
if [ ! -d "${JBAKE_BLOG_DIR}" ]; then
  mkdir -p "${JBAKE_BLOG_DIR}"
fi

JBAKE_COMPATIBILITY_DIR="${D}/content/blog/${YEAR}/${MONTH}/${DAY}/${CORE}"
if [ ! -d "${JBAKE_COMPATIBILITY_DIR}" ]; then
  mkdir -p "${JBAKE_COMPATIBILITY_DIR}"
fi

JBAKE_BLOG_FILE="${JBAKE_BLOG_DIR}/$(basename "${OCTOPRESS_FILE}")"
cp "${OCTOPRESS_FILE}" "${JBAKE_BLOG_FILE}"
"${D}/octopress2jbake.sh" "${JBAKE_BLOG_FILE}"

(
cat <<EOF
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta http-equiv="refresh" content="0; url=@BLOG@" />
  </head>
</html>
EOF
)|sed "s!@BLOG@!../../../$(basename "${JBAKE_BLOG_FILE}" .md).html!"\
> "${JBAKE_COMPATIBILITY_DIR}/index.html"

exit 0







# Replace 2nd matching line
{
cat <<EOF|sed -e '0,/^---.*/! {0,/^---.*/ s/^---.*/~~~~~~/}' >a
----
----
----
EOF
cat <<EOF >expected
----
~~~~~~
----
EOF
diff -u a expected >/dev/null || { echo "Replacing the 2nd dash line didn't work"; exit 1; }
}

# Delete first matching line
{
cat <<EOF|sed -e 'x;/./{x;b};x;/^---.*/{h;d}' >a
----
-----
------
EOF
cat <<EOF >expected
-----
------
EOF
diff -u a expected >/dev/null || { echo "Deleting the 1st dash line didn't work"; exit 1; }
}

# Delete first matching line (again)
{
cat <<EOF|sed '0,/^---.*/{//d;}' >a
----
-----
------
EOF
cat <<EOF >expected
-----
------
EOF
diff -u a expected >/dev/null || { echo "Deleting the 1st dash line didn't work (2)"; exit 1; }
}

# Replace first matching line (again)
{
cat <<EOF|sed '0,/^---.*/s//~~~~~~/' >a
----
-----
------
EOF
cat <<EOF >expected
~~~~~~
-----
------
EOF
diff -u a expected >/dev/null || { echo "Replacing the 1st dash line didn't work"; exit 1; }
}
rm a expected

sed -i \
  -e "s/layout:\s*/type=/"\
  -e "s/date:\s*/date=/"\
  -e "s/updated:\s*/updated=/"\
  -e 's/title:\s"\(.*\)"/title=\1/'\
  -e "s/author:\s*/author=/"\
  -e "s/comments:\s*/comments=/"\
  -e "s/categories:\s*/tags=/"\
  -e "s/published:\s*true/status=published/"\
  -e '0,/^---.*/{//d;}' \
  -e '0,/^---.*/s//~~~~~~/' \
  -e 's/^\s*{% endcodeblock %}/```/' \
  -e 's/^\s*{% codeblock \(.*\) lang:\(.*\) %}/\1\n\n``` \2/' \
  "${OCTOPRESS_FILE}"
