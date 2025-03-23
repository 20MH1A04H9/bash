#! /bin/bash
read -p "what is your score? " result
if [ $result -ge 100 ]
then 
    echo "You are Expert"
elif [ $result -lt 100 ] && [ $result -gt 60 ]
then
    echo "Congrats!"
else
    echo "Sorry ! You Failed"
fi
