title=Festplattenverschlüsselung unter Ubuntu-14.04
date=2015-02-18
type=post
tags=ubuntu
status=published
~~~~~~

Festplattenverschlüsselung unter Ubuntu-14.04
=============================================

Ausgangspunkt: Frisch installiertes Ubuntu-14.04
mit verschlüsselter Festplatte. Der Rechner hat den Namen
"myfileserver" und bekommt seine IP-Adresse per DHCP.

Problem: Man muß beim Starten den Festplattenschlüssel eintippen.
Das geht bei einem Server ohne Konsole nur mit Problemen.

Abhilfe: <http://blog.nguyenvq.com/2011/09/13/remote-unlocking-luks-encrypted-lvm-using-dropbear-ssh-in-ubuntu/> oder auch <http://unix.stackexchange.com/questions/5017/ssh-to-decrypt-encrypted-lvm-during-headless-server-boot> oder auch <https://www.thomas-krenn.com/de/wiki/Voll-verschl%C3%BCsseltes-System_via_SSH_freischalten> oder auch <http://blog.asiantuntijakaveri.fi/2014/12/headless-ubuntu-1404-server-with-full.html>

Ablauf
------

Auf dem Server:

* `sudo apt-get install dropbear busybox`
* Anlegen von "/etc/initramfs-tools/scripts/local-top/networking" mit diesem Inhalt:

    [ "$1" = "prereqs" ] && { exit 0; }
    hostname myfileserver
    . /scripts/functions
    configure_networking

* `sudo chmod +x /etc/initramfs-tools/scripts/local-top/networking`
* `sudo sed -i "s,-x /bin/plymouth,-x /bin/plymouth.disabled,"  /usr/share/initramfs-tools/scripts/local-top/cryptroot`
* `sudo update-initramfs -u`
* `sudo cp /etc/initramfs-tools/root/.ssh/id_rsa /tmp/id_rsa`
* `sudo chown uli.uli /tmp/id_rsa`
* `sudo sh -c "echo GRUB_RECORDFAIL_TIMEOUT=2 >>/etc/default/grub"`
* `sudo update-grub`

Auf dem Client:

* `scp uli@{myfileserver}:/tmp/id_rsa ~/.ssh/id_rsa_server`
* `ssh uli@{myfileserver} rm /tmp/id_rsa`

Boot-Vorgang
------------

1. Rechner einschalten
2. Etwa eine Minute warten
3. `ssh root@myfileserver  -o UserKnownHostsFile=.ssh/myfileserver_known_hosts -i id_rsa "echo -n \"{password}\" >/lib/cryptsetup/passfifo"`

Weitere SSH-Schlüssel freischalten
----------------------------------

1. Einloggen beim {myfileserver}
2. Wechsel nach /etc/initramfs-tools/root/.ssh
3. Erweitern von "authorized_keys"
4. `sudo update-initramfs -u`

Dateien
-------

### /etc/initramfs-tools/root/.ssh/authorized_keys

```
ssh-rsa AAAAB3NzaC1yc2EAAAAD...UNNglI8gacGTgJtaC5mU9jrVyFbSbVODtb7ksl53QE/QFj root@myfileserver
ssh-rsa AAAAB3NzaC1yc2EAAAAB...x3ro2Qj/Cv7RGbS4H7jidxUAp6Q+VFQ/eAnpCZDoITmw== uli@mypc
```

### /etc/initramfs-tools/scripts/local-top/networking

```
[ "$1" = "prereqs" ] && { exit 0; }
HOSTNAME=myfileserver
hostname "${HOSTNAME}"
. /scripts/functions
configure_networking
for device in /sys/class/net/*; do
  d="$(basename "$device")"
  if [ "$d" != "lo" ]; then
    /bin/ipconfig "::::${HOSTNAME}:$d:all"
  fi
done
```

### /etc/default/grub

```
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'
GRUB_SAVEDEFAULT=n
GRUB_GFXPAYLOAD=text
GRUB_GFXPAYLOAD_LINUX=keep

GRUB_DEFAULT=0
#GRUB_HIDDEN_TIMEOUT=0
#GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT=2
GRUB_RECORDFAIL_TIMEOUT=2
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="verbose bootdegraded=true bootwait=5 zswap.enabled=1 zswap.compressor=lz4"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
GRUB_TERMINAL=console
GRUB_TERMINAL_OUTPUT=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command `vbeinfo'
#GRUB_GFXMODE=640x480

# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
GRUB_DISABLE_RECOVERY="true"
GRUB_DISABLE_SUBMENU=y
GRUB_DISABLE_OS_PROBER=y

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE="480 440 1"
```

Probleme
--------

### Offen

Aktuell sind keine offenen Probleme bekannt.

#### Kein Hostname bei DHCP in InitramFS

Bei den DHCP-Abfragen innerhalb von InitramFS
wird kein Hostname an den DHCP-Server übermittelt.
Dadurch kann der "halb" gestartete Rechner nur
via IP-Adresse und nicht via Hostname angesprochen
werden. Das ist besonders dann ungünstig, wenn sich
die IP-Adresse ändert.

Abhilfe: `/bin/ipconfig ::::myfileserver:eth0:any`

Das sollte so auch in .../networking eingetragen werden!

### Gelöst

#### Booten direkt von der Konsole scheitert

Zumindest beim Test mit VirtualBox ist das Booten direkt von der Konsole
nicht so ohne weiteres möglich. Es erscheint zwar ein Prompt zur Passphrase-Eingabe,
allerdings funktioniert dieser nicht richtig.

Dies hat bei mir geholfen:

* Wechsel auf die zweite Konsole mit Alt-F2
* Rückwechsel auf die erste Konsole mit Alt-F1
* "Blindes" Eingeben des Kennwortes

#### Abfrage einer IP-Adresse via DHCP scheitert

Die Netzwerkkonfiguration wird per Standard nicht immer vorgenommen,
sie muß über ein Skript erzwingen werden:

```
[ "$1" = "prereqs" ] && { exit 0; }
hostname myfileserver
. /scripts/functions
configure_networking
```

Damit wird die Netzwerkadresse immer per DHCP angefordert.

#### Grub-Menü nach gescheitertem Start

<http://askubuntu.com/questions/178091/how-to-disable-grubs-menu-from-showing-up-after-failed-boot>

As I had the same problem and figured out the following solution:

1. Open /etc/default/grub with an editor
2. Add a line with this assignment: GRUB_RECORDFAIL_TIMEOUT=N
   Set N to the desired timeout in case of a previously failed boot
4. Update Grub: `sudo update-grub`
