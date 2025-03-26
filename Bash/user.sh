#!/bin/bash
read -p " enter the user name " usr
grep $usr /etc/passwd && echo " $usr is found " || echo " $usr is not found "
