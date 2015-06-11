type=post
author=Uli Heller
status=published
title=Rails-2.3.15
date=2013-01-11 07:00
updated=2013-02-14 06:10
comments=true
tags=linux,ubuntu,lucid,ruby,redmine
~~~~~~

Rails-Update für Redmine-1.2
============================

Einleitung
----------

Auf einem etwas älteren Linux-Server betreibe ich eine fast genauso alte
[Redmine](http://redmine.org)-Instanz. Redmine ist eine
[Rails](http://rubyonrails.org)-Anwendung und
weil ich so eine alte Version davon verwende, ist die Rails-Version anfällig
gegen die diese Woche entdeckten kritischen 
[Schwachstellen](http://weblog.rubyonrails.org/2013/1/8/Rails-3-2-11-3-1-10-3-0-19-and-2-3-15-have-been-released/).

Redmine selbst kann zur Zeit nicht auf die aktuelle Version 2.2 aktualisiert
werden, weil ich ältere, mit der neuen Version nicht verträgliche Plugins
verwende. Also heißt die Strategie: Redmine beibehalten, Rails aktualisieren
auf Version 2.3.15.

Gems herunterladen und zum Redmine-Server übertragen
----------------------------------------------------

Der Redmine-Server hat keinen Zugang zum Internet. Deshalb müssen die Gems
auf einem anderen Rechner heruntergeladen und zum Redmine-Server übertragen
werden.

{% include_code get-2.3.15.sh %}

Die Dateien werden danach mit SCP auf den Redmine-Server übertragen.

Basissystem aktualisieren
-------------------------

*Listing: Basissystem aktualisieren*

``` sh
apt-get update
apt-get upgrade
apt-get dist-upgrade
```

Gems einspielen
---------------

*Listing: Gems einspielen*

``` sh
gem install rails-2.3.15.gem
```

Alte Gems deininstallieren
--------------------------

{% include_code uninstall-2.3.11.sh %}
