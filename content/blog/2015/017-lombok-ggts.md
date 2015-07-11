title=Lombok: In Groovy/Grails Tool Suite installieren
date=2015-07-11
type=post
tags=java, eclipse
status=published
~~~~~~

Lombok: In Groovy/Grails Tool Suite installieren
================================================

Für meine Java-Projekte benutze ich gerne [Lombok](https://projectlombok.org) und [Eclipse](http://eclipse.org).
Wenn die Java-Projekte auch Groovy-Klassen enthalten, beispielsweise
für das Testen mit [Spock](http://spockframework.org), dann brauche
ich eine erweiterte Eclipse-Version
wie die [Groovy/Grails Tool Suite (GGTS)](https://spring.io/tools/ggts).

Leider wird diese vom Lombok-Installer nicht als Eclipse-Installation
erkannt.

Abhilfe:

```
cd {ggts-install-dir}
mv GGTS.ini eclipse.ini
# Jetzt kann Lombok installiert werden
mv eclipse.ini GGTS.ini
```
