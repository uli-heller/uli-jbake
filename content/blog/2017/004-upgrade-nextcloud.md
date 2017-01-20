type=post
author=Uli Heller
status=published
title=Nextcloud: Aktualisierung von 11.0.0 auf 11.0.1
date=2017-01-20 10:00
comments=true
tags=nextcloud
~~~~~~

Heute habe ich unsere Nextcloud-Instanz samt Kalender aktualisiert.
Grob ging's so:

* Sicherung erstellen
* Apache stoppen: `service apache2 stop`
* In's www-Verzeichnis wechseln: `cd /var/www`
* Altes Verzeichnis verschieben: `mv nextcloud nextcloud-11.0.0`
* Auspacken: `bzip2 -cd .../nextcloud-11.0.1.tar.bz2 |tar xf -`
* Alte Konfig-Datei wieder aktivieren: `cp nextcloud-11.0.0/config/config.php nextcloud/config/config.php`
* Zugriffsrechte anpassen: `chown -R www-data.www-data  nextcloud`
* DB-Migration durchführen: `(cd nextcloud; mkdir apps-local; sudo -u www-data php occ upgrade)`
* Kalender einspielen: `(cd nextcloud/apps-local; gzip -cd .../calendar-1.5.0.tar.gz |tar xf -)`
* Maintenance-Mode beenden: `(cd nextcloud; sudo -u www-data php occ maintenance:mode --off)`
* Apache stoppen: `service apache2 start`

Nun im Browser die Nextcloud-Instanz öffnen und den Kalender wieder aktivieren.

Fertig.
