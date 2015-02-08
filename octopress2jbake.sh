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
  -e "s/categories:\s*/tags=/"\
  -e "s/published:\s*true/status=published/"\
  -e '0,/^---.*/{//d;}' \
  -e '0,/^---.*/s//~~~~~~/' \
  -e 's/^\s*{% endcodeblock %}/```/' \
  -e 's/^\s*{% codeblock \(.*\) lang:\(.*\) %}/\1\n\n``` \2/' \
  "${OCTOPRESS_FILE}"
