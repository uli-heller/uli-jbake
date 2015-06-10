title=Git: Zertifikatsfehler bei HTTPS-Repositories
date=2015-06-11
type=post
tags=git
status=published
~~~~~~

Git: Zertifikatsfehler bei HTTPS-Repositories
=============================================

Wenn man ein Git-Repository auf einem Server mit einem selbst-signierten
Zertifikat speichert, dann bekommt man bei PUSH/PULL/FETCH oftmals
Fehlermeldungen dieser Art:

```
fatal: unable to access 'https://git.myserver.com/gitbucket/git/dp/dpserv.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none
```

Dabei wird der Befehl dann abgebrochen, sprich: Die Übertragung scheitert.

Mit `git config --global http.sslverify false` deaktiviert man die Überprüfung
der HTTPS-Zertifikate. Danach klappt der Zugriff.

Dies ist nur eine temporäre Lösung, "eigentlich" will man die Überprüfung
aktiv haben! Mit `git config --global http.sslverify true` aktiviert
man sie wieder.
