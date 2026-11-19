#!/bin/bash
# Bestanden, wenn wirklich ein Pod gelöscht wurde (Event "Killing") UND wieder drei bereit sind.
READY=$(kubectl get deployment shop -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ "$READY" = "3" ] || exit 1
kubectl get events --field-selector reason=Killing --no-headers 2>/dev/null | grep -q .
