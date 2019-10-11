![SloTex NLP PWC Logo](https://slotex.si/images/slotex_logo_pwc.svg)

The Slotex NLP Post with Curl is a tiny bash program which allows to parse txt
and doc documents, construct appropriate json file and post the documents
content to the SloTex NLP core server. 

[![Build Status](https://travis-ci.org/MediusInc/slotex-nlp-web.svg?branch=master)](https://travis-ci.org/MediusInc/slotex-nlp-web)
[![License](https://img.shields.io/github/license/MediusINC/slotex-nlp-pwc)](https://github.com/MediusInc/slotex-nlp-pwc/blob/master/LICENSE.md)
[![Slack](https://img.shields.io/badge/slack-@pkp2019-yellow.svg?logo=slack)](https://join.slack.com/t/pkp2019-slotex/shared_invite/enQtNzkwNTk5MDMyOTc2LTNhOTQ0MTU3ZDMzMDM2NDRhYTRlNWRkOWRmZTk0N2YzNmExNDliYTU1NGI4NWFjNjFhNTFkNTcyNzhlZGIzZmU)

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

## Project Founding

|  <img alt="Public Scholarship, Development, Disability and Maintenence Fund of the Republic of Slovenia" src="https://slotex.si/images/logo-sklad.svg" height="65" /> |  <img alt="Ministry of Education, Science and Sport" src="https://slotex.si/images/logo-mizs.svg" height="65"/> |  <img alt="European Social Fund" src="https://slotex.si/images/logo-pkp.svg" height="65"/> |
| --- | --- | --- |

**This project was founded by Republic of Slovenia and European union from European social found.**

