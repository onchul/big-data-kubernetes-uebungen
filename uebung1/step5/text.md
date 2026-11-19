# Ein Deployment aus einem Manifest

Bisher habt ihr Befehle gegeben: „starte diesen Pod". Ein Manifest beschreibt stattdessen
einen **Soll-Zustand (desired state)**. Ein fertiges liegt in
`/root/web-deployment.yaml`{{copy}}

**Aufgabe**

1. Seht euch die Datei an. Welche Zeile legt fest, wie viele Pods laufen sollen?
2. Schickt das Manifest ans Cluster und wartet, bis alle Pods bereit sind.
3. Lasst euch anzeigen, welche Objekte dabei entstanden sind: Deployment, ReplicaSet und Pods.

**Fragen**

1. Angelegt habt ihr ein Deployment. Woher kommt das ReplicaSet?
2. Auf welchen Knoten liegen die drei Pods?

<details><summary>Tipp</summary>

Ein Manifest wird mit `apply` und der Option `-f` ans Cluster geschickt.

Auf das Fertigwerden wartet `kubectl rollout status` mit dem Objekt `deployment/web`.

Mehrere Objekttypen lassen sich in einem `get` durch Kommas trennen.

</details>

<details><summary>Lösung</summary>

```bash
cat /root/web-deployment.yaml
```{{exec}}

```bash
kubectl apply -f /root/web-deployment.yaml
kubectl rollout status deployment/web
```{{exec}}

```bash
kubectl get deployment,replicaset,pods -o wide
```{{exec}}

Entscheidend ist `replicas: 3`: es sollen drei Pods vorhanden sein. Das Deployment hat das
ReplicaSet erzeugt, das ReplicaSet die Pods. Beschrieben habt ihr nur das Ziel; die Kette
dahinter legt Kubernetes selbst an.

</details>

<details><summary>Zusatzaufgabe</summary>

Jeder der drei Pods wurde einzeln zugeordnet. Die Entscheidungen stehen im Ereignisprotokoll:

```bash
kubectl get events --field-selector reason=Scheduled
```{{exec}}

Und so sieht aus, was Kubernetes aus dem kurzen Manifest gemacht hat, mit allen
Standardwerten und dem aktuellen Status:

```bash
kubectl get deployment web -o yaml | head -n 40
```{{exec}}

</details>

> **Frage für die Pause:** Was geschieht, wenn ein Pod gelöscht wird, der zu diesem Deployment
> gehört? Merkt euch eure Vermutung, Block 2 beginnt damit.
