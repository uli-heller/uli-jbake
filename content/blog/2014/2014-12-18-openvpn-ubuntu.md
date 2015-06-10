type=post
author=Uli Heller
status=published
title=OpenVPN unter Ubuntu nutzen
date=2014-12-18 06:00
#updated=2014-12-18 20:00
comments=true
tags=linux,ubuntu,precise,openvpn
~~~~~~

Installation von OpenVPN
------------------------

Installation von OpenVPN

```
sudo apt-get install openvpn
```

Konfigurationsdateien von OpenVPN einspielen
---------------------------------------------

Konfigurationsdateien von OpenVPN einspielen

```
mkdir ~/openvpn
unzip -d ~/openvpn uheller.zip
```

Es werden Dateien wie diese abgelegt:

* openvpn/2E76.crt        
* openvpn/2E76.key        
* openvpn/ca.crt          
* openvpn/ta.key          
* openvpn/uheller.ovpn    

Konfigurationsdatei anpassen
----------------------------

Die Datei "openvpn/uheller.ovpn" enthält die OpenVPN-Konfiguration
für Windows. Unter Linux kann sie leider nicht direkt verwendet werden,
ein Start scheitert mit dieser Fehlermeldung:

Fehlermeldung beim OpenVPN-Start

```
uli:~/openvpn$ sudo openvpn ~/openvpn/uheller.ovpn
Options error: Unrecognized option or missing parameter(s) in /home/uli/openvpn/uheller.ovpn:25: register-dns (2.3.2)
Use --help for more information.
```

Die Zeile 25 muß auskommentiert werden durch Voranstellen einer Raute '#'.

Mit der vorgenannten Änderung kann OpenVPN gestartet werden, die
Namensauflösung DNS funktioniert aber nicht. Hierzu sind Ergänzungen
an der Konfigurationsdatei erforderlich:

Ergänzungen an uheller.ovpn

```
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf
```

OpenVPN starten
---------------

OpenVPN starten

```
$ sudo openvpn ~/openvpn/uheller.ovpn
Enter Auth Username: uheller
Enter Auth Password: xxxx
...
$ sudo route add  -net 10.157.0.0 netmask 255.255.0.0 gw 10.157.110.217
```
