title=Ubuntu: Screencast mit AVCONV
date=2016-06-18
type=post
tags=ubuntu, trusty
status=published
~~~~~~

Ubuntu: Screencast mit AVCONV
=============================

Ziel: Ich würde gerne meinen Bildschirm aufzeichnen und
als animiertes GIF bereitstellen.

* Aufzeichnung starten: `avconv -f x11grab -show_region 1 -r 25 -s 640x480 -i :0.0+100,200 -pix_fmt rgb24 recorded.gif`
    * -show_region 1: Zeichnet einen Rahmen um die aufzunehmende Region
    * -s 640x480: Größe der auzunehmenden Region
    * -i :0.0+100,200: Erster Bildschirm, 100 Pixel nach rechts, 200 Pixel nach unten
    * -pix_fmt rgb24: Notwendig, wenn Ausgabedateiname auf .gif endet
    * recorded.gif: Ausgabedateiname, legt auch das Aufnahmeformat fest
* Dateigröße reduzieren: `convert -layers Optimize recorded.gif optimized.gif`
    * recorded.gif: 86M
    * optimized.gif: 371K
