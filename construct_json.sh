#!/bin/bash 
###################################################################
#Script Name   : construct_json.sh
#Description   :
#Args          :
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################


# cunstruct json
DOCUMENT_ID=$1
DOCUMENT_TITLE=$2
DOCUMENT_CONTENT=$3
DOCUMENT_IMPORT_DATE=$4

JSON_STRING=$( jq -n \
                  --arg dI "$DOCUMENT_ID" \
                  --arg dT "$DOCUMENT_TITLE" \
                  --arg dC "$DOCUMENT_CONTENT" \
                  --arg dD "$DOCUMENT_IMPORT_DATE" \
                  '{documentId: $dI, title: $dT, insertDate: $dD, content: $dC, }')

echo "${JSON_STRING}"

exit 0
