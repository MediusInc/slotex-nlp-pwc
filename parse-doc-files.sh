#!/bin/bash 
###################################################################
#Script Name   : parse-doc-files
#Description   : Prepare json form for post document on the API que
#Args          : file-path
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################


f=$1

# echo "Parsing Word docment $f"
document=$(antiword -f "$f")
content=$(echo "$document" | grep -v "^|" | grep -v "^-" | sed '/^$/d' | sed '/"/d' | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")
 
if [[ "$(echo "$document" | grep "ZADEVA" -A1 | cut -d "|" -f 2 | tail -n 1 | sed 's/ //g')" == "" ]]; then
    title=$(echo "$document" | grep "ZADEVA" -A1 | cut -d "|" -f 3 | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")
 
else
    title=$(echo "$document" | grep "ZADEVA" | cut -d "|" -f 3 | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")
fi

documentId=$(basename "$f" ".doc")
if [ "$LOG_LEVEL" == "debug" ]; then  
    echo "Document id: $documentId"
    echo "Title: $title"
    echo "Vsebina: $content"
fi

# construct json
json=$(./construct_json.sh "$documentId" "$title" "$content" "null")
echo "$json"



exit 0
