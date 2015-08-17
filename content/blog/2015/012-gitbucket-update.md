title=Gitbucket: Aktualisierung auf Version 3.4
date=2015-06-27
type=post
tags=gitbucket,git
status=published
~~~~~~

GITBUCKET: Aktualisierung auf Version 3.4
=========================================

Ausgangspunkt: 3.3 habe ich in Betrieb mit eigenen Patches, 3.4 würde ich
gerne verwenden. 

Remotes (`git remote`):

* origin ... mein Gitbucket-Fork
* upstream ... das Original

Zweige:

* 3.3 ... the original 3.3 version, pulled into my fork
* master ... 3.3 + my patches

Aufräumen
---------

Zuerst lösche ich alle erzeugten Dateien.

* `ant clean`
* `rm -rf target`

Version von Github holen
------------------------

* `git fetch upstream`

Dabei wird das neue Tag 3.4 angelegt.

Test der neuen Version
----------------------

* `git checkout -b 3.4 3.4`
* `./sbt.sh package` -> `java.lang.RuntimeException: Setting value cannot be null: ...`

Das kommt leider sehr häufig vor! Die getaggte Version "stimmt" fast nie!
