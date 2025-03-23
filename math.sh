#! /bin/bash
if [ $# -eq 2 ]
then
    c=$(($1+$2))
    echo " The result is $c "
else
    echo "No output"
fi