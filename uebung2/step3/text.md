# Auf fünf Replikate skalieren

Die Last steigt, drei Pods genügen nicht mehr. Geändert werden soll nur der Soll-Zustand,
nicht das Manifest.

**Aufgabe**

1. Erhöht die Zahl der Replikate von drei auf fünf und wartet, bis alle bereit sind.
2. Findet heraus, welche Pod-Adressen der Service gerade bedient.

**Fragen**

1. Wie viele Adressen stehen dort, und warum genau so viele?
2. Woran erkennt der Service, welche Pods zu ihm gehören?

<details><summary>Tipp</summary>

Für die Replikatzahl gibt es einen eigenen Unterbefehl, der genau das tut; er heißt wie die
Sache selbst.

Die Adressen hinter einem Service stehen in den **EndpointSlices**. Sie sind dem Service über
ein Label zugeordnet, nach dem sich filtern lässt: `-l kubernetes.io/service-name=shop`{{copy}}

Welche Labels ein Pod trägt, zeigt die Pod-Liste mit `--show-labels`.

</details>

<details><summary>Lösung</summary>

```bash
kubectl scale deployment shop --replicas=5
kubectl rollout status deployment/shop
```{{exec}}

```bash
kubectl get endpointslices -l kubernetes.io/service-name=shop
```{{exec}}

Fünf Adressen, eine je bereitem Pod. Die Zuordnung erfolgt über das **Label** `app=shop`,
nicht über Namen oder IP-Adressen. Ein Pod, der die Readiness-Probe nicht besteht, steht
nicht darin und bekommt keine Anfragen.

</details>

<details><summary>Zusatzaufgabe: einem Pod das Label entziehen</summary>

```bash
kubectl label pod $(kubectl get pods -l app=shop -o jsonpath='{.items[0].metadata.name}') app=egal --overwrite
kubectl get pods --show-labels
kubectl get endpointslices -l kubernetes.io/service-name=shop
```{{exec}}

Der Pod fällt aus dem Service heraus, und das Deployment erzeugt sofort einen neuen, weil
nun ein Pod mit `app=shop` fehlt. Der umbenannte Pod gehört zu nichts mehr und läuft weiter,
bis er gelöscht wird:

```bash
kubectl delete pod -l app=egal
```{{exec}}

</details>
