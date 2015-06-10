title=Notebookdeckel mit Ubuntu-14.04
date=2015-06-10
type=post
tags=ubuntu,trusty
status=published
~~~~~~

Notebookdeckel mit Ubuntu-14.04
===============================

Ich habe einen alten EEEPC und verwende diesen als "Testserver".
Er ist permanent eingeschaltet und steht in einer Ecke. Problem:
Wenn ich den Deckel zuklappe, dann stoppt der Rechner.

Ziel: Der Rechner soll den Deckel einfach ignorieren und
weiterlaufen!

Mein Vorgehen habe ich [hier bei "askubuntu"](http://askubuntu.com/questions/15520/how-can-i-tell-ubuntu-to-do-nothing-when-i-close-my-laptop-lid) gefunden:

1. Editieren der Datei /etc/systemd/logind.conf:
    * Zu ersetzende Zeile: `#HandleLidSwitch=suspend`
    * Ersatz dafür: `HandleLidSwitch=ignore`

2. Neustart des Systemd-Daemons: `sudo restart systemd-logind`

3. Test: Läuft das Teil weiter beim Schließen des Deckels? Ja!

4. Reboot des Rechners und erneuter Test: Läuft das Teil weiter beim Schließen des Deckels? Ja!

Prima, war einfach!
