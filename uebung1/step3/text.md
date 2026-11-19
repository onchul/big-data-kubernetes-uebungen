# Die Entscheidung des Schedulers finden

Der Zielknoten wurde nicht angegeben, trotzdem liegt der Pod auf einem bestimmten Knoten.
Die Entscheidung ist im Ereignisprotokoll des Pods festgehalten.

**Aufgabe**

1. Lasst euch die Details des Pods `web` ausgeben und sucht darin die Zeile, die mit
   `Successfully assigned` beginnt. Die Spalte `From` nennt die Komponente, die sie
   geschrieben hat.
2. Schreibt den Namen dieser Komponente in die Datei `/root/entscheider.txt`{{copy}}

<details><summary>Tipp</summary>

Details samt Ereignisprotokoll zeigt der Unterbefehl `describe`. Die Events stehen am Ende
der Ausgabe.

</details>

<details><summary>Lösung</summary>

```bash
kubectl describe pod web | tail -n 12
```{{exec}}

```bash
echo default-scheduler > /root/entscheider.txt
```{{exec}}

Die Zuordnung trifft also der **Scheduler**, eine Komponente der Control Plane. Niemand hat
ihm gesagt, welchen Knoten er nehmen soll; er sucht ihn selbst aus.

</details>

<details><summary>Wie sucht der Scheduler aus?</summary>

In zwei Schritten:

1. **Filtern:** Alle Knoten aussortieren, die nicht in Frage kommen, zum Beispiel weil zu
   wenig CPU oder Arbeitsspeicher frei ist.
2. **Bewerten:** Unter den übrig gebliebenen Knoten den am besten geeigneten auswählen,
   etwa den mit der geringsten Auslastung.

</details>

<details><summary>Warum landet der Pod nie auf controlplane?</summary>

Weil der Knoten `controlplane` für gewöhnliche Anwendungen gesperrt ist. Die Sperre ist eine
Markierung am Knoten und heißt **Taint**:

```bash
kubectl describe node controlplane | grep -i -A2 taints
```{{exec}}

In der Ausgabe steht `node-role.kubernetes.io/control-plane:NoSchedule`. Links steht der
Grund der Markierung, rechts ihre Wirkung: `NoSchedule` heißt „hier keine neuen Pods
einplanen".

Der Scheduler sortiert diesen Knoten deshalb schon beim Filtern aus, und von den zwei Knoten
bleibt nur `node01` übrig. Der Sinn dahinter: Die Control Plane steuert das gesamte Cluster
und soll nicht durch Anwendungslast ausgebremst werden.

</details>
