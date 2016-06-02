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
von diversen Rechnern verwalte. Im Verzeichnis "dropzone" liegen
die Konfigurationsdateien vom Rechner "dropzone" und im Verzeichnis
"wdropzone" diejenigen vom Rechner "wdropzone".

Jetzt habe ich Änderungen a "wdropzone" gemacht und würde diese
gerne auf "dropzone" anwenden.

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
