if [ "$#" -ne 4 ]; then
	echo "Usage: $0 <folder> <name> <xport> <cport>" >&2
	exit 1
fi

folder=$1
#challenge name
name=$2
# external port
xport=$3
# container port
cport=$4

mkdir -p $folder


sed "s/\$name/$name/g; s/\$cport/$cport/g; s/\$cport/$cport/g" '1. deployment.yaml' > $folder/deployment.yaml 

sed "s/\$name/$name/g; s/\$cport/$cport/g; s/\$xport/$xport/g" '2. service.yaml' > $folder/service.yaml

sed "s/\$name/$name/g; s/\$cport/$cport/g; s/\$xport/$xport/g" '3. ingress.yaml' > $folder/ingress.yaml

sed "s/\$name/$name/g; s/\$cport/$cport/g; s/\$xport/$xport/g" '4. daemonset.yaml' > $folder/daemonset.yaml

sed "s/\$name/$name/g; s/\$cport/$cport/g; s/\$xport/$xport/g" '5. hpa.yaml' > $folder/hpa.yaml

cp run.sh modify.sh $folder/
