title=Netzwerkänderung in Ubuntu-14.04
date=2015-02-17
type=post
tags=ubuntu
status=published
~~~~~~

Netzwerkänderung in Ubuntu-14.04
================================

Bislang war ich gewohnt, das Netzwerk "durchzustarten" nachdem
ich Änderungen an dessen Konfiguration vorgenommen habe, beispielsweise
weil ich von "DHCP" auf "statische Adresse" umgestellt habe:

```
uli:~$ sudo service networking restart
[sudo] password for uli: 
stop: Job failed while stopping
start: Job is already running: networking
uli:~$ 
```

Offenbar macht man das seit neuestem nun so:

```
uli:~$ sudo ipdown eth0
Internet Systems Consortium DHCP Client 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/08:00:27:c2:89:bf
Sending on   LPF/eth0/08:00:27:c2:89:bf
Sending on   Socket/fallback
DHCPRELEASE on eth0 to 10.0.2.2 port 67 (xid=0x4ff182a8)
uli:~$ sudo ipup eth0
Internet Systems Consortium DHCP Client 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/08:00:27:c2:89:bf
Sending on   LPF/eth0/08:00:27:c2:89:bf
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3 (xid=0x758401a4)
DHCPREQUEST of 10.0.2.15 on eth0 to 255.255.255.255 port 67 (xid=0x758401a4)
DHCPOFFER of 10.0.2.15 from 10.0.2.2
DHCPACK of 10.0.2.15 from 10.0.2.2
bound to 10.0.2.15 -- renewal in 42122 seconds.
```

Wenn man über die Netzwerk-Verbindung angemeldet ist, dann muß
man das Stoppen und Starten "in einem Aufwasch" machen:

```
uli:~$ sudo ifdown eth1; sudo ifup eth1
Internet Systems Consortium DHCP Client 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth1/08:00:27:b3:5d:c9
Sending on   LPF/eth1/08:00:27:b3:5d:c9
Sending on   Socket/fallback
DHCPRELEASE on eth1 to 192.168.56.100 port 67 (xid=0x12646162)
Internet Systems Consortium DHCP Client 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth1/08:00:27:b3:5d:c9
Sending on   LPF/eth1/08:00:27:b3:5d:c9
Sending on   Socket/fallback
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 3 (xid=0x1ff043aa)
DHCPREQUEST of 192.168.56.102 on eth1 to 255.255.255.255 port 67 (xid=0x1ff043aa)
DHCPOFFER of 192.168.56.102 from 192.168.56.100
DHCPACK of 192.168.56.102 from 192.168.56.100
bound to 192.168.56.102 -- renewal in 483 seconds.
```
