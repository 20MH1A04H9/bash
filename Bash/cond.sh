#! /bin/bash
read -p "Enter the year : " year
if [ $year -eq 2024 ]
then 
    echo "Present"
else
    echo "Past"
fi