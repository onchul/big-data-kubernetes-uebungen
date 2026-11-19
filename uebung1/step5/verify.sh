#!/bin/bash
# Bestanden, wenn das Deployment "web" drei bereite Pods hat.
READY=$(kubectl get deployment web -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ -n "$READY" ] && [ "$READY" -ge 3 ]
