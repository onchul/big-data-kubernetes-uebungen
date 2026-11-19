# Den Pod löschen

**Aufgabe**

1. Löscht den Pod `web`.
2. Prüft, ob er ersetzt wird.

**Frage:** Falls er nicht ersetzt wird, warum eigentlich nicht?

<details><summary>Tipp</summary>

Das Gegenstück zum Erzeugen heißt `delete` und erwartet Objekttyp und Namen. Danach noch
einmal die Pod-Liste abrufen.

</details>

<details><summary>Lösung</summary>

```bash
kubectl delete pod web
```{{exec}}

```bash
kubectl get pods
```{{exec}}

`No resources found in default namespace.` Der Pod wird nicht ersetzt, weil niemand ihn
überwacht. Ein einzeln erzeugter Pod ist keine ausfallsichere Einheit, sondern nur ein
gestarteter Container.

</details>
