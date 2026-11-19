# Killercoda-Übungen Kubernetes

Zwei Browser-Übungen für den Vortrag zum Vertiefungsthema Kubernetes
(Big Data, FH Münster, 3. Dezember 2026).

| Ordner | Inhalt | Umgebung |
|---|---|---|
| `uebung1/` | Pod starten, Entscheidung des Schedulers finden, Deployment aus einem Manifest | `kubernetes-kubeadm-2nodes` |
| `uebung2/` | Selbstheilung, Skalierung, Rolling Update, Rollback, Fehlersuche | `kubernetes-kubeadm-1node` |

Beide Übungen sind unabhängig voneinander, Übung 2 legt ihren Ausgangszustand selbst an.

## Aufbau eines Szenarios

```
uebung1/
├── index.json      Titel, Schritte, Backend-Image, Assets
├── intro.md
├── step1/text.md   Aufgabentext
├── step1/verify.sh Prüfskript, Exit-Code 0 = bestanden
├── finish.md
└── assets/         Dateien, die in die Umgebung kopiert werden
```

Die Pfade unter `assets` in der `index.json` werden relativ zum Ordner `assets/` aufgelöst.

## Prüfen

```sh
./pruefen.sh
```

Prüft für beide Szenarien: gültiges JSON, alle referenzierten Dateien vorhanden,
`verify.sh` ausführbar und ohne Syntaxfehler.

## Veröffentlichen

Das Repo ist unter https://killercoda.com/creators im Profil verknüpft, jeder Push
aktualisiert die Szenarien.
