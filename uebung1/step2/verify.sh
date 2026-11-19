#!/bin/bash
# Bestanden, wenn der Pod "web" läuft.
kubectl get pod web -o jsonpath='{.status.phase}' 2>/dev/null | grep -q '^Running$'
