#!/bin/bash

POD_NAME="logger-complete-cka04-arch"
NAMESPACE="default"
LOG_FILE="/root/logger-complete-cka04-arch"

# Get a list of containers in the pod
containers=$(kubectl get pod $POD_NAME -n $NAMESPACE -o=jsonpath='{.spec.containers[*].name}')

# Empty or create the log file
> $LOG_FILE

# Loop through the containers and append their logs to the file
for container in $containers; do
    echo "Logs from container: $container" >> $LOG_FILE
    kubectl logs $POD_NAME -n $NAMESPACE -c $container >> $LOG_FILE
done

echo "Logs saved to $LOG_FILE"
