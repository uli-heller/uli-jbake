title=BTRFS: Verschieben in ein Subvolume
date=2016-02-10
type=post
tags=ubuntu,linux,trusty,btrfs
status=published
~~~~~~

BTRFS: Verschieben in ein Subvolume
===================================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty
und btrfs-tools-3.12-1ubuntu0.1.

Auf einem meiner Rechner habe ich die BTRFS-Subvolumes
ungeschickt angelegt:

* datalv: /data, kein Subvolume
* datalv: /data/lxc/var.lib.lxc/ubuntu1404-64/rootfs ... ist ein Subvolume

Besser gefällt mir:

* datalv: /data, subvolume=@

Hier die Wandlungskommandos:

```
btrfs subvolume snapshot /data /data/@
umount /data
# /etc/fstab editieren, subvol=@
mount /data
# /data untersuchen -> alle Daten sollten vorhanden sein!
# Ausnahme: Subvolumes wurden nicht kopiert!
```

Sonderbehandlung der Subvolumes:

```
mount /dev/.../datalv /mnt
cd /mnt
rmdir @/lxc/var.lib.lxc/ubuntu1404-64/rootfs
btrfs subvolume snapshot /mnt/lxc/var.lib.lxc/ubuntu1404-64/rootfs /mnt/@/lxc/var.lib.lxc/ubuntu1404-64/rootfs
btrfs subvolume delete /mnt/lxc/var.lib.lxc/ubuntu1404-64/rootfs
cd ..
umount /mnt
```

Löschen der Quelldaten:

```
mount /dev/.../datalv /mnt
cd /mnt
ls -a
# @ apt-cacher-ng lxc
rm -rf apt-cacher-ng lxc
cd /
umount /mnt
```
