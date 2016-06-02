title=GIT: Änderungen auf anderen Pfad anwenden
date=2016-06-02
type=post
tags=git
status=published
~~~~~~

GIT: Änderungen auf anderen Pfad anwenden
=========================================

Ausgangslage
------------

Ich habe ein Git-Projekt, in dem ich die Konfigurationsdateien
von diversen Rechnern verwalte. Im Verzeichnis "servers/wdropzone" liegen
die Konfigurationsdateien vom Rechner "wdropzone" und im Verzeichnis
"servers/dropzone" diejenigen vom Rechner "dropzone".

Jetzt habe ich Änderungen a "servers/wdropzone" gemacht und würde diese
gerne auf "servers/dropzone" anwenden.

Lösung
------

1. Ermitteln der gewünschten Änderungen

    * 3981530fc46 ... Help for dropzone
    * 7d1782125b9 ... dropzone: lowercase only

2. Erstellen der Patches

    * `git format-patch -1 3981530fc46`
    * `git format-patch -1 7d1782125b9`

3. Einspielen der Patches

    * `git am -p3 --directory='servers/dropzone/ <001-Help-for-dropzone.patch'
    * `git am -p3 --directory='servers/dropzone/ <001-dropzone-lowercase-only.patch'
