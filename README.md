# SloTex NLP PWC

The Slotex NLP Post with Curl is a tiny bash program which allows to parse txt
and doc documents, construct appropriate json file and post the documents
content to the SloTex NLP core server. 


## Requirements

* antiword (doc to txt)
* jq
* sed
* curl

## Usage

Please see help. 

```
./run.h -h

This script posts files on provided path to SloTex NLP backend
server.
The switch -p or --path 
    is reqired to enter where the .doc or .txt files are stored
The switch -a or --api 
    argument si provided the files will be posted to privided api.
    (default: http:/localhost:8100)

Example:
 ./run -p /home/usatko/projects/medius/pkp2019/slotex-nlp-pwc/test/data/ -a http:/slotex-nlp-core-api:port
```


