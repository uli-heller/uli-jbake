type=post
author=Uli Heller
status=published
title=Redmine: Von FCGI zu Passenger
date=2013-07-19 15:00
comments=true
tags=linux,ubuntu,lucid,ruby,redmine,passenger
~~~~~~

Bislang habe ich Redmine hinter einem Apache HTTPD via FCGI betrieben.
Bei meinen Tests mit Redmine-2.3.2 gibt es bei dieser Konstellation aber
viele Probleme mit der Selektion des Rails-Environments. Es wird immer
"development" verwendet, "production" kann nicht mehr "wie früher" über
"environment.rb" und `ENV['RAILS_ENV'] ||= 'production'` selektiert werden.

<!-- more -->

## Sichtung der Alt-Version

Zunächst muß sichergestellt werden, dass die alte Version hinreichend
gut funktioniert:

* Redmine-VM starten
* LDAP-VM starten
* Browser: <http://192.168.56.97> -> "It works"
* Browser: <http://192.168.56.97/redmine> -> Begrüssung von Redmine
* Browser: <http://192.168.56.97/redmine/issues/1> -> Anmeldungseite wird angezeigt; Anmeldung funktioniert

Soweit sieht alles ganz OK aus. Nun: Sichtung der Programmstände.


``` sh
$ ruby -v
ruby 1.8.7 (2010-01-10 patchlevel 249) [i486-linux]
$ gem list

*** LOCAL GEMS ***

actionmailer (2.3.17)
actionpack (2.3.17)
activerecord (2.3.17)
activeresource (2.3.17)
activesupport (2.3.17)
i18n (0.4.2)
mysql (2.8.1)
rack (1.1.3)
rails (2.3.17)
rake (0.8.7)
rubygems-update (1.6.2)
```

## Ruby-Gems herunterladen und installieren

Mit diesen Befehlen werden die Ruby-Gems heruntergeladen:


``` sh
gem fetch passenger
# gem fetch passenger -v 4.0.10
gem fetch daemon_controller -v ">= 1.1.0" 
# gem fetch daemon_controller -v 1.1.4
```

Die *.gem-Dateien müssen auf die Redmine-VM übertragen werden, am besten
mit `scp`. Danach spielt man sie ein mit


``` sh
gem install passenger-4.0.10.gem
```

## Apache-Modul installieren

Mit nachfolgendem Befehl wird das Passenger-Modul für Apache2
installiert und auch gleich aktiviert:


``` sh
apt-get install libapache2-mod-passenger
```

## Apache konfigurieren

* Konfigurationsdatei kopieren und anpassen:
`cp /etc/apache2/sites-available/default /etc/apache2/sites-available/passenger`

*Listing: /etc/apache2/sites-available/passenger*

``` text
#NameVirtualHost *:80
<VirtualHost *:80>
ServerAdmin webmaster@localhost

PassengerDefaultUser www-data
RailsEnv production
#        RailsBaseURI /redmine

DocumentRoot /srv/redmine-1.2.1/public/
#        DocumentRoot /var/www/
Alias /redmine "/srv/redmine-1.2.1/public/"
<Directory "/srv/redmine-1.2.1/public/">   
Options FollowSymLinks -MultiViews  
AllowOverride none  
Order allow,deny
allow from all
</Directory>

ErrorLog /var/log/apache2/error.log

# Possible values include: debug, info, notice, warn, error, crit,
# alert, emerg.
LogLevel warn  

CustomLog /var/log/apache2/access.log combined
ServerSignature On
</VirtualHost>
```

* Alte Datei "abklemmen": `a2dissite default`

* Neue Datei aktivieren: `a2ensite passenger`

* Apache neu starten: `/etc/init.d/apache2 restart`

## Sichtung der Neu-Version

Zunächst muß sichergestellt werden, dass die alte Version hinreichend
gut funktioniert:

* Redmine-VM starten (... läuft vermutlich eh' noch)
* LDAP-VM starten (... läuft vermutlich eh' noch)
* Browser: <http://192.168.56.97>  -> Begrüssung von Redmine
* Browser: <http://192.168.56.97/redmine> -> Begrüssung von Redmine
* Browser: <http://192.168.56.97/redmine/issues/1> -> Anmeldungseite wird angezeigt; Anmeldung funktioniert
