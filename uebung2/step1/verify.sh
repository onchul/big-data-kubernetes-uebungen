#!/bin/bash
# Bestanden, wenn das Deployment "shop" drei bereite Pods hat und der Service existiert.
READY=$(kubectl get deployment shop -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ "$READY" = "3" ] || exit 1
kubectl get service shop >/dev/null 2>&1
