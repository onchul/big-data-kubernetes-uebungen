# Übung 2 abgeschlossen

- **Selbstheilung:** Der gelöschte Pod wurde ersetzt, ohne dass jemand ihn gestartet hat.
  Der Soll-Zustand gilt weiter und wird laufend abgeglichen.
- **Skalierung:** Geändert wurde eine Zahl, nicht die Anwendung. Der Service nimmt die neuen
  Pods über ihr Label auf.
- **Rolling Update:** Neue Version im laufenden Betrieb, in der Messung ausschließlich `200`.
- **Rollback:** ein Befehl zurück, auf demselben Weg.
- **Fehlersuche:** `describe` zeigt, *was* nicht funktioniert, `logs` zeigt, *warum*.

**Zum Selbststudium:**

- Deployments und Rolling Updates: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
- Services: https://kubernetes.io/docs/concepts/services-networking/service/
- Labels und Selektoren: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
- Fehlersuche an Anwendungen: https://kubernetes.io/docs/tasks/debug/debug-application/
