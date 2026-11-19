#!/bin/bash
# Bestanden, wenn der Pod läuft und in /root/entscheider.txt der Scheduler genannt ist.
kubectl get pod web >/dev/null 2>&1 || exit 1
[ -f /root/entscheider.txt ] || exit 1
grep -qi 'scheduler' /root/entscheider.txt
