title=LXC: Host-only Netzwerk
date=2015-02-07
type=post
tags=ubuntu
status=draft
~~~~~~

LXC: Host-only Netzwerk
=======================

Manuelle Schritte
-----------------

1. Root: `sudo -s`
2. Brücke einrichten: `brctl addbr lxcbr1`
3. IP-Adresse vergeben: `ifconfig lxcbr1 10.2.2.1 netmask 255.255.255.0 up`
4. LXC-Container erzeugen: `lxc-clone -B btrfs ubuntu1404-64 host-only`
5. Externe LXC-Container-Konfiguration anpassen - /var/lib/lxc/host-only/config anpassen:
   `sed -i s/lxcbr0/lxcbr1/ /var/lib/lxc/host-only/config`
6. Interne LXC-Container-Konfiguration anpassen

    * /var/lib/lxc/host-only/rootfs/etc/network/interfaces

          < iface eth0 inet dhcp
          ---
          > iface eth0 inet static
          >     address 10.2.2.10/24
          >     gateway 10.2.2.1

    *  /var/lib/lxc/host-only/rootfs/etc/resolv.conf: Löschen
       
7. LXC-Container starten: `lxc-start -n host-only`
8. Tests
    * LXC-Container --ssh--> Host: Geht
    * Host --ssh--> LXC-Container: Geht
    * LXC-Container - Betriebssystem-Update: Geht, apt-caher-ng vom Host wird genutzt
    * LXC-Container -------> Internet: Geht nicht
