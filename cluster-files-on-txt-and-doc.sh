#!/bin/bash 
###################################################################
#Script Name   : cluster-files-on-txt-and-doc.sh 
#Description   : Cluster files on doc and on txt files 
#Args          : <input-dir>
#Author        : Tadej Justin
#Email         : tadej.justin@medius.si
###################################################################


LOCATION=$1

echo "Clusteing documents on doc and txt"

mkdir -p tmp
touch tmp/.doc-files
touch tmp/.txt-files
for f in "$LOCATION"*; do
    if file "$f" | grep -q "Word"; then
        echo "$f" >> tmp/.doc-files
    elif file "$f" | grep -q ""; then
        echo "$f" >> tmp/.txt-files
    fi
done

exit 0
