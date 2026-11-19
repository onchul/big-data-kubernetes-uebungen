# Einen Pod löschen

Dies ist die Frage aus dem Think-Pair-Share: Was geschieht, wenn ein Container ausfällt?

**Aufgabe**

1. Lasst euch die Pods anzeigen und merkt euch die Namen und die Spalte `AGE`.
2. Löscht einen der drei Pods.
3. Seht sofort danach noch einmal nach.

**Fragen**

1. Wie viele Pods laufen jetzt?
2. Was hat sich an den Namen und am Alter geändert?
3. Wer hat den neuen Pod gestartet?

<details><summary>Tipp</summary>

Gelöscht wird mit `delete`, dahinter der Objekttyp `pod` und der Name aus der Liste.

Wer den Vorgang live sehen will, hängt an das Auflisten der Pods die Option `--watch` an
(Abbruch mit Strg+C).

</details>

<details><summary>Lösung</summary>

```bash
kubectl get pods
```{{exec}}

```bash
kubectl delete pod $(kubectl get pods -l app=shop -o jsonpath='{.items[0].metadata.name}')
kubectl get pods
```{{exec}}

Es sind weiterhin drei Pods. Einer trägt einen neuen Namen und ist wenige Sekunden alt.
Im Deployment steht `replicas: 3`; dieser Soll-Zustand gilt weiter, und ein Controller
gleicht den Ist-Zustand laufend daran an.

</details>
