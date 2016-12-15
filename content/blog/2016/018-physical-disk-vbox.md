title=VirtualBox: Installation von OpenSUSE auf eine physische Platte
date=2016-10-21
type=post
tags=VirtualBox
status=published
~~~~~~

VirtualBox: Installation von OpenSUSE auf eine physische Platte
=======================================

Grob bin ich so vorgegangen:

1. VirtualBox-5.1.8 installiert auf meinem Rechner
2. Ermitteln: Welche Platte soll verwendet werden? Bei mir: /dev/sdc
3. Zugriffsrechte für die Platte freischalten: `sudo chown uli.uli /dev/sdc`
4. Platte in VirtualBox verfügbar machen: `VBoxManage internalcommands createrawvmdk -filename ~/VirtualBox\ VMs/sdc.vmdk -rawdisk /dev/sdc`
5. VM erzeugen - "Vorhandene Festplatte verwenden" - sdc.vmdk

Links:

* [ServerWatch: Using a Physical Hard Drive with a VirtualBox VM](http://www.serverwatch.com/server-tutorials/using-a-physical-hard-drive-with-a-virtualbox-vm.html)
