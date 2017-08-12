#!/usr/bin/env bash

# This script takes example documents of each format, applies the appropriate
# transform and then diffs the output with an example of the opposing format.
# Thus, both documents should be canonically identical.

# It requires xsltproc[1] and xmldiffs[2] to be available on PATH.

# As with a standard diff, no output implies the documents are identical.

# [1] http://xmlsoft.org/XSLT/xsltproc2.html
# [2] https://github.com/joh/xmldiffs

TEST_PATH=`dirname $0`
xmldiffs <(xsltproc $TEST_PATH/../xsi_to_si.xsl $TEST_PATH/XSI.example.xml) $TEST_PATH/SI.example.xml
xmldiffs <(xsltproc $TEST_PATH/../si_to_xsi.xsl $TEST_PATH/SI.example.xml) $TEST_PATH/XSI.example.xml
