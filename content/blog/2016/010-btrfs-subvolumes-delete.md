title=BTRFS: Subvolumes löschen
date=2016-05-27
type=post
tags=ubuntu,linux,trusty,btrfs
status=published
~~~~~~

BTRFS: Subvolumes löschen
=========================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty
und btrfs-tools-3.12-1ubuntu0.1.

Aus einem meiner Rechner habe ich nach BTRFS-Tests viele Subvolumes.
Einfach löschen klappt nicht - ich bekomme diese Fehlermeldung:

```
root@ulinuc:/tmp# btrfs subvolume delete u2/u1/subvolume-test/x/y/z/x/y/z/ULI
Delete subvolume (no-commit): '/tmp/u2/u1/subvolume-test/x/y/z/x/y/z/ULI'
ERROR: cannot delete '/tmp/u2/u1/subvolume-test/x/y/z/x/y/z/ULI': Read-only file system
```

Gelöscht habe ich die Subvolumes dann so:

```
root@ulinuc:/tmp# btrfs subvolume list -p .|sort -r|sed "s/.* path //"|while read s; do btrfs property set -ts $s ro false; done
root@ulinuc:/tmp# btrfs subvolume list -p .|sort -r|sed "s/.* path //"|while read s; do btrfs subvolume delete $s; done
```
