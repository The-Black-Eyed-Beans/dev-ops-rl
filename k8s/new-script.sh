#!bin/bash

#ensure that script runs in directory that it inhabits.

# enable !! command completion for easier scripting.
set -o history -o histexpand

#exit when any command fails, and provide.
set -e

exit_on_error() {
    exit_code=$1
    last_command=${@:2}
    if [ $exit_code -ne 0 ]; then
        >&2 echo "\"${last_command}\" command failed with exit code ${exit_code}."
    fi
}

trap "exit_on_error $? !!" EXIT

#establish env vars in environment.
source .env

#inject env vars into cluster configuration, and apply.
envsubst < cluster.yaml | eskctl create cluster -f -


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