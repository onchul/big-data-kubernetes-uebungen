#!/bin/bash
# Bestanden, wenn der Pod "web" nicht mehr existiert.
! kubectl get pod web >/dev/null 2>&1
