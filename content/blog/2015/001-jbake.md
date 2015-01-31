title=JBake-Versuche
date=2015-01-31
type=post
tags=blog
status=published
~~~~~~

JBake
=====

Heute habe ich ein wenig mit [JBake](http://jbake.org) herumgespielt. Möglicherweise wird das als Ersatz für meine [Octopress](http://octopress.org)-Installation dienen.

[Grain](http://sysgears-com/grain) sieht optisch fast ein wenig besser aus, allerdings scheint es nicht ganz so verbreitet zu sein wie JBake.

Start
-----

* JBake-2.3.2 herunterladen und installieren
* Neues Verzeichnis anlegen: uli-jbake
* Reinwechseln
* `jbake -i groovy`
* `jbake`
* `jbake -s`
* <http://localhost:8820/> zeigt den Beispielinhalt an

Erster Artikel
--------------

* `cp content/blog/2013/second-post.md content/blog/2015/001-jbake.md`
* Editieren von "content/blog/2015/001-jbake.md"
* Speichern
* `jbake`
* `jbake -s`
* <http://localhost:8820/> zeigt den ersten Artikel an

Beispielartikel entfernen
-------------------------

* `git rm -f content/blog/2013`
* `jbake`
* `jbake -s`
* <http://localhost:8820/> zeigt nur noch den ersten Artikel an

Titel
-----

Als Titel im Browser-Fenster wird das Feld "title" der Metadaten des aktuellen Artikels angezeigt:

```
title=JBake-Versuche
...
```

![Browser](/images/browser-title.png)

Mini-Icon ersetzen
------------------

* dpicon.png kopieren nach ./assets/dpicon.png
* Editieren von templates/header.gsp: favicon.ico -> dpicon.png
* `convert assets/dpicon.png ./assets/favicon.ico`
* `jbake`
* `jbake -s`
* <http://localhost:8820/> ... Firefox zeigt nun das neue Bildchen an, Chrome bleibt beim alten!

Bestehende JBake-Sites
----------------------

* <http://clairtonluz.github.io/> - Quellen: <https://github.com/clairtonluz/tp_blog>
  Verwendet Groovy-Templates
* <http://www.crashub.org/> - Quellen: https://github.com/crashub/crashub.github.com/tree/site
  Sieht optisch sehr hübsch aus - fast so hübsch wie Grain
* <http://www.ybonnel.fr/index.html> - Quellen: <https://github.com/ybonnel/blog>
  Schlicht, aber "breit"
* <http://jdpgrailsdev.github.io/blog/index.html>
  Interessanter Inhalt
