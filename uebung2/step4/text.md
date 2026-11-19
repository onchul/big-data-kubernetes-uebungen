# Neue Version ausrollen

Die Anwendung soll im laufenden Betrieb von `nginx:1.25-alpine` auf `nginx:1.27-alpine`
umgestellt werden. Damit sichtbar wird, ob dabei eine Anfrage verloren geht, läuft im
Hintergrund eine Messschleife mit: Sie fragt die Anwendung alle 0,2 Sekunden ab und
schreibt jeden HTTP-Statuscode mit.

**Messung starten:**

```bash
rm -f /root/fertig /root/codes.txt
( until [ -f /root/fertig ]; do curl -s -m 2 -o /dev/null -w "%{http_code}\n" localhost:30080; sleep 0.2; done > /root/codes.txt ) &
echo "Messung läuft"
```{{exec}}

**Aufgabe**

1. Stellt das Image des Containers `web` im Deployment `shop` um auf
   `web=nginx:1.27-alpine`{{copy}}
2. Wartet, bis der Rollout abgeschlossen ist.

<details><summary>Tipp</summary>

Einzelne Felder eines bestehenden Objekts ändert `kubectl set`. Für das Image gibt es den
Unterbefehl `set image`, dahinter das Objekt `deployment/shop` und dann
`container=abbild`.

Auf das Ende des Rollouts wartet derselbe Befehl wie beim Skalieren.

</details>

<details><summary>Lösung</summary>

```bash
kubectl set image deployment/shop web=nginx:1.27-alpine
kubectl rollout status deployment/shop
```{{exec}}

</details>

**Messung beenden und auswerten:**

```bash
touch /root/fertig; sleep 1
echo "--- Statuscodes während der Aktualisierung ---"
sort /root/codes.txt | uniq -c
```{{exec}}

**Das Ergebnis der Messung ist der Kern dieser Übung:** Wie viele Antworten waren `200`,
wie viele etwas anderes?

<details><summary>Was dabei geschehen ist</summary>

Kubernetes hat die Pods einzeln ausgetauscht: erst neue gestartet, gewartet, bis die
Readiness-Probe sie als bereit meldet, und erst dann alte beendet. Im Manifest steht
`maxUnavailable: 0`, es darf also zu keinem Zeitpunkt ein Pod fehlen:

```bash
kubectl describe deployment shop | grep -A 3 RollingUpdateStrategy
```{{exec}}

Ein beendeter Pod wird zuerst aus dem Service genommen und erst fünf Sekunden später
gestoppt (`preStop`), damit bereits laufende Anfragen noch beantwortet werden. Deshalb
stehen in der Messung ausschließlich `200`. Ein `000` wäre eine abgebrochene Verbindung.

</details>
