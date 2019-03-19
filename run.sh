#!/bin/bash 
###################################################################
#Script Name   : run.sh
#Description   :
#Args          :
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################

set -e 
if [ -d tmp ]; then
  rm -rf tmp
fi

check_if_program_exist (){
  if ! [ -x "$(command -v "$1")" ]; then   
    printf "%si\\n" "Error: $1 is not installed. Please see requirements." >&2
    usage
    exit 1 
  fi 
}

usage () {
    echo "This script posts files on provided path to SloTex NLP backend"
    echo "server."  
    echo "The switch -p or --path "
    echo "    is reqired to enter where the .doc or .txt files are stored"
    echo "The switch -a or --api "
    echo "    argument si provided the files will be posted to privided api."
    echo "    (default: http:/localhost:8100)"
    echo ""
    echo "Example:"
    echo " ./run -p $(pwd)/test/data/ -a http:/slotex-nlp-core-api:port"
}

options=$(getopt -o ha:p: --long help,api:,path: -n 'parse-options' -- "$@")
if [ "$?" != "0" ]; then  
  echo "ERROR: Incorrect options provided"
  usage;
  exit 1
fi
eval set -- "$options"

API_URL=http://localhost:8100
FILES_PATH=false
while true; do
  case "$1" in
  -h | --help ) usage; shift; exit;;
  -a | --api ) API_URL="$2"; shift; shift ;;
  -p | --path ) FILES_PATH="$2"; shift; shift ;;
  -- ) shift; break;;
  *) usage; break;;
  esac
done

check_if_program_exist abiword
check_if_program_exist jq
check_if_program_exist curl
check_if_program_exist sed

if [ ! -d "$FILES_PATH" ]; then
  if [ ! -f "$FILES_PATH" ]; then
    echo "Please provide valid -p argument"
    usage
    exit 2
  fi
fi

# cluster documents in directory on doc and txt
./cluster-files-on-txt-and-doc.sh "$FILES_PATH"

# parse doc files
while read -r f; do
  json=$(./parse-doc-files.sh "$f")
  echo "$json" | jq
  ./post-files-to-que.sh "$API_URL" "$json"
done < tmp/.doc-files

# parse txt files
while read -r f; do
  json=$(./parse-txt-files.sh "$f")
  echo "$json" | jq
  ./post-files-to-que.sh "$API_URL" "$json"
done < tmp/.txt-files

rm -rf tmp

exit 0
