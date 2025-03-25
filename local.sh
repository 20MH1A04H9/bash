#!/bin/bash

name1="vishnu"
name2="vicky"

change(){
    local name1="viswanadh"
    echo "In function: $name1 , $name2"
    local name2="sai"
}
echo "Before function call : $name1, $name2"
change
echo "After function call : $name1, $name2"
