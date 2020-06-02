#!/bin/bash

# Choose one of these - must be run inside the cluster since ping won't work outside
pingName=(`kubectl get pods --all-namespaces -o wide | awk '{print $7}'`)   # All namespaces includes the namespace as a separate column
pingName=(`kubectl get pods --n $namespaceName -o wide | awk '{print $6}'`)

for i in ${pingName[@]:1};
  do
    ping -c 1 $i;
  done



## Curl instead ##
svcIP=(`kubectl get svc --all-namespaces -o wide | awk '{print $5}'`)

for i in ${svcIP[@]:1};
  do 
    if [ $i = '<none>' ]; then
      continue
    else
      echo "Attempting to curl $i"
      curl $i
    fi
  done
      
