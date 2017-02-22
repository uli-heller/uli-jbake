
title=Alte Kernels löschen
date=2016-03-15
type=post
tags=ubuntu
status=published
~~~~~~

Alte Kernels löschen
====================

Wenn ich meine Ubuntu-Installation regelmässig
aktualisiere, so sammeln sich im Laufe der Zeit
viele Kernels auf dem Rechner an, hier die Versionen
4.2.0-22, 4.2.0-30 und 4.2.0-34:

```
uli$ dpkg --get-selections linux-image*

linux-image-4.2.0-22-generic                   install
linux-image-4.2.0-30-generic                   install
linux-image-4.2.0-34-generic                   install
linux-image-extra-4.2.0-22-generic             install
linux-image-extra-4.2.0-30-generic             install
linux-image-extra-4.2.0-34-generic             install
linux-image-generic-lts-wily                   install

```

Die alten Kernel müssen nun manuell gelöscht werden. Dazu
muß man sich an diesen Ablauf halten:

1. Aktuell laufenden Kernel ermitteln: `uname -a`
   In diesem Beispiel ist der neueste "4.2.0-34-generic"
   und diesen müssen wir behalten!
2. Wenn es sich hierbei um einen älteren handelt, dann ist ein
   Neustart/Reboot erforderlich! Danach: Zurück zu 1.!
3. Kurztest: Funktioniert (noch) alles? Hier die Dinge, bei
   denen gelegentlich Fehler vorkommen:
    * VirtualBox
    * ZFS
    * LXC
4. Wenn Probleme bestehen: Zurück zum alten Kernel, neuen
   Kernel löschen!
5. Wenn keine Probleme bestehen: Alten Kernel löschen!

Wie löscht man nun einen Kernel? Zunächst muß man die
Versionsnummer des zu löschenden Kernels ermitteln. In meinem
Falle möchte ich die alten Versionen 4.2.0-22 und 4.2.0-30
löschen und die aktuelle Version 4.2.0-34 behalten:

```
V=4.2.0-22
dpkg --get-selections  "linux*-${V}" "linux*-${V}-*"|cut -f1
# Kontrolle: Vergleich -> die angegebene Kernel-Version muss
# identisch sein mit der Versionsnummer der nun angezeigten Pakete.
# Es dürfen auch nur linux-Pakete abgezeigt werden!
#   linux-headers-4.2.0-22
#   linux-headers-4.2.0-22-generic
#   linux-image-4.2.0-22-generic
#   linux-image-extra-4.2.0-22-generic

sudo apt-get purge $(dpkg --get-selections  "linux*-${V}" "linux*-${V}-*"|cut -f1)
# NOCHMALIGE Kontrolle: Vergleich -> die angegebene Kernel-Version muss
# identisch sein mit der Versionsnummer der nun angezeigten Pakete.
# Es dürfen auch nur linux-Pakete abgezeigt werden!
#   Die folgenden Pakete werden ENTFERNT:
#   linux-headers-4.2.0-22* linux-headers-4.2.0-22-generic*
#   linux-image-4.2.0-22-generic* linux-image-extra-4.2.0-22-generic*
# Falls OK: Weiter mit "Eingabetaste"
```

Danach das gleiche ausführen für die nächste/alte Kernel Version, in diesem Beispiel wäre es also dann:

```
V=4.2.0-30
dpkg --get-selections "linux*-${V}" "linux*-${V}-*"|cut -f1
# Kontrolle: Vergleich -> die angegebene Kernel-Version muss
...
```
