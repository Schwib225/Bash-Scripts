#!/bin/bash
# Must be run on a server with kubectl access

nodeList=(`kubectl get nodes`)
      # awk '{print $1 and $2 are what we are going for}'
      
#TODO: Create function that trims down the nodelist based on the awk output - we want to alert if there is a node in the NotReady state vs Ready
