title=Derby: Editierbare Kommandozeile
date=2015-07-06
type=post
tags=derby
status=published
~~~~~~

Derby: Editierbare Kommandozeile
================================

Ich benutze häufig den Kommandozeilen-Modus "IJ" von Derby.
Damit kann ich schnell mal eine SQL-Abfrage losschicken, ohne
dass ich lange auf den Start warten muß - wie bspq. bei SqlDeveloper.

Problem: Zumindest unter Linux rächt sich jeder Vertipper.
Man kann die Kommandos schlecht editieren und auch die "vorigen" Befehle
nicht mittels Pfeil-hoch "zurückholen".

Abhilfe gibt's mit [jline](http://jline.sourceforge.net/):

* Herunterladen von [hier](http://mvnrepository.com/artifact/jline/jline/1.0)
  (Version 2.x funktioniert nicht)
* Ablegen in einem Verzeichnis
* Erstellen des Start-Skriptes "ij.sh"

Hier noch das Start-Skript "ij.sh":

```
#!/bin/sh
D="$(dirname "$0")"
DD="$(cd "${D}"; pwd)"
JLINE_JAR="$(ls "${D}/"jline*jar|sort|tail -1)"
DERBY_HOME=$(ls -d /opt/db-derby*|sort|tail -1)
exec java -classpath "${JLINE_JAR}:${DERBY_HOME}/lib/*" jline.ConsoleRunner org.apache.derby.tools.ij "$@"
```

Quelle: [db-derby/CommandHistoryInIj](http://wiki.apache.org/db-derby/CommandHistoryInIj)
