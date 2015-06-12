title=Ubuntu-Server: Nameserver
date=2015-06-12
type=post
tags=ubuntu,linux,trusty
status=published
~~~~~~

Ubuntu-Server: Nameserver
=========================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty.

Eben ist mir aufgefallen, dass bei meinem Ubuntu-Server
die Aktualisierung scheitert, weil die Hostnamen
nicht aufgelöst werden können:

```
# ping de.archive.ubuntu.com
ping: unknown host de.archive.ubuntu.com
```

Abhilfe: Erweitern von /etc/networking/interfaces
und Durchstarten des Netzwerkes.

*Listing: /etc/network/interfaces*

``` diff
diff --git a/etc/network/interfaces b/etc/network/interfaces
index 76bd7c1..ee7aa16 100644
--- /etc/network/interfaces
+++ /etc/network/interfaces
 network 1.2.3.0
 broadcast 1.2.3.255
 gateway 1.2.3.105
+dns-nameservers 8.8.8.8 8.8.4.4
```

*Shell: Durchstarten des Netzwerkes*

```
sudo ifdown eth0 && sudo ifup eth0
```
