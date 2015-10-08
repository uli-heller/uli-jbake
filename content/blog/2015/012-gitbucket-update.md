title=Gitbucket: Aktualisierung auf Version 3.5
date=2015-08-17
type=post
tags=gitbucket,git
status=published
~~~~~~

GITBUCKET: Aktualisierung auf Version 3.5
=========================================

Ausgangspunkt: 3.4 habe ich in Betrieb mit eigenen Patches, 3.5 würde ich
gerne verwenden. 

Remotes (`git remote`):

* origin ... mein Gitbucket-Fork
* upstream ... das Original

Zweige:

* 3.4 ... the original 3.4 version, pulled into my fork
* master ... 3.4 + my patches

Aufräumen
---------

Zuerst lösche ich alle erzeugten Dateien.

* `./sbt.sh clean`
* `rm -rf target`

Version von Github holen
------------------------

* `git fetch upstream`

Dabei wird das neue Tag 3.5 angelegt.

Test der neuen Version
----------------------

* `git checkout -b 3.5 3.5`
* `./sbt.sh package` -> `[success] Total time: 128 s, completed 17.08.2015 06:35:26`

OK, das Bauen der Version 3.5 funktioniert. nun wieder aufräumen:

* `./sbt.sh clean`
* `rm -rf target`

Master umhängen auf 3.5
-----------------------

* `git checkout master`
* `git rebase 3.5`

Hierbei kommt es idR. zu vielen Konflikten, diese betreffen zumeist README.md.
Die Konflikte müssen gelöst werden und dann geht's weiter...

* `./sbt.sh package`
