#!/usr/bin/bash
read -p  " Enter the hash value: " hash
echo "The hash value is: $hash"
echo "The hash value is: $(echo -n $hash | md5sum | cut -d ' ' -f 1)"