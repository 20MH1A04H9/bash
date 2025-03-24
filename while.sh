#! /bin/bash -x
i=0
value=0
while [ $i -lt 10 ]
do
    for j in {1..5}
    do
        ((value++))
    done
    ((i++))
done
echo $value
