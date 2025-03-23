#! /bin/bash
read -p " enter the username : " usr
test=$(grep $usr /etc/passwd)
if [ -n "$test" ]
then
    echo "User Exists and his user id is $(id -u $usr | cut -d '=' -f 2)"
else
    echo "User does not exist"
fi
