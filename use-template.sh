#!/bin/bash
# Creates a new Docker Sandbox Template based on a dockerfile.
# Usage: ./use-template.sh <name>

# Change the ORG variable to suit your preferences!
ORG="me"

if [ "$1" == "" ]; then echo "Please provide the template name!"; exit 1; fi
DCF="configs/$1.dcr"
CR="\033[32m$\033[0m"
if ! [ -f $DCF ]; then echo "The dockerfile ${DCF} is not found!"; exit 1; fi
docker image rm ${ORG}/$1:v1
A="docker build -f ${DCF} -t ${ORG}/$1:v1 ."
B="docker image save ${ORG}/$1:v1 -o images/$1.tar"
C="sbx template load images/$1.tar"
echo -e "$CR $A" && `$A` && echo -e "$CR $B" && `$B` && echo -e "$CR $C" && `$C`\
echo "SUCCESS! Now you can go to a directory you want to create the sandbox for and run:" && \
echo -e "\033[32msbx run --template ${ORG}/$1:v1 claude .\033[0m"