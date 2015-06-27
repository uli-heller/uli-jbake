title=Ubuntu: Alt-Tab - Wechseln zwischen Fenstern statt zwschen Applikationen
date=2015-06-18
type=post
tags=ubuntu,linux,vivid
status=draft
~~~~~~

Ubuntu: Alt-Tab - Wechseln zwischen Fenstern statt zwschen Applikationen
========================================================================

Dieser Artikel bezieht sich auf Ubuntu 15.04 - Vivid
mit Unity. FUNKTIONIERT NOCH NICHT!

sudo apt-get install compizconfig-settings-manager
sudo apt-get install compiz-plugins

ccsm

* Schreibtisch (Desktop)
* Ubuntu Unity Plugin
* Switcher

* Fensterverwaltung
* ...

```
sudo apt-get install dconf-tools
dconf reset -f /org/compiz/
setsid unity
unity --reset-icons
```
