# Knoten des Clusters auflisten

Verschafft euch zuerst einen Überblick über das Cluster.

**Aufgabe**

1. Lasst euch die Knoten des Clusters anzeigen. Wie viele gibt es, und welche Rolle hat
   welcher? Die Rolle steht in der Spalte `ROLES`.
2. Haltet das Ergebnis fest: Schreibt den Namen des Knotens, der **nicht** die Control Plane
   ist, in die Datei `/root/knoten.txt`{{copy}}.

<details><summary>Tipp</summary>

Objekte auflisten geht mit dem Unterbefehl `get`, der gesuchte Objekttyp heißt `node`.

Eine Datei schreibt ihr mit der Shell, nicht mit `kubectl`: `echo text > datei`.

</details>

<details><summary>Lösung</summary>

```bash
kubectl get nodes
```{{exec}}

```bash
echo node01 > /root/knoten.txt
```{{exec}}

Zwei Knoten: `controlplane` mit der Rolle `control-plane` und `node01` ohne Rolleneintrag,
also ein Worker. Beide im Zustand `Ready`.

</details>

<details><summary>Zusatzfrage: Was läuft hier schon?</summary>

```bash
kubectl get pods -A
```{{exec}}

Im Namespace `kube-system` laufen die Bestandteile von Kubernetes selbst als Container:
API-Server, Scheduler, Controller Manager, etcd und das Netzwerk-Plugin.

</details>
