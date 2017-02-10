type=post
author=Uli Heller
status=published
title=DisplayLink: Lenovo USB-Docking-Station
date=2017-02-09 17:00
comments=true
tags=ubuntu,trusty,xenial
~~~~~~

DisplayLink: Lenovo USB-Docking-Station
=======================================

Hier beschreibe ich die Inbetriebnahme der Lenovo USB-Docking-Station.
Es handelt sich um [dieses Modell](https://www.amazon.de/LENOVO-ThinkPad-Basic-inkl-Netzteil/dp/B00FTV4EIO/ref=sr_1_3?ie=UTF8&qid=1486656474&sr=8-3&keywords=lenovo+usb).

1. Basispakete installieren: `sudo apt-get install dkms`
2. Treiber herunterladen:
    * http://www.displaylink.com/
    * Download Drivers...
    * Ubuntu
    * [Version 1.2.65](http://www.displaylink.com/downloads/file?id=708)
3. Treiber installieren
    * `cd Downloads`
    * `unzip -d /tmp DisplayLink\ USB\ Graphics\ Software\ for\ Ubuntu\ 1.2.1.zip`
    * `chmod +x /tmp/displaylink-driver-1.2.65.run`
    * `sudo /tmp/displaylink-driver-1.2.65.run`
4. Danach: Alles anschließen, Bildschirm konfigurieren, Bildschirm erkennen, etc
