title=Ubuntu: Root-Partition nach LVM verschieben
date=2015-06-28
type=post
tags=ubuntu, precise
status=published
~~~~~~

Ubuntu: Root-Partition nach LVM verschieben
===========================================

Dieser Artikel bezieht sich auf Ubuntu-12.04 (Precise).
Er sollte auch mit neueren Ubuntu-Versionen funktionieren.

Auf einem meiner Rechner ist die Root-Partition zu klein geworden.
Sie hat 500MB, jeder Kernel hat grob 200 MB an Modulen, also ist
sie zu klein um 2 Kernel-Versionen zu halten.

Idee: Wir richten eine LVM-Partition ein und verschieben die Root-Partition
dort hin. Wenn künftig der Platz dann mal zu klein ist, können wir die
Partition relativ einfach vergrößern.

## LVM-Volume anlegen

```
lvcreate -L 1G -n rootlv ssdvg
mkfs.ext4 /dev/ssdvg/rootlv
```

## LVM-Volume einbinden

```
mount /dev/ssdvg/rootlv /mnt
```

## Root-Partition kopieren

```
rsync -ravzx / /mnt/
```

## Chroot vorbereiten

```
cd /mnt
mount --bind /sys /mnt/sys
mount --bind /proc /mnt/proc
mount --bind /run /mnt/run
mount --bind /dev /mnt/dev
```

## Chroot starten

```
chroot /mnt # Fehlermeldung bzgl groups
mount -a
exit
chroot /mnt # keine Fehlermeldung
```

## /etc/fstab innerhalb Chroot anpassen

``` diff
# / was on /dev/sdb2 during installation
#UUID=9ac57b97-4b2c-4d79-8169-81e5e8df060f /               ext4    errors=remount-ro 0       1
/dev/mapper/ssdvg-rootlv /             ext4    errors=remount-ro        0 1
```

## Boot-Loader innerhalb Chroot neu einrichten

```
grub-install /dev/sde
update-grub2
reboot
```

