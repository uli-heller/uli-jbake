title=Migration von Octopress nach JBake
date=2015-06-09
type=post
tags=blog
status=draft
~~~~~~

Migration von Octopress nach JBake
==================================

Octopress-Links
---------------

Wir wollen die Octopress-Links möglichst beibehalten, damit Lesezeichen auch weiterhin funktionieren.
Im Einzelnen:

* Blog-Übersicht: http://uli-heller.github.io/blog/
* Archiv: http://uli-heller.github.io/archives/
* Blog-Artikel: http://uli-heller.github.io/blog/2014/02/23/git_kuerzen/
* Artikel: http://uli-heller.github.io/articles/lxc.html
* Über mich: http://uli-heller.github.io/about/
* Impressumg: http://uli-heller.github.io/impressum/

Blog-Übersicht
--------------

Die Blog-Übersicht wird bei Octopress angezeigt mit: <http://uli-heller.github.io/blog/>.
Bei JBake erfolgt dies mit: <http://..../index.html>.

Wir legen in JBake eine Umleitung von blog/index.html nach index.html:

```
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta http-equiv="refresh" content="0; url=../index.html" />
  </head>
</html>
```

Archiv
------

Die Blog-Übersicht wird bei Octopress angezeigt mit: <http://uli-heller.github.io/archives/>.
Bei JBake erfolgt dies mit: <http://..../archive.html>.

Wir legen in JBake eine Umleitung von archives/index.html nach archive.html:

```
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta http-equiv="refresh" content="0; url=../archive.html" />
  </head>
</html>
```

Blog-Artikel
------------

Auch wenn sowohl Octopress als auch JBake die Blog-Artikel in Markdown unterstützen, so kann
man diese dennoch nicht einfach umkopieren, weil:

* es Unterschiede bei den Metadaten gibt (... das ist der "Block" am Beginn der Datei)
* manche Octopress-Erweiterungen von JBake nicht unterstützt werden (bspw. `{% codeblock %}`)

Ich habe ein Skript erstellt, welches die Octopress-Konstrukte in Dinge
wandelt, mit denen JBake zurecht kommt.

Durchführen der Migration
-------------------------

```
find {path-to-octopress}/source_posts/ -type f\
|xargs -n1 ./migrate-octopress-blog-entry.sh
```

Offene Punkte
-------------

* Bilder: Anzeige im Blog OK, Anzeige in der Übersicht KO
* `{% include_code ...}`
