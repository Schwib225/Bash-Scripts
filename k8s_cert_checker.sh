#!/bin/bash

# Generic script to check dates of k8s certs to see if any are expired. Need to add logic 

k8s_cert_dir=$(ls /etc/kubernetes/pki/*.crt)
etcd_cert_dir=$(/etc/etcd/pki/*.pem) 

for i in $k8s_cert_dir, $etcd_cert_dir;
do
echo $i 
openssl x509 -in $i -text | grep 'After'
done
