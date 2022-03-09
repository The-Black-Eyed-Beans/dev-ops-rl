#!bin/bash 

#create environment resources.
kubectl apply -f env/

#process and create bank.yaml
sed "s/{{IMAGE}}/$BANK_IMAGE/g" microservices/bank.yaml | kubectl apply -f -

#process and create user.yaml
sed "s/{{IMAGE}}/$USER_IMAGE/g" microservices/user.yaml | kubectl apply -f -

#process and create transaction.yaml
sed "s/{{IMAGE}}/$TRANSACTION_IMAGE/g" microservices/transaction.yaml | kubectl apply -f -

#process and create underwriter.yaml
sed "s/{{IMAGE}}/$UNDERWRITER_IMAGE/g" microservices/underwriter.yaml | kubectl apply -f -

#create backend service for microservices.
kubectl apply -f service/

#process and create gateway-configmap.yaml
sed "s/{{APP_SERVICE_HOST}}/$APP_SERVICE_HOST/g" gateway/gateway-configmap.yaml | kubectl apply -f -

#create gateway deployment and service.
kubectl apply -f gateway/gateway.yaml && kubectl apply -f gateway/gateway-service.yaml