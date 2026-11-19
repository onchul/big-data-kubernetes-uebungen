#!/bin/bash
# Bestanden, wenn wieder die alte Version (nginx:1.25-alpine) läuft.
IMAGE=$(kubectl get deployment shop -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
echo "$IMAGE" | grep -q '1.25'
