# Auf die Vorversion zurückrollen

Angenommen, die neue Version zeigt im Betrieb einen Fehler. Kubernetes führt zu jedem
Deployment eine Historie der Änderungen.

**Aufgabe**

1. Lasst euch diese Historie anzeigen.
2. Stellt die vorherige Version wieder her und wartet, bis der Vorgang abgeschlossen ist.
3. Prüft, welches Image danach läuft.

<details><summary>Tipp</summary>

Alle drei Teilaufgaben gehören zu `kubectl rollout`. Der Unterbefehl für die Historie heißt
wie die Sache, der zum Zurücknehmen ist das englische Wort für „rückgängig".

Das laufende Image steht im `describe` des Deployments in der Zeile `Image`.

</details>

<details><summary>Lösung</summary>

```bash
kubectl rollout history deployment/shop
```{{exec}}

```bash
kubectl rollout undo deployment/shop
kubectl rollout status deployment/shop
```{{exec}}

```bash
kubectl describe deployment shop | grep -i "image:"
```{{exec}}

Es läuft wieder `nginx:1.25-alpine`. Das Zurückrollen ist selbst ein Rolling Update und
erfolgt deshalb ebenfalls ohne Unterbrechung.

</details>

---

## Zusatzaufgabe: ein fehlerhaftes Deployment untersuchen

`/root/analytics.yaml`{{copy}} enthält zwei Fehler. Findet sie ohne die Datei zu öffnen, nur
mit `describe` und `logs`.

```bash
kubectl apply -f /root/analytics.yaml
kubectl get pods -l app=analytics
```{{exec}}

**Fehler 1:** Der Zustand des Pods und die Events sagen, was fehlt. Seht euch die Details
des Pods an.

<details><summary>Fehler 1: Lösung</summary>

```bash
kubectl describe pod -l app=analytics | tail -n 12
```{{exec}}

Zustand `ErrImagePull` bzw. `ImagePullBackOff`: Das Image `busybox:1.36-alpin` existiert
nicht, der Tag heißt `1.36`. Korrigieren, ohne die Datei zu bearbeiten:

```bash
kubectl set image deployment/analytics analytics=busybox:1.36
kubectl get pods -l app=analytics
```{{exec}}

</details>

**Fehler 2:** Der Container startet jetzt und beendet sich sofort wieder
(`CrashLoopBackOff`). `describe` zeigt nur, *dass* er abstürzt. Seht euch die Ausgabe des
Containers selbst an.

<details><summary>Fehler 2: Lösung</summary>

```bash
kubectl logs -l app=analytics --tail=5
```{{exec}}

Im Log steht `FEHLER: Umgebungsvariable DB_HOST ist nicht gesetzt`. Im Manifest heißt die
Variable `DB_HOSTT`.

```bash
kubectl set env deployment/analytics DB_HOST=postgres.intern
kubectl get pods -l app=analytics
kubectl logs -l app=analytics --tail=3
```{{exec}}

</details>

`describe` zeigt über die Events, **was** nicht funktioniert, `logs` zeigt über die Ausgabe
des Containers, **warum**.

<details><summary>Zusatzaufgabe: ein fehlerhaftes Update auf shop</summary>

```bash
kubectl set image deployment/shop web=nginx:gibtesnicht
kubectl rollout status deployment/shop --timeout=20s
kubectl get pods
curl -s -m 2 -o /dev/null -w "HTTP %{http_code}\n" localhost:30080
```{{exec}}

Der Rollout bleibt stehen, die alten Pods laufen weiter und die Anwendung antwortet weiter
mit `200`: Wegen `maxUnavailable: 0` wird kein alter Pod beendet, solange kein neuer bereit
ist. Danach zurückrollen:

```bash
kubectl rollout undo deployment/shop
kubectl rollout status deployment/shop
```{{exec}}

</details>
