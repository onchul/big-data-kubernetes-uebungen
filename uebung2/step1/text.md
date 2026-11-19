# Ausgangszustand herstellen

In `/root/shop.yaml`{{copy}} liegt ein Manifest mit zwei Objekten: einem **Deployment** mit
drei Pods und einem **Service**, der sie unter einer festen Adresse erreichbar macht.

**Aufgabe**

1. Seht euch die Datei an.
2. Bringt sie ins Cluster und wartet, bis alle Pods bereit sind.
3. Verschafft euch einen Überblick: Deployment, Pods und Service in einer Ausgabe.
4. Prüft mit einer HTTP-Anfrage an `localhost:30080`, ob die Anwendung antwortet.

<details><summary>Tipp</summary>

Ein Manifest wird mit `apply` und der Option `-f` ans Cluster geschickt, auf das Fertigwerden
wartet `kubectl rollout status` mit dem Objekt `deployment/shop`.

Mehrere Objekttypen lassen sich in einem `get` durch Kommas trennen.

Für die HTTP-Anfrage genügt `curl localhost:30080`.

</details>

<details><summary>Lösung</summary>

```bash
cat /root/shop.yaml
```{{exec}}

```bash
kubectl apply -f /root/shop.yaml
kubectl rollout status deployment/shop
```{{exec}}

```bash
kubectl get deployment,pods,service
```{{exec}}

```bash
curl -s -m 2 -o /dev/null -w "HTTP %{http_code}\n" localhost:30080
```{{exec}}

Erwartet: drei Pods im Zustand `Running`, ein Service `shop` vom Typ `NodePort` auf Port
`30080` und `HTTP 200`.

</details>
