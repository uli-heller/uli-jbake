title=BTRFS: Verschieben von Subvolumes
date=2015-06-16
type=post
tags=ubuntu,linux,trusty,btrfs
status=published
~~~~~~

BTRFS: Verschieben von Subvolumes
=================================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty
und btrfs-tools-4.0.1.

Auf einem meiner Rechner habe ich die BTRFS-Subvolumes
ungeschickt angelegt:

* /sdb1: /data, subvolume=@
* /sdb1: /data/apt-cacher-ng, subvolume=@apt-cacher-ng
* /sdb1: /data/gitbucket, subvolume=@gitbucket
* /sdb1: /data/owncloud, subvolume=@owncloud
* /sdb1: /lxc, subvolume=@lxc

Alle diese Subvolumes sind via /etc/fstab eingebunden.

Besser gefällt mir dies:

* /sdb1: /data, subvolume=@
* /sdb1: /data/apt-cacher-ng, subvolume=apt-cacher-ng
* /sdb1: /data/gitbucket, subvolume=gitbucket
* /sdb1: /data/owncloud, subvolume=owncloud
* /sdb1: /data/lxc, subvolume=lxc

Es gibt diese Ansätze zur Korrektur:

* `mv @old-subvolume @/new-subvolume` ... bringt eine Fehlermeldung
* `btrfs subvolume snapshot @old-subvolume @/new-subvolume` ... funktioniert,
   danach altes Subvolume löschen

Konkret also:

```
mount /dev/sdb1 /mnt
btrfs subvolume snapshot /mnt/@apt-cacher-ng /mnt/@/apt-cacher-ng
btrfs subvolume delete /mnt/@apt-cacher-ng
...
```

Erzeugen der falschen Struktur
------------------------------

```
# root session
mkfs.btrfs -L btrfs-test -f /dev/sdc1
mount /dev/sdc1 /mnt
cd /mnt
btrfs subvolume create @
date >@/root.txt
mkdir root
mount /dev/sdc1 root -osubvol=@
for i in apt-cacher-ng gitbucket owncloud; do\
  btrfs subvolume create @$i;\
  date >@$i/$i.txt;\
  mkdir root/$i;\
  mount /dev/sdc1 root/$i -osubvol=@$i;\
done
```

Korrektur der Struktur
----------------------

Einfaches Umbenennen der Snapshots mittels `mv` funktioniert
nicht, ich erhalte eine Fehlermeldung.

```
# root session
cd /mnt
for i in apt-cacher-ng gitbucket owncloud; do\
  umount root/$i;\
  rmdir root/$i;\
  btrfs subvolume snapshot @$i root/$i;\
  btrfs subvolume delete @$i;\
done
```
