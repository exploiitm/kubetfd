#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <name>" >&2
	exit 1
fi

name=$1

docker build -t $name:latest .
docker image save $name > $name.tar
microk8s ctr image import $name.tar

microk8s.kubectl apply -f "deployment.yaml"
microk8s.kubectl apply -f "service.yaml"
microk8s.kubectl patch configmaps nginx-ingress-tcp-microk8s-conf --namespace ingress --patch-file "ingress.yaml"
microk8s.kubectl patch daemonsets.apps --namespace=ingress nginx-ingress-microk8s-controller --patch "$(cat "daemonset.yaml")"
microk8s.kubectl apply -f "hpa.yaml"
