title=Neuer Kernel unter Ubuntu 12.04
date=2015-10-04
type=post
tags=ubuntu
status=published
~~~~~~

Inbetriebnahme neuer Kernel unter Ubuntu-12.04
==============================================

Bis Version 4.1.3 ist es recht einfach, einen neuen Kernel unter
Ubuntu 12.04 einzuspielen: Herunterladen von [kernel.ubuntu.com](http://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D)
und einfach einspielen mit `sudo dpkg -i ...`.

Leider funktioniert das mit neueren Versionen nicht mehr,
weil hier eine Abhängigkeit zum Paket "kmod" besteht und dieses
gibt es für Ubuntu-12.04 nicht.

In Ubuntu-12.04 sind die Pakete, die bei 14.04 im Paket "kmod" enthalten sind,
im Paket "module-init-tools".

Ich habe jetzt ein fast leeres Paket mit dem Namen "kmod" erzeut, welches lediglich eine
Abhängigkeit zu "module-init-tools" definiert. Wenn man dieses Paket installiert hat,
kann man danach auch problemlos die neuen Kernel installieren.

* [Github-Projekt](https://github.com/uli-heller/kmod)
* [Fertige Pakete](https://github.com/uli-heller/kmod/releases)
