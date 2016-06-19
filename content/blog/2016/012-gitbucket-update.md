title=Gitbucket: Aktualisierung auf Version 4.1
date=2016-06-04
type=post
tags=gitbucket,git
status=published
~~~~~~

GITBUCKET: Aktualisierung auf Version 4.1
=========================================

Hier beschreibe ich, wie die Standard-Gitbucket-Version neu erzeugt
wird. Änderungen, die ich selbst in früheren Versionen eingebaut hatte,
bleiben erstmal außen vor.

Ausgangspunkt: 4.0 habe ich in Betrieb mit eigenen Patches, 4.1 würde ich
gerne verwenden.

Remotes (`git remote`):

* origin ... mein Gitbucket-Fork (uninteressant)
* upstream ... das Original

Java8
-----

Zunächst muß sichergestellt sein, dass Java8 verwendet wird:

```
gitbucket$ javac -version
javac 1.8.0_40
```

Aufräumen
---------

Zuerst lösche ich alle erzeugten Dateien.

* `./sbt.sh clean`
* `rm -rf target`
* `git clean -f -n` -> Ausgabe kontrollieren
* `git clean -f`

Version von Github holen
------------------------

* `git fetch upstream`

Dabei wird das neue Tag 4.1 angelegt.

Neue Version bauen
------------------

* `git checkout -b 4.1 4.1`
* `./sbt.sh package` -> `[success] Total time: 134 s, completed 04.06.2016 06:27:57`

Neue Version paketieren
-----------------------

```
$./sbt.sh executable
...
[info] built executable webapp /home/uli/git/forked/gitbucket/target/executable/gitbucket.war
[success] Total time: 6 s, completed 04.06.2016 06:30:02
```

Kurztest
--------

```
$ java -jar target/executable/gitbucket.war
...
Jun 04, 2016 6:31:40 AM grizzled.slf4j.Logger info
INFORMATION: The cycle class name from the config: ScalatraBootstrap
Jun 04, 2016 6:31:40 AM grizzled.slf4j.Logger info
INFORMATION: Initializing life cycle class: ScalatraBootstrap
2016-06-04 06:31:41.493:INFO:oejsh.ContextHandler:main: Started o.e.j.w.WebAppContext@1b4ae4e0{/,file:///home/uli/.gitbucket/tmp/webapp/,AVAILABLE}{file:/home/uli/git/forked/gitbucket/target/executable/gitbucket.war}
2016-06-04 06:31:41.504:INFO:oejs.ServerConnector:main: Started ServerConnector@75a118e6{HTTP/1.1,[http/1.1]}{0.0.0.0:8080}
2016-06-04 06:31:41.505:INFO:oejs.Server:main: Started @5277ms
```
