#!/bin/bash
# Bestanden, wenn in /root/knoten.txt ein existierender Knoten steht,
# der nicht die Control Plane ist.
[ "$(kubectl get nodes --no-headers 2>/dev/null | grep -c ' Ready ')" -ge 2 ] || exit 1
[ -f /root/knoten.txt ] || exit 1
ANTWORT=$(tr -d '[:space:]' < /root/knoten.txt)
[ -n "$ANTWORT" ] || exit 1
kubectl get node "$ANTWORT" >/dev/null 2>&1 || exit 1
! kubectl get node "$ANTWORT" -o jsonpath='{.metadata.labels}' 2>/dev/null \
  | grep -q 'node-role.kubernetes.io/control-plane'
