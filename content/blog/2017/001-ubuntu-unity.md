title=Unity 7 unter Ubuntu-16.04
date=2017-01-17
type=post
tags=ubuntu
status=published
~~~~~~

Unity 7 unter Ubuntu-16.04
==========================

Installieren
------------

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ubuntu-desktop
# Zusatztools zur erweiterten Konfiguration
sudo apt-get install compizconfig-settings-manager 
sudo apt-get install compiz-plugins
```

Aktivieren
----------

TBD

Konfigurieren
-------------

### Log Graphics Mode

Datei: "~/.config/upstart/lowgfx.conf"

```
start on starting unity7
pre-start script
    initctl set-env -g UNITY_LOW_GFX_MODE=1
end script
```

Danach dann ab- und wieder neu anmelden. Die Grafikeffekte
sind nun abgestellt und alles ist viel schneller.

### Arbeitsflächen

* Systemeinstellungen
* Darstellung
* Verhalten
* Arbeitsflächen aktivieren: Ja
* Symbol zum Anzeigen des Schreibtisches: Ja
* Sichtbarkeit der Menüs: Immer
* `ccsm`
* Schreibtisch
* Viewport Switcher: Ja
* Viewport Switcher konfigurieren
    * Go to specific viewport
    * Switch fo viewport 1: Ctrl F1
    * Switch fo viewport 2: Ctrl F2
    * Switch fo viewport 3: Ctrl F3
    * Switch fo viewport 4: Ctrl F4

### Alt-Tab zwischen Fenstern

* `ccsm`
* Ubuntu Unity Plugin aktivieren: Ja
* Ubuntu Unity Plugin konfigurieren
    * Switcher: Alles deaktiviert
    * zurück
* Fensterverwaltung
    * Anwendungsumschalter: Nein
    * Static Application Switcher: Ja
* Static Application Switcher konfigurieren
    * Tasten Nächstes Fenster: Alt Tab
    * Tasten Voriges Fenster: Shift Alt Tab

Links
-----

* [Low Graphics Mode in Unity 7](https://insights.ubuntu.com/2016/09/19/low-graphics-mode-in-unity-7/)
