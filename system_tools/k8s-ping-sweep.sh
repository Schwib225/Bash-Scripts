#!/bin/bash

pingName=(`kubectl get pods --all-namespaces -o wide | awk '{print $7}'`)   # All namespaces includes the namespace as a separate column
pingName=(`kubectl get pods --n $namespaceName -o wide | awk '{print $6}'`)

for i in ${pingName[@]:1};
  do
    ping -c 1 $i;
  done
