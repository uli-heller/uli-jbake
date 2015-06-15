#!/bin/sh

OCTOPRESS_FILE="$1"

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
  -e "s/published:\s*true/status=published/"\
  -e '0,/^---.*/{//d;}' \
  -e '0,/^---.*/s//~~~~~~/' \
  -e 's/^\s*{% endcodeblock %}/```/' \
  -e 's/^\s*{% codeblock lang:\(.*\) %}/\n``` \1/' \
  -e 's/^\s*{% codeblock \(.*\) lang:\(.*\) %}/*Listing: \1*\n\n``` \2/' \
  -e 's/^\s*{% codeblock \(.*\) %}/*Listing: \1*\n\n```/' \
  -e "s/^\s*{% img \(.*\) '\(.*\)' %}/\n![\2](\1)\n/" \
  -e "s/^\s*{% img \(.*\) %}/\n!(\1)\n/" \
  "${OCTOPRESS_FILE}"

cat "${OCTOPRESS_FILE}"\
|(
  CATEGORIES=0
  FIELDS=1
  TAGS=
  while read l; do
    if [ "${FIELDS}" -ne 0 ]; then
      if [ "$l" = "categories:" ]; then
        CATEGORIES=1
        TAGS=""
      else
        if expr "${l}" : "#" >/dev/null; then
           continue
        fi
        if expr "${l}" : "~~~~" >/dev/null; then
           FIELDS=0
        fi
        case "${CATEGORIES}" in
        "0")
          echo "$l"
          ;;
        "1")
          if expr "${l}" : "- " >/dev/null; then
            TAGS="${TAGS},$(echo "${l}"|cut -c3-|tr '[:upper:]' '[:lower:]')" 
          else
             echo "tags=$(echo "${TAGS}"|cut -c2-)"
             echo "$l"
             CATEGORIES=2
          fi
          ;;
        "2")
          echo "$l"
          ;;
        esac
      fi
    else # FIELDS
      echo "$l"
    fi # FIELDS
  done
) >"${OCTOPRESS_FILE}~"

mv "${OCTOPRESS_FILE}~" "${OCTOPRESS_FILE}"
