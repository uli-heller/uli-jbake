HPLIP für Xenial
================

* Kompression aufheben für
    * ./data/ldl
    * ./data/pcl
    * ./data/ps
    * ./fax/ppd
    * ./ppd/hpcups
    * ./prnt/ps
  Kommando: `for d in data/ldl data/pcl data/ps fax/ppd ppd/hpcups prnt/ps; do ls -1 $d/*gz; done|xargs -n1 gzip -d`
* Neu verpacken: `tar cf - ./hplip-3.17.6+uli|xz -c9 >hplip-3.17.6+uli.tar.xz`
* Neu bauen: 
    * `uupdate -u ../hplip-3.17.6+uli.tar.xz -v 3.17.6`
    * `dpkg-buildpackage` -> Fehlermeldung
    * `dpkg-source --commit`
    * `dpkg-buildpackage` -> läuft durch
