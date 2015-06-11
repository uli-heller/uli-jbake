type=post
title=Probleme mit MySQL: start: Job failed to start
date=2013-05-01 06:31
comments=true
external-url:
tags=linux,ubuntu,lucid,mysql
~~~~~~

Auf einem meiner Rechner habe ich gestern diverse Updates eingespielt mit

* `apt-get update`
* `apt-get upgrade`
* `apt-get dist-upgrade`

Dabei wurde auch MySQL aktualisiert. Leider läßt es sich anschließend nicht
mehr starten. Es erscheint die Fehlermeldung "start: Job failed to start".

<!-- more -->

*Listing: Fehlermeldung beim Start von MySQL*

``` sh
service mysql start
start: Job failed to start
```

Eine Sichtung der Log-Dateien unter /var/log liefert leider auch keine
brauchbaren Informationen: 

*Listing: Sichtung der Log-Dateien*

``` sh
cd /var/log
ls -ltra
-rw-rw-r--  1 root      utmp  15744 2013-05-01 06:28 wtmp
-rw-rw-r--  1 root      utmp 292292 2013-05-01 06:28 lastlog
-rw-r-----  1 syslog    adm   93910 2013-05-01 06:40 auth.log
-rw-r-----  1 syslog    adm   17682 2013-05-01 06:47 syslog
-rw-r-----  1 syslog    adm  142088 2013-05-01 06:47 messages
-rw-r-----  1 syslog    adm   78161 2013-05-01 06:47 kern.log
-rw-r-----  1 syslog    adm    5394 2013-05-01 06:47 daemon.log
# daemon.log: mysql pre-start process (2168) terminated with status 1
# kern.log: type=1505 audit(1367383657.073:19):  operation="profile_replace" pid=2170 name="/usr/sbin/mysqld"
# messages: type=1505 audit(1367383657.073:19):  operation="profile_replace" pid=2170 name="/usr/sbin/mysqld"
# syslog:
#   type=1505 audit(1367383657.073:19):  operation="profile_replace" pid=2170 name="/usr/sbin/mysqld"
#    mysql pre-start process (2168) terminated with status 1
# auth.log: ...
```

Logging von Upstart aktivieren
------------------------------

Im [Kochbuch für Upstart](http://upstart.ubuntu.com/cookbook/#initctl-log-priority)
steht, wie man das Logging für Upstart aktiviert:

* `initctl log-priority  # Ausgabe: message`
* `initctl log-priority debug`
* `service mysql start`

Danach stehen deutlich mehr Informationen in den Log-Dateien. Leider betreffen
diese mehr die Arbeitsweise vom Upstart-Init-Daemon als die der zu startenden
Services.

Also: Logging für Upstart wieder deaktivieren:

* `initctl log-priority message`

Logging für ein Upstart-Skript aktivieren
-----------------------------------------

Im  [Kochbuch für Upstart](http://upstart.ubuntu.com/cookbook/#obtaining-a-log-of-a-script-section)
steht, wie man Logs für die Upstart-Skripte erzeugt. Die Idee ist, dem Ansatz
"Log Script Section Output to Syslog" zu folgen:

*Listing: Auszug aus dem Upstart-Kochbuch - Skriptausgabe loggen*

``` sh
script
exec >/dev/kmsg 2>&1
echo "this data will be sent to the system log"
end script
```

Zunächst müssen wir die Konfigurationsdatei für den MySQL-Upstart-Service
finden: /etc/init/mysql.conf. Eine Sichtung liefert:

* Es gibt ein "pre-start script"
* In den Fehlermeldungen war die Rede von "pre-start process"
* Also: Wir schauen uns den "pre-start"-Teil näher an

Dieser Teil sieht so aus:

*Listing: /etc/init/mysql.conf - pre-start*

``` sh
pre-start script
#Sanity checks
[ -r $HOME/my.cnf ]
[ -d /var/run/mysqld ] || install -m 755 -o mysql -g root -d /var/run/mysqld
# Load AppArmor profile
if aa-status --enabled 2>/dev/null; then
apparmor_parser -r /etc/apparmor.d/usr.sbin.mysqld || true
fi
LC_ALL=C BLOCKSIZE= df --portability /var/lib/mysql/. | tail -n 1 | awk '{ exit ($4<4096) }'
end script
```

Es fällt auf, dass der freie Speicherplatz auf /var/lib/mysql/. geprüft wird.
Möglicherweise ist also auch einfach diese Partition voll gelaufen!

Sichtung und Bereinigung der Partition /var
-------------------------------------------

*Listing: Sichtung und Bereinigung der Partiton /var*

``` sh
df /var
/dev/mapper/systemvg-varlv  376807    354385      2966 100% /var
apt-get clean
df /var
/dev/mapper/systemvg-varlv  376807    202839    154512  57% /var
```

Nun kann man MySQL wieder normal starten!

*Listing: Normaler Start von MySQL*

``` sh
service mysql start
mysql start/running, process 1589
```

Links
-----

* [Kochbuch für Upstart](http://upstart.ubuntu.com/cookbook)
