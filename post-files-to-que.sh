#!/bin/bash 
###################################################################
#Script Name   : post-files-to-que
#Description   : 
#Args          : 
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################


# post files to que
API_URL=$1
ENDPOINT=admin/push
JSON=$2

curl "${API_URL}"/"$ENDPOINT" -i -X POST -H 'Content-Type:application/json;charset=UTF-8' -d "$JSON"

exit 0
