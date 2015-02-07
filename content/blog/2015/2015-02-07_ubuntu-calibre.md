title=Calibre: Version 2.19 unter Ubuntu-14.04
date=2015-02-03
type=post
tags=ubuntu
status=published
~~~~~~

Calibre: Version 2.19 unter Ubuntu-14.04
=========================================

Die Version 2.19 habe ich wie folgt unter Ubuntu-14.04 eingespielt:

1. "Clone" meines Basis-Ubuntu-LXC-Containers erstellen:
   `sudo lxc-clone -B btrfs ubuntu1404-64 calibre`
2. Neuen Container starten:
   `sudo lxc-start -n calibre`
3. Am neuen Container anmelden
4. Produkte nachinstallieren:
   `sudo apt-get install wget python xz-utils`
5. Installation durchführen:
   `sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda x:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/opt')".`
6. Nun ist Calibre-2.19 installiert unter "/opt/calibre"
7. Container beenden: `sudo poweroff`
8. Jetzt kann das Installationsverzeichnis auf das Hostsystem kopiert werden:
   `sudo cp -a .../calibre/rootfs/opt/calibre /opt`
9. Funktionstest: `/opt/calibre/calibre` -> sieht gut aus!

Links
-----

* Installationsbeschreibung: <http://calibre-ebook.com/download_linux>