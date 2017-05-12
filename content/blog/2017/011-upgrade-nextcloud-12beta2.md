type=post
author=Uli Heller
status=published
title=Nextcloud: Aktualisierung von 11.0.3 auf 12.0.0beta2
date=2017-05-12 10:00
comments=true
tags=nextcloud
~~~~~~

Heute habe ich testweise eine neue Nextcloud-Instanz angelegt, ausgehend
von unserer bestehenden 11.0.3-Instanz.

## Container kopieren und umkonfigurieren

```
lxc-stop -n nextcloud11
lxc-copy -s -n nextcloud11 -N nextcloud12
lxc-start -d -n nextcloud11
```

Danach dann /var/lib/lxc/nextcloud12/config anpassen:

``` diff
- lxc.network.ipv4 = 10.2.2.111
+ lxc.network.ipv4 = 10.2.2.112
```

Zuletzt den Container starten:

```
lxc-start -d -n nextcloud12
```


## Apache Reverse Proxy konfigurieren

/etc/apache2/sites-available/nextcloud.conf

```
...
        ProxyPass         /nextcloud12  http://10.2.2.112:80/nextcloud12
        ProxyPassReverse  /nextcloud12  http://10.2.2.112:80/nextcloud12
...
```

Danach dann durchstarten:

```
service apache2 restart
```

## Container-Inhalt umkonfigurieren

Verzeichnis umbenennen:

```
cd /var/www
mv nextcloud nextcloud12
```

Apached2-Konfigurationsdatei anpassen (/etc/apache2/conf-available/nextcloud.conf):

```
Alias /nextcloud12 /var/www/nextcloud12
<Directory /var/www/nextcloud12/>
 AllowOverride All
</Directory>
```

Nextcloud-Konfigurationsdatei anpassen (/var/www/nextcloud12/config/config.php):

* Von: com/nextcloud, nach: com/nextcloud12
* Von: '/nextcloud', nach: 'nextcloud12'
* Von: www/nextcloud, nach: www/nextcloud12

Apache durchstarten:

```
service apache2 restart
```

## Test: Funktioniert noch alles?

Im Browser: https://internal.daemons-point.com/nextcloud12/
-> Sieht gut aus!

## Aktualisierung auf Nextcloud-12

Nun habe ich die Nextcloud-Instanz samt Kalender aktualisiert.
Grob ging's so:

* Sicherung erstellen (lxc-snapshot)
* Apache stoppen: `service apache2 stop`
* In's www-Verzeichnis wechseln: `cd /var/www`
* Uralte Sicherung löschen: `rm -rf nextcloud-11.0.2`
* Altes Verzeichnis verschieben: `mv nextcloud12 nextcloud-11.0.3`
* Auspacken: `bzip2 -cd .../nextcloud-12.0.0.beta2.tar.bz2 |tar xf -; mv nextcloud nextcloud12`
* Alte Konfig-Datei wieder aktivieren: `cp nextcloud-11.0.3/config/config.php nextcloud12/config/config.php`
* Zugriffsrechte anpassen: `chown -R www-data.www-data  nextcloud12`
* DB-Migration durchführen: `(cd nextcloud12; mkdir apps-local; sudo -u www-data php occ upgrade)`
* Kalender einspielen: `(cp nextcloud-11.0.3/apps-local/* nextcloud12/apps-local)`
* Zugriffsrechte anpassen: `chown -R www-data.www-data  nextcloud12`
* Maintenance-Mode beenden: `(cd nextcloud12; sudo -u www-data php occ maintenance:mode --off)`
* Apache stoppen: `service apache2 start`

## Test: Funktioniert noch alles?

Im Browser: https://internal.daemons-point.com/nextcloud12/
-> Sieht gut aus!
