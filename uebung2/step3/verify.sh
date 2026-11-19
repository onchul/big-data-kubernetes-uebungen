#!/bin/bash
# Bestanden, wenn fünf Pods bereit sind.
READY=$(kubectl get deployment shop -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ "$READY" = "5" ]
