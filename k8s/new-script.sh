#!/bin/bash

#ensure that script runs in directory that it inhabits.

# enable !! command completion for easier scripting.
set -o history -o histexpand

#exit when any command fails 
set -e
set -o pipefail


#establish env vars in environment.
source .env

#inject env vars into cluster configuration, and apply.
envsubst < cluster.yaml | eksctl create cluster -f -


#create environment resources. 
kubectl apply -f env/

#process and create microservices.
for FILE in microservices/* ; do 
    envsubst < "microservices/$FILE" | kubectl apply -f - 
done

#create backend service for microservices.
kubectl apply -f service/

#inject env vars into gateway-configmap and apply.
envsubst < gateway/gateway-configmap.yaml | kubectl apply -f -

#create gateway deployment and service.
kubectl apply -f gateway/gateway.yaml && kubectl apply -f gateway/gateway-service.yaml

