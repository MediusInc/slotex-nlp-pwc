#!/bin/bash 
###################################################################
#Script Name   : parse-txt-files.sh
#Description   : Parse txt files and convert to json
#Args          : <txt-file-path>
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################


fin=$1
mkdir -p tmp
f=tmp/.converted-txt

# echo "Parsing txt docment ${fin}"
#detecting encoding, but does not work
# encoding=$(uchardet "$fin")
# iconv -f "$encoding" -t UTF-8 "${fin}" > "$f"

# change encoding from 1250 to UTF-(
iconv -f WINDOWS-1250 -t UTF-8 "$fin" > "$f"

document=$( < "$f" sed '/^\r/d' | sed '/^$/d' | sed '/"/d')
content_row=$(echo "$document" | grep -n "^>VSEBINA" | cut -d ":" -f 1)
content=$(echo "$document" | tail -n +"$content_row" | grep -v "^>" | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")

if [[ "$(echo "$document" | grep "^>ZADEVA" -A1 | tail -n 1 | sed 's/ //g' | grep "^>")" == "" ]]; then
    title=$(echo "$document" | grep "^>ZADEVA" -A1 | cut -d ":" -f 2 | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")
else
    title=$(echo "$document" | grep "^>ZADEVA" | cut -d ":" -f 2 | tr "\\n\\r" " " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed "s/  / /g")
# sed 's/\\r\\n/ /g'| sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
fi
 
documentId=$(basename "$fin" ".txt")
if [ "$LOG_LEVEL" == "debug" ]; then  
   echo "Document id: $documentId"
   echo "Title: $title"
   echo "Vsebina: $content"
fi

# remove tmp files
rm "$f"
# construct json
json=$(./construct_json.sh "$documentId" "$title" "$content" "null")
echo "$json"

exit 0
