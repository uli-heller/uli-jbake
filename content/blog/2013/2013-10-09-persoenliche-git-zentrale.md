type=post
author=Uli Heller
status=published
title=Persönliche Git-Zentrale
date=2013-10-09 11:00
updated=2013-10-13 11:30
comments=true
tags=linux,ubuntu,precise,git
~~~~~~

Für ein Kundenprojekt brauche ich ein "zentrales" Git-Repository.
Hier die Randbedingungen:

* geringer Admin-Aufwand
* möglichst wenig Zusatzprogramme einsetzen (Ruby, Gitlab, ...)
* kein öffentlicher Zugriff

Umgesetzt habe ich das ganze mit einem SSH-Konto auf meinem Fileserver.

<!-- more -->

## Fileserver

### SSH-Konto

* Benutzer auf Fileserver ist vorhanden: "bert"
* SSH-Anmeldung funktioniert ohne Kennwort

### Git-Repository einrichten

{% codeblock %}
mkdir git
cd git
for p in base test server; do    mkdir $p.git;    ( cd "$p.git"; git --bare init ); done
```

## Arbeitsrechner

### Git-Repositories mit Fileserver verknüpfen

{% codeblock %}
cd git
for p in base test server; do (                               cd $p;                        git remote add fileserver bert@fileserver:git/base.git; );                            done
```

### Git-Repositories auf Fileserver übertragen

{% codeblock %}
cd git
for p in base test server; do (                               cd $p;                        git push fileserver master; );                            done
```

## Änderungen

### 2013-10-13

* Tippfehler korrigiert
