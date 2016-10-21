title=SLES11SP4: Erzeugen einer VirtualBox mit Minimal-Installation
date=2016-09-27
type=post
tags=SLES
status=published
~~~~~~

SLES11SP4: Erzeugen einer VirtualBox mit Minimal-Installation
=======================================

Grob bin ich so vorgegangen:

1. Minimalinstallation in einer VirtualBox durchführen
    * /dev/sda1 - /boot
    * /dev/sda2 - /
2. Test: Kann man diese VirtualBox klonen?
    * Nein, es gibt Probleme beim Zugriff auf die Festplatten
    * Stichwort: DiskById
3. Korrektur mittels des Rettungssystems
    * Anpassen von /etc/fstab
        * diskById...Part1 -> /dev/sda1
        * diskById...Part2 -> /dev/sda2
    * Anpassen von /boot/menu.lst
        * diskById...Part1 -> /dev/sda1
4. Test: Kann man diese VirtualBox klonen?
    * Ja (getestet ohne Neuvergabe der MAC-Adressen)
