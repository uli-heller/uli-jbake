title=BTRFS: Dateisystem voll
date=2016-07-20
type=post
tags=ubuntu,linux,trusty,btrfs
status=published
~~~~~~

BTRFS: Dateisystem voll
=======================

Heute hat's mich nun auch erwischt: BTRFS meldet, dass meine
Home-Partition voll ist, obwohl da laut `df` eigentlich noch
Platz sein müßte:

```
# df -h /home
/dev/mapper/systemvg-homelv  100G     73G   27G   74% /home
```

Sichtung der Status-Ausgabe von BTRFS:

```
#  btrfs fi show /home
Label: none  uuid: 8208f2ce-1e6c-4758-a0ce-8ecd10bdb260
	Total devices 1 FS bytes used 71.38GiB
	devid    1 size 100.00GiB used 100.00GiB path /dev/mapper/systemvg-homelv
```

Für mich sieht es so aus, als wären

* die "71.38GiB" der tatsächlich verbrauchte Platz
* die "used 100.00GiB" die "schlechte Nachricht"

Laut [dieser Anleitung](http://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem-Full-Problems.html) sollte ein `btrfs balance` das Problem lösen:

```
# btrfs balance start -dusage=40 /home
ERROR: error during balancing '/home': No space left on device
```

Na super! In der Anleitung findet sich auch ein Ausweg:

* temporär eine freie Disk hinzufügen
* `btrfs balance` durchführen
* Disk wieder entfernen

Ich mache das, indem ich ein neues LV anlege und dieses dann verwende:

```
# lvcreate -n balancelv -L10G systemvg
  Logical volume "balancelv" created
# btrfs device add /dev/systemvg/balancelv /home
Performing full device TRIM (10.00GiB) ...
# btrfs balance start -dusage=40 /home
Done, had to relocate 2 out of 106 chunks
# btrfs balance start -dusage=50 /home
Done, had to relocate 4 out of 105 chunks
# btrfs balance start -dusage=70 /home
Done, had to relocate 28 out of 103 chunks
# btrfs balance start -dusage=90 /home
Done, had to relocate 61 out of 93 chunks
# btrfs device delete /dev/systemvg/balancelv /home
# btrfs fi show /home
Label: none  uuid: 8208f2ce-1e6c-4758-a0ce-8ecd10bdb260
	Total devices 1 FS bytes used 71.33GiB
	devid    1 size 100.00GiB used 75.28GiB path /dev/mapper/systemvg-homelv
```

Sieht wieder gut aus!

Jetzt heißt's: Sichten, ob's noch weitere Partitionen mit Problemen gibt...

```
for i in / /tmp /home /data /lxc /vm; do
  btrfs device add /dev/systemvg/balancelv $i
  btrfs balance start --full-balance $i
  btrfs balance start -f -dconvert=single -sconvert=single -mconvert=single $i
  btrfs device remove /dev/systemvg/balancelv $i
done
```

Damit's erst garnicht mehr zu den Problemen kommt, kann man `btrfs balance` auch präventiv
regelmässig für alle BTRFS-Partitionen aufrufen:

```
mount\
|grep btrfs\
|sed "s/^.* on //"\
|sed "s/ type btrfs.*$//"\
|while read i; do\
   (set -x; btrfs balance start --full-balance $i;);\
done
```
