#!/bin/bash

echo "Script name is : $0 "
echo "My user name is : $USER "
echo "First argument is : $1"
echo "Last argument is : ${!#}"
echo "Print random number : $RANDOM "
echo "Process ID of the script is : $$"
echo "Number of arguments provided are : $# "
echo "List of all arguments : $@"