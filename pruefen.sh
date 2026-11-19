#!/bin/bash
# Prüft beide Szenarien: JSON gültig, referenzierte Dateien vorhanden, verify-Skripte ok.
set -u
cd "$(dirname "$0")" || exit 1
fehler=0

for szenario in */; do
  [ -f "$szenario/index.json" ] || continue
  echo "== $szenario"

  if ! python3 -c "import json,sys; json.load(open('$szenario/index.json'))" 2>/dev/null; then
    echo "   FEHLER: index.json ist kein gültiges JSON"
    fehler=1
    continue
  fi

  # Killercoda sucht Assets in <szenario>/assets/, alle übrigen Dateien im Szenario-Ordner.
  while read -r pfad; do
    if [ -f "$szenario/$pfad" ]; then
      echo "   ok      $pfad"
    else
      echo "   FEHLT   $pfad"
      fehler=1
    fi
  done < <(python3 - "$szenario/index.json" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))["details"]
for teil in ("intro", "finish"):
    if teil in d:
        for schluessel in ("text", "foreground", "background"):
            if schluessel in d[teil]:
                print(d[teil][schluessel])
for schritt in d.get("steps", []):
    for schluessel in ("text", "verify", "foreground", "background"):
        if schluessel in schritt:
            print(schritt[schluessel])
for dateien in d.get("assets", {}).values():
    for a in dateien:
        if "*" not in a["file"]:
            print("assets/" + a["file"])
PY
)

  for skript in "$szenario"step*/verify.sh; do
    [ -f "$skript" ] || continue
    [ -x "$skript" ] || { echo "   FEHLER: $skript ist nicht ausführbar (chmod +x)"; fehler=1; }
    bash -n "$skript" || { echo "   FEHLER: Syntaxfehler in $skript"; fehler=1; }
  done
done

if [ "$fehler" -eq 0 ]; then
  echo "Alles in Ordnung."
else
  echo "Es gibt Probleme, siehe oben."
fi
exit "$fehler"
