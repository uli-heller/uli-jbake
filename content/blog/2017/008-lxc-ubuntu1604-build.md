type=post
author=Uli Heller
status=published
title=LXC: Container für Paketerstellung
date=2017-03-03 10:00
comments=true
tags=lxc
~~~~~~

Startpunkt: Basiscontainer mit Ubuntu-16.04, 64 bit.

* Tools nachinstallieren
    * `sudo apt-get install build-essential devscripts`
    * `sudo apt-get clean`
* GPG-Schlüssel importieren
    * Benötigte Datei: uli.heller@daemons-point.com.private.laptop.gpg-key
    * `gpg --import uli.heller@daemons-point.com.private.laptop.gpg-key`
* Build-Verzeichnis anlegen und reinwechseln
    * `mkdir build`
    * `mkdir build/lxd`
    * `cd build/lxd`
* Source-Repos aktivieren in /etc/apt/sources.list
    ```
    deb http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse
    deb http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse
    deb http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
    deb-src http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse
    deb-src http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse
    deb-src http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
    ```
* Aktualisieren und Quelltexte einspielen
    * `sudo apt-get update`
    * `apt-get source lxd`
    * `sudo apt-get build-dep lxd`
