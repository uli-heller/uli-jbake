title=Emacs: Vertikale Halbierung vermeiden
date=2016-03-23
type=post
tags=ubuntu,emacs
status=published
~~~~~~

Emacs: Vertikale Halbierung vermeiden
=====================================

Nachdem ich mich jetzt ein paar Jahre lang quasi täglich über
das Emacs-Verhalten beim Öffnen von Dateien geärgert habe, habe
ich heute endlich nach einer Abhilfe gesucht.

Konkret geht es um die vertikale Halbierung.
Immer wenn ich eine Datei im Emacs editieren möchte
und dazu bspw diese Kommandozeile verwende:

* `emacs ~/.bashrc`

dann erscheint der Emacs im halbierten Modus:

* oben wird die zu editierende Datei angezeigt
* unten wird der Willkommen-Schirm angezeigt

Der halbierte Modus erscheint nicht mehr, wenn ich
die Datei ~/.emacs.d/init.el mit diesem Inhalt erzeuge:

```
(setq inhibit-startup-screen t)
```
