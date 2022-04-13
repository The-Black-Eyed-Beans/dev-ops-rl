#!/bin/bash

#Retrieve kubectl binary.
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl

#Apply execute permissions to binary.
chmod +x ./kubectl

#Copy kubectl binary to binary folder.
cp ./kubectl /bin/kubectl
