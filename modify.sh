#!/bin/bash
tag=1
name="got2win"
flag_id=10

echo "sseCTF{U_know_\$om3THinG_jon_\$N0w_$RANDOM}" > flag.txt
cat flag.txt
flag=$(cat flag.txt)

docker build -t $name .
docker save $name > $name.tar
microk8s ctr image import $name.tar

patch='{"spec":{"template":{"spec":{"containers":[{"name":"'$name'-challenge","image":"'$name':'$tag'"}]}}}}'

microk8s.kubectl patch deployment $name --patch $patch

curl \
    -X PATCH "http://13.126.197.34/api/v1/flags/$flag_id" \
    -H "Authorization: Token feb566432a58da3ac62227579b5d90e128efe527e7dc41f7e3add57e61149a50" \
    -H "Content-Type: application/json" \
    -d '{"content": "'$flag'", "id": "'$flag_id'"}'

