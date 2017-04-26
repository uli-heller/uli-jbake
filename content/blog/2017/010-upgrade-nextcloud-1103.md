type=post
author=Uli Heller
status=published
title=Nextcloud: Aktualisierung von 11.0.2 auf 11.0.3
date=2017-04-26 10:00
comments=true
tags=nextcloud
~~~~~~

Heute habe ich unsere Nextcloud-Instanz samt Kalender aktualisiert.
Grob ging's so:

* Sicherung erstellen (lxc-snapshot)
* Apache stoppen: `service apache2 stop`
* In's www-Verzeichnis wechseln: `cd /var/www`
* Uralte Sicherung löschen: `rm -rf nextcloud-11.0.1`
* Altes Verzeichnis verschieben: `mv nextcloud nextcloud-11.0.2`
* Auspacken: `bzip2 -cd .../nextcloud-11.0.3.tar.bz2 |tar xf -`
* Alte Konfig-Datei wieder aktivieren: `cp nextcloud-11.0.2/config/config.php nextcloud/config/config.php`
* Zugriffsrechte anpassen: `chown -R www-data.www-data  nextcloud`
* DB-Migration durchführen: `(cd nextcloud; mkdir apps-local; sudo -u www-data php occ upgrade)`
* Kalender einspielen: `(cd nextcloud/apps-local; gzip -cd .../calendar-1.5.2.tar.gz |tar xf -)`
* Tasks einspielen: `(cd nextcloud/apps-local; gzip -cd .../tasks-0.9.5.tar.gz |tar xf -)`
    * `find nextcloud/apps-local/tasks -type d|xargs chmod go-w`
* Notes einspielen: `(cd nextcloud/apps-local; gzip -cd .../notes-2.2.0.2.tar.gz |tar xf -)`
* Zugriffsrechte anpassen: `chown -R www-data.www-data  nextcloud`
* Maintenance-Mode beenden: `(cd nextcloud; sudo -u www-data php occ maintenance:mode --off)`
* Apache stoppen: `service apache2 start`

Nun im Browser die Nextcloud-Instanz öffnen und den Kalender, Notes und Tasks wieder aktivieren.

Fertig.
