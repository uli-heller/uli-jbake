title=Ubuntu: Maus weg
date=2015-06-17
type=post
tags=ubuntu,linux,trusty
status=published
~~~~~~

Ubuntu: Maus weg
================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty
mit Cinnamon 2.4.8.

Bei einem meiner Desktop-Rechner kommt es immer mal wieder vor,
dass die Maus "weg" ist. Man sieht den Mauszeiger nicht, der
unsichtbare Mauszeiger funktioniert aber im Prinzip
perfekt.

Relativ zuverlässig bekomme ich den unsichtbaren Mauszeiger so hin:

* Rechner neu starten -> Anmeldeschirm ohne sichtbare Maus
* Am Anmeldeschirm: Maus nicht berühren, mit Tastatur anmelden -> Desktop ohne sichtbare Maus

Danach bleibt die Maus unsichtbar.

"Manchmal" wird die Maus auch im laufenden Betrieb unsichtbar
und bleibt verschwunden. Das ist dann richtig störend, weil dann
meistens viele Fenster offen sind und ich eigentlich arbeiten möchte.
Mir bleibt dann nur ein Reboot - eventuell reicht auch Ab- und Anmelden,
da kann ich dann aber auch gleich Durchstarten, dauert beides gleich lang.

Abhilfe hat dies gebracht:

```
gsettings get org.gnome.settings-daemon.plugins.cursor active
```

Bislang - nach 3 Tagen - habe ich keine verschwundene Maus mehr beobachtet.
I'm happy.
