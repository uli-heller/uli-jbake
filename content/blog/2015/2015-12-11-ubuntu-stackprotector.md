title=Wily-Kernel unter Ubuntu 14.04
date=2015-12-11
type=post
tags=ubuntu
status=published
~~~~~~

Inbetriebnahme Wily-Kernel unter Ubuntu-14.04
==============================================

Bislang war es relativ einfach, die neuesten Kernel von
[kernel.ubuntu.com](http://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D)
unter Ubuntu-14.04 einuzuspielen. Seit Wily ist das leider nicht mehr
möglich, DKMS kann damit die Kernel-Module nicht mehr neu bauen:

```
...
make: Verzeichnis »/usr/src/linux-headers-4.3.2-040302-lowlatency« wird betreten
Makefile:659: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: -fstack-protector-strong not supported by compiler
...
```

Aktuell behelfe ich mir so (keine Ahnung, ob das ein "statthaftes" Vorgehen ist):

* Kernel einspielen
* Datei /usr/src/linux-headers-4.3.2-040302/Makefile editieren
    * Stelle: Bei STACKPROTECTOR_STRONG
    * Änderung: Hinten "_uli" dranhängen
    * So sieht die Zeile dann aus: `ifdef CONFIG_CC_STACKPROTECTOR_STRONG_uli`
* DKMS-Module neu bauen
    * `dkms status` -> keine Fehlermeldung (hoffentlich)
    * `dkms build -m spl -v 0.6.5.3 -k 4.3.2-040302-generic`
    * `dkms install -m spl -v 0.6.5.3 -k 4.3.2-040302-generic`
    * `dkms build -m zfs -v 0.6.5.3 -k 4.3.2-040302-generic`
    * `dkms install -m zfs -v 0.6.5.3 -k 4.3.2-040302-generic`
* Shutdown/Reboot
* VirtualBox neu bauen: `sudo /etc/init.d/vboxdrv setup`
* Alte Kernel-Version löschen: `sudo apt-get purge $(dpkg --get-selections "linux*4.3.1*")`
