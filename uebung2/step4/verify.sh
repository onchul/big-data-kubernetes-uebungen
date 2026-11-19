#!/bin/bash
# Bestanden, wenn das Deployment auf nginx:1.27-alpine läuft und alle Pods bereit sind.
IMAGE=$(kubectl get deployment shop -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
echo "$IMAGE" | grep -q '1.27' || exit 1
READY=$(kubectl get deployment shop -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
DESIRED=$(kubectl get deployment shop -o jsonpath='{.spec.replicas}' 2>/dev/null)
[ -n "$READY" ] && [ "$READY" = "$DESIRED" ]
