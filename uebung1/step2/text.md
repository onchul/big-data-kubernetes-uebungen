# Einen Pod starten

Ein **Pod** ist die kleinste Einheit, die Kubernetes verwaltet: ein oder mehrere Container,
die gemeinsam auf einem Knoten ausgeführt werden.

**Aufgabe**

1. Startet einen einzelnen Pod mit dem Namen `web` aus dem Image
   `nginx:1.25-alpine`{{copy}}
2. Lasst euch anzeigen, auf welchem Knoten er ausgeführt wird.

Steht beim Nachsehen noch `ContainerCreating`, wird gerade das Image geladen. Dann den
Befehl wiederholen.

**Frage:** An welcher Stelle habt ihr angegeben, auf welchem Knoten der Pod laufen soll?

<details><summary>Tipp</summary>

Für einen einzelnen Pod gibt es einen eigenen, imperativen Befehl. Das Image wird über die
Option `--image` angegeben.

Den Zielknoten zeigt die Pod-Liste nur in der ausführlichen Ausgabe, also mit `-o wide`.

</details>

<details><summary>Lösung</summary>

```bash
kubectl run web --image=nginx:1.25-alpine
```{{exec}}

```bash
kubectl get pods -o wide
```{{exec}}

Der Knoten steht in der Spalte `NODE`. Angegeben habt ihr ihn nirgends. Wer die Entscheidung
getroffen hat, klärt der nächste Schritt.

</details>
