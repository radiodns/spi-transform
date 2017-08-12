#!/usr/bin/env bash

# This script takes example documents of one format, applies the transform and
# then diffs the output with an example of the then transformed format.

# Both examples should be examples of all common elements and attributes and,
# most importantly, be valid to ensure the transform operation is valid.

# xmllint is used with the --exc-c14n profile to ensure minor but unimportant
# differences, such as element or attribute order, or different but technically
# identical approaches to namespace declaration, are ignored

# It requires both xsltproc and xmllint to be available on PATH and should be
# run from the parent project directory.

# As with a standard diff, no output implies the documents are identical.

echo 'Diffing Example XSI-to-SI transform output against example SI'
diff <(xsltproc xsi_to_si.xsl test/XSI.example.xml | xmllint --format --exc-c14n -) <(xmllint --format --exc-c14n test/SI.example.xml)

echo 'Diffing Example SI-to-XSI transform output against example XSI'
diff <(xsltproc si_to_xsi.xsl test/SI.example.xml | xmllint --format --exc-c14n -) <(xmllint --format --exc-c14n test/XSI.example.xml)
