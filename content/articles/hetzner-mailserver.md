type=page
author=Uli Heller
status=published
title=Hetzner-Mailserver
date=2013-02-19 07:00
updated=2013-04-09 07:00
comments=false
~~~~~~

Aufsetzen des Hetzner-Mailservers
=================================

Grundinstallation und -konfiguration
------------------------------------

* Anmelden am Robot
* Ubuntu-12.04 64bit
* Anmelden via SSH: root/xxxxx
* Einspielen der SSH-Schlüssel
* Test: Klappt das Anmelden via SSH ohne Kennworteingabe? Ja!

Sichtung der APT-Schlüssel
--------------------------

Paket aktualisieren

``` sh
# apt-key list
/etc/apt/trusted.gpg
--------------------
pub   1024D/437D05B5 2004-09-12
uid                  Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
sub   2048g/79164387 2004-09-12

pub   1024D/FBB75451 2004-12-30
uid                  Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>

pub   4096R/C0B21F32 2012-05-11
uid                  Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>

pub   4096R/EFE21092 2012-05-11
uid                  Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>
```

Zusatzprogramme installieren und Systemaktualisierung
-----------------------------------------------------

Zunächst installiere ich einige Zusatzprogramme:

Zusatzprogramme installieren

``` sh
apt-get install joe
```

Dann eine Aktualisierung des Komplettsystems gefolgt von einem Neustart:

Systemaktualisierung

``` sh
apt-get update
apt-get dist-upgrade
reboot
```

Mailbenutzer anlegen
--------------------

Mailbenutzer anlegen

``` sh
useradd -m dpmail
id dpmail
 uid=1000(dpmail) gid=1000(dpmail) groups=1000(dpmail)
```

Exim installieren und konfigurieren
-----------------------------------

Exim installieren:

Exim installieren

``` sh
apt-get install exim4-daemon-heavy
```

Exim konfigurieren:

Exim konfigurieren

``` sh
dpkg-reconfigure exim4-config
```

Zur Durchführung der Konfiguration müssen einige Fragen beantwortet werden:

* General type of mail configuration:
  internet site; mail is sent and received directly using SMTP
* System mail name:
  daemons-point.com
* IP-addresses to listen on for incoming SMTP connections:
  *
* Other destinations for which mail is accepted:
  daemons-point.com,daspersonal.com
* Domains to relay mail for:
  LEER
* Machines to relay mail for:
  LEER
* Keep number of DNS-queries minimal (Dial-on-Demand)?
  No
* Delivery method for local mail:
  mbox format in /var/mail/
* Split configuration into small files?
  No

Danach:

Exim-Konfiguration abschliessen

``` sh
cp .../exim4.conf /etc/exim4/exim4.conf
chown -R Debian-exim.Debian-exim /var/log/exim4
```

NginX
-----

### Grundinstallation

NginX herunterladen und installieren

``` sh
cd /data/downloads
wget -c http://83.236.132.108/dprepo/ubuntu/12.04.64/debs/nginx_1.2.8-0dp01~precise1_all.deb
wget -c http://83.236.132.108/dprepo/ubuntu/12.04.64/debs/nginx-full_1.2.8-0dp01~precise1_amd64.deb
wget -c http://83.236.132.108/dprepo/ubuntu/12.04.64/debs/nginx-common_1.2.8-0dp01~precise1_all.deb
dpkg -i nginx_1.2.8-0dp01~precise1_all.deb nginx-common_1.2.8-0dp01~precise1_all.deb nginx-full_1.2.8-0dp01~precise1_amd64.deb
apt-get install -f
```

### NginX-Benutzer anlegen

NginX-Benutzer anlegen

``` sh
useradd -m -d /home/nginx nginx
id nginx
# uid=1002(nginx) gid=1002(nginx) groups=1002(nginx)
```

### Konfiguration

* `service nginx start`
* Browser: [http://daemons-point.com](http://daemons-point.com)
  -> zeigt die Begrüßung von NginX an
* `mkdir /srv/www`
* `chown nginx.nginx /srv/www`
* `mkdir /srv/www`
* `chown nginx.nginx /srv/www`
* `cp /usr/share/nginx/www/index.html /srv/www`
* `chown nginx.nginx /srv/www/index.html`
* SSH-Konfiguration für den Benutzer anpassen

VirtualBox
----------

### Grundinstallation

* Zusatzpakete installieren:
    * `apt-get install dkms` (... installiert recht viele Pakete)
* Download-Bereich anlegen: `mkdir -p /data/downloads`
* Runterladen: 
    * `cd /data/downloads`
    * `wget -c http://dlc.sun.com.edgesuite.net/virtualbox/4.2.10/virtualbox-4.2_4.2.10-84104~Ubuntu~precise_amd64.deb`
    * `wget -c http://dlc.sun.com.edgesuite.net/virtualbox/4.2.10/Oracle_VM_VirtualBox_Extension_Pack-4.2.10-84104.vbox-extpack`
* Installieren:
    * `dpkg -i virtualbox-4.2_4.2.10-84104~Ubuntu~precise_amd64.deb` (... scheitert mit vielen Fehlermeldungen)
    * `apt-get install -f` (... korrigiert die Fehler und installiert auch VirtualBox)
* Test:
    * `ssh -X root@hetzner-server`
    * `VirtualBox` -> GUI öffnet sich
* ExtPack installieren
    * `vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.2.10-84104.vbox-extpack`
* Host-Only-Interfaced anlegen
    * `vboxmanage hostonlyif create`
    * `vboxmanage list hostonlyifs`

### Apt-Cacher-NG

* `apt-get install apt-cacher-ng`
* Datei /etc/apt-cacher-ng/acng.conf anpassen
    * CacheDir: /data/apt-cacher-ng
* `mkdir /data/apt-cacher-ng`
* `chown apt-cacher-ng.apt-cacher-ng /data/apt-cacher-ng`
* `service apt-cacher-ng restart`

### VBox-Benutzer anlegen

VBox-Benutzer anlegen

``` sh
useradd -m -G vboxusers vboxuser
id vboxuser
# uid=1001(vboxuser) gid=1001(vboxuser) groups=1001(vboxuser),112(vboxusers)
mkdir /data/vboxuser
chown vboxuser.vboxuser /data/vboxuser
su - vboxuser
vboxmanage setproperty machinefolder /data/vboxuser
```

### VBoxTool

* VBoxTool herunterladen und installieren

  VBoxTool installieren

``` sh
  cd /data/downloads
  wget -c .../vboxtool_0.6-2dp01~precise1_all.deb
  dpkg -i vboxtool_0.6-2dp01~precise1_all.deb
```

  TODO: Hostonlyif erzeugen!

* VBoxTool konfigurieren - /etc/vboxtool/vbt.conf

        users=vboxuser

### Erste VM aktivieren

Import, Konfiguration und Start:

* `sudo -u vboxuser -s -H`
* `vboxmanage import .../Ubuntu-12.04-10.ova`
* `vboxmanage modifyvm Ubuntu-12.04-10 --vrde on --vrdeport 3389 --vrdeaddress localhost`
* `vboxmanage modifyvm Ubuntu-12.04-10 --memory 128`
* `vboxheadless -s Ubuntu-12.04-10`

Sichtung:

* `ssh -L3389:localhost:3389 daemons-point.com`
* `rdesktop localhost:3389` -> es erscheint die Konsole der VM

Dateilisten
-----------

Diese Dateien wurden geändert:

* /root/.ssh/authorized_keys
* /etc/apt/sources.list
* /etc/apt/sources.list.hetzner
* /etc/apt/sources.list.120464
* /etc/apt-cacher-ng/acng.conf
* /etc/exim4/exim4.conf
* /etc/exim4/blocked-recipients
* /etc/hosts
* /etc/hostname
* /etc/nginx/sites-available/dp
* /etc/nginx/sites-enabled/dp
* /etc/vboxtool/vbt.conf
* /home/dpmail/.ssh/authorized_keys
* /home/nginx/.ssh/authorized_keys
* /home/vboxuser/.ssh/authorized_keys
* /srv/www/index.html (... etc)

Probleme
--------

### Programmaktualisierung bricht ab: WARNING: The following packages cannot be authenticated!

Problem:

Programmaktualisierung reparieren

``` sh
apt-get install joe
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  joe
0 upgraded, 1 newly installed, 0 to remove and 3 not upgraded.
Need to get 481 kB of archives.
After this operation, 1,340 kB of additional disk space will be used.
WARNING: The following packages cannot be authenticated!
  joe
Install these packages without verification [y/N]? 
E: Some packages could not be authenticated
```

Korrektur:

Programmaktualisierung reparieren

``` sh
cd /etc/apt
cp sources.list sources.list.hetzner
cp ubuntu120464:/etc/apt/sources.list sources.list
apt-get update
apt-get install joe
```
