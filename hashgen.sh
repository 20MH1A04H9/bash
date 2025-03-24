for word in $(cat password.txt)
do
  hash=$(echo -n $word | md5sum | cut -d " " -f 1)
  echo "The word is $word and the hash is $hash"
done