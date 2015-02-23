title=HP Laserjet Pro MFP M125nw
date=2015-02-23
type=post
tags=ubuntu
status=published
~~~~~~

Inbetriebnahme HP Laserjet Pro MFP M125nw unter Ubuntu-14.04
============================================================

Der oben genannte Drucker "wollte" zunächst einfach nicht.

So ging's dann:

* Über das Wartungs-Menü am Gerät: SmartInstall deaktivieren
    * Werkzeugschlüssel -> SetupMenü
    * Wartung
    * SmartInstall
    * Aus
* USB-Kabel trennen und neu einstecken
* HPLIP installieren: `sudo apt-get install --install-recommends hplip`
* Drucker einrichten mit: `sudo hp-setup`
    * Hierbei wird ein Plugin heruntergeladen und installiert

Danach funktioniert der Testseitendruck und auch das Scannen mit SimpleScan.
