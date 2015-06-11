type=post
author=Uli Heller
status=published
title=OpenVPN unter Ubuntu nutzen
date=2013-05-14 06:00
updated=2013-05-16 20:00
comments=true
tags=linux,ubuntu,precise,openvpn
~~~~~~

Installation von OpenVPN
------------------------

*Listing: Installation von OpenVPN*

```
sudo apt-get install openvpn
```

Konfigurationsdateien von OpenVPN einspielen
---------------------------------------------

*Listing: Konfigurationsdateien von OpenVPN einspielen*

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

OpenVPN starten
---------------

*Listing: OpenVPN starten*

```
$ sudo openvpn ~/openvpn/uheller.ovpn
Enter Auth Username: uheller
Enter Auth Password: xxxx
```

VPN-Rechner nutzen
------------------

Das Hauptproblem ist nun die Namensauflösung.
Meine VPN-Gegenstelle nennt mir keinen NameServer, also
muß ich

* entweder immer via IP-Adresse "arbeiten"
* oder die Hosts selbst bei mir in /etc/hosts eintragen

Zunächst verfolge ich mal den ersten Ansatz:

* <https://10.157.1.20/owa> ... öffnet den Webmailer,
hier kann ich mich anmelden mit "uheller"/"xxxx".

SUPER!
