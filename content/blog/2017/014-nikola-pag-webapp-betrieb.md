Nikola für PAG Webapp-Betrieb
=============================

Voraussetzungen
---------------

* Grundinstallation von Nikola in einem LXC-Container

Initialisierung
---------------

```
lxc-nikola
$ ~/nikola/bin/nikola init nikola-pag-webapp-betrieb-intern
Site title [My Nikola Site]: PAG-Webapp-Betrieb (interne Doku)
Site author [Nikola Tesla]: DP-Team, daemons point GmbH
Site author's e-mail [n.tesla@example.com]: doku@daemons-point.com
Site description [This is a demo site for Nikola.]: Dokumentation für den Webapp-Betrieb bei der PAG, nur für den internen Gebrauch bei der daemons point GmbH
Site URL [https://example.com/]: https://internal.daemons-point.com/pag-webapp-betrieb-intern/
Enable pretty URLs (/page/ instead of /page.html) that don't need web server configuration? [Y/n] Y
...
Language(s) to use [en]: de,en
...
Time zone [Etc/UTC]: Europe/Berlin
    Current time in Europe/Berlin: 08:48:20
Use this time zone? [Y/n] Y
Comment system: 
```

Versionierung
-------------

```
lxc-nikola
$ cd nikola-pag-webapp-betrieb-intern
nikola-pag-webapp-betrieb-intern$ git init .
nikola-pag-webapp-betrieb-intern$ touch \
  files/.delete.me \
  galleries/.delete.me \
  listings/.delete.me \
  pages/.delete.me \
  posts/.delete.me
nikola-pag-webapp-betrieb-intern$ git add *
nikola-pag-webapp-betrieb-intern$ git commit -m "Erste Version, (fast) direkt nach 'nikola init'"
nikola-pag-webapp-betrieb-intern$ cat >.gitignore <<EOF
.doit.db.db
__pycache__/
cache/
output/
EOF
nikola-pag-webapp-betrieb-intern$ git add .gitignore
nikola-pag-webapp-betrieb-intern$ git commit -m "Neue Datei: .gitignore"
nikola-pag-webapp-betrieb-intern$ git remote add origin https://uli@internal.daemons-point.com/gitbucket/git/dp/nikola-pag-webpp-betrieb-intern.git
nikola-pag-webapp-betrieb-intern$ git push -u origin master
```

Erster Artikel
--------------

```
lxc-nikola
nikola-pag-webapp-betrieb-intern$ ~/nikola/bin/nikola new_post posts/nikola.md
Creating New Post
-----------------

Title: Nikola
Scanning posts........done!
[2017-07-15T07:35:45Z] INFO: new_post: Your post's text is at: /home/ubuntu/nikola-pag-webapp-betrieb-intern/posts/nikola.md
nikola-pag-webapp-betrieb-intern$ git add posts/nikola.md
nikola-pag-webapp-betrieb-intern$ git rm posts/.delete.me
nikola-pag-webapp-betrieb-intern$ ~/nikola/bin/nikola build
nikola-pag-webapp-betrieb-intern$ ~/nikola/bin/nikola serve
# Sichten im Browser
nikola-pag-webapp-betrieb-intern$ git commit -m "Erster Artikel über Nikola" .
nikola-pag-webapp-betrieb-intern$ git push
```

