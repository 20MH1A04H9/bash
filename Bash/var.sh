#!/bin/bash

echo "Script name is : $0 "
echo "My user name is : $USER "
echo "First argument is : $1"
echo "last argument is :${!#}"
echo "Print random number : $RANDOM "
echo "Process ID of the script is :$$"
echo "No of arguments is provided are : $# "
echo "Given arguments are : $@"