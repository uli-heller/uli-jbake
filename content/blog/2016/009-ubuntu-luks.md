title=Ubuntu mit Festplattenverschlüsselung
date=2016-05-18
type=post
tags=ubuntu
status=draft
~~~~~~

Ubuntu mit Festplattenverschlüsselung installieren
==================================================

Auf meinem Asus-Laptop möchte ich ubuntu mit Festplattenverschlüsselung
parallel zum vorinstallierten Windows einrichten. Die Ubuntu-Mate-CD
bietet hierfür leider keine Hilfestellung: Bei Festplattenverschlüsselung
wird immer die komplette Platte verwendet.

Vorbereitungen
--------------

* Live-CD booten
* Kommandozeile öffnen - Strg-Alt-T
* Partitionierung: `sudo gdisk /dev/sda`
* /boot-Partition anlegen
    * n
    * 1 (default)
    * 2048 (default)
    * +300M
    * ef02 (BIOS boot partition)
* LUKS-Partition anlegen
    * n
    * 2 (default)
    * 616448 (default)
    * 33554398 (default)
    * 8301 (Linux reserved) 8300?
* Speichern
    * w
    * y
* Boot-Partition initialisieren: `sudo mkfs.ext2 /dev/sda1` ext4?
* Crypto-Partition initialisieren: `sudo cryptsetup luksFormat /dev/sda2`
    * YES
    * Passphrase eingeben: uli
    * Passphrase wiederholen: uli
* Crypto-Partition einbinden: `sudo cryptsetup luksOpen /dev/sda2 sda2_crypt`
    * Passphrase: uli
* LVM initialisieren
    * `sudo -s`
    * `pvcreate /dev/mapper/sda2_crypt`
    * `vgcreate systemvg /dev/mapper/sda2_crypt`
    * `lvcreate systemvg -n rootlv -L +2G`
    * `lvcreate systemvg -n usrlv -L +4G`
    * `lvcreate systemvg -n swaplv -L +1G`

Ubuntu installieren
-------------------

* Partitionierung: "Etwas anderes"
    * /dev/sda1 ... /boot
    * /dev/mapper/rootlv ... /
    * /dev/mapper/usrlv ... /usr
    * /dev/mapper/swaplv ... swap
    * Bootloader-Installation: /dev/sda
* Übrige Installations-Einstellungen: Wie üblich...

Nacharbeiten
------------

* `mount /dev/mapper/systemvg-rootlv /mnt`
* `mount /dev/mapper/systemvg-usrlv /mnt/usr`
* `mount --bind /dev /mnt/dev`
* `mount --bind /proc /mnt/proc`
* `mount --bind /run /mnt/run`
* `mount --bind /sys /mnt/sys`
* `chroot /mnt mount /boot`
* `echo "sda2_crypt UUID=$(blkid -s UUID -o value /dev/sda2) none luks" > /mnt/etc/crypttab`
* `chroot /mnt update-initramfs -u`
* `chroot /mnt grub-install /dev/sda`
* `chroot /mnt update-grub`
* `umount /mnt/sys /mnt/run /mnt/proc /mnt/dev`
* `umount /mnt/boot`
* `umount /mnt/usr /mnt`
