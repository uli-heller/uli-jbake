title=Ubuntu-Paketbauer mit LXC
date=2015-02-01
type=post
tags=LXC
status=published
~~~~~~

Ubuntu-Paketbauer mit LXC
=========================

Dieses Dokument bezieht sich auf Ubuntu-14.04. Es setzt voraus, dass LXC erfolgreich installiert wurde. Details stehen [hier](/blog/2015/002-lxc.html).

Vorbereitungen auf dem Host-System
----------------------------------

```
$ sudo lxc-clone -s ubuntu1404-64 ubuntu1404-64-build # Neuen Container erzeugen
Created container ubuntu1404-64-build as snapshot of ubuntu1404-64
$ sudo lxc-start -n ubuntu1404-64-build # Neuen Container starten
```

Vorbereitungen auf dem Container-System
---------------------------------------

### Paketquellen ergänzen um Quell-Repos

Zunächst müssen die Paketquellen um die Quell-Repos ergänzt werden:

```
/etc/apt# diff -u sources.list.orig sources.list
--- sources.list.orig	2015-02-01 08:29:55.953121432 +0100
+++ sources.list	2015-02-01 08:30:36.896119270 +0100
@@ -1,3 +1,6 @@
 deb http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse
+deb-src http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse
 deb http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
+deb-src http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
 deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
+deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
```

### Zusatzpakete installieren

Dann müssen jede Menge Zusatzpakete installiert werden:

```
sudo apt-get clean
sudo apt-get update
sudo apt-get install -y \
  build-essential fakeroot dpkg-dev devscripts \
  autotools-dev debhelper pkg-config \
  dh-autoreconf
sudo apt-get clean
```

### GPG-Schlüssel übertragen und importieren

Nun muß der GPG-Schlüssel für die Paketsignierung übertragen werden:

```
ssh {bisherigerPaketbauer} gpg --export-secret-keys\
|gpg --import
```

### Build-Verzeichnis anlegen

Build-Verzeichnis anlegen:

```
mkdir build
```

Durchführen eines Paketbaus
---------------------------

### Git

```
cd build
mkdir git
cd git
apt-get source git
sudo apt-get build-dep git
cd git-1.9.1
dpkg-buildpackage
```

... endet mit einer Warnung bzgl. der Paketsignierung!

```
cd build/git
scp {downloadServer}/git-2.2.2.tar.xz .
cd git-1.9.1
uupdate -u ../git-2.2.2.tar.xz
cd ../git-2.2.2
# Anpassungen an debian/changelog vornehmen
# Anpassungen an debian/diff/* vornehmen
dpkg-buildpackage
```

