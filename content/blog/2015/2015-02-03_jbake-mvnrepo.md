title=JBake: Eigene Version mit eigenem MvnRepo
date=2015-02-03
type=post
tags=blog,jbake
status=published
~~~~~~

JBake: Eigene Version mit eigenem MvnRepo
=========================================

Heute habe ich eine eigene Version von JBake erstellt und diese in
einem eigenen MvnRepo publiziert. All dies ist zugänglich über GitHub.

Vorbereitungen
--------------

1. "Fork" von JBake erstellen auf GitHub
2. "Clonen" des Forks
3. Arbeitszweig erstellen: `git checkout -b v2.3.2-uli v2.3.2`
4. Gradle-Build anlegen: `gradle init`
5. Gradle-Build korrigieren
    * Sonatype-Snapshot-Repo abklemmen
    * MavenDeployer hinzufügen
6. Build durchführen: `./gradlew uploadArchives`
7. Neuen Zweig für's MvnRepo anlegen: `git checkout --orphan mvn-repo`
8. Verschieben: `mv mvn-repo/* .`
9. Aufräumen: `git reset --hard; rm -rf .gradle build* dist target pom*`
10. Hinzufügen: `git add org`
11. Commit: `git commit -m "Initial version"`
12. Abspeichern auf GitHub: `git push --set-upstream origin mvn-repo`
13. Wechseln auf den Arbeitszweig: `git checkout v2.3.2-uli`
14. Verzeichnis mvn-repo löschen: `rm -rf mvn-repo`
15. MvnRepo auschecken: `sh /usr/share/doc/git/contrib/workdir/git-new-workdir . mvn-repo mvn-repo`
16. Add "/mvn-repo" to ".gitignore"

Durchführen einer Veröffentlichung
----------------------------------

1. Versionsnummer hochzählen
    * build.gradle
    * pom.xml (... eigentlich überflüssig)
    * `git commit -m "New version 2.3.2-uli2"`
2. Build durchführen und Version erzeugen: `./gradlew clean uploadArchives`
3. Version hochladen zu GitHub
    * `cd mvn-repo`
    * `git add .`
    * `git commit -m "New version 2.3.2-uli2"`
    * `git push`

Verwendung der veröffentlichten Version
---------------------------------------

Die veröffentlichte Version wird verwendet, indem als URL für das MavenRepo
dieser Wert angegeben wird:

* https://raw.github.com/${githubAccount}/${githubProject}/mvn-repo/
* https://raw.github.com/uli-heller/jbake/mvn-repo/

Links
-----

* [Mein Fork von JBake](https://github.com/uli-heller/jbake/tree/v2.3.2-uli)
* [Meine Anwendung von JBake](https://github.com/uli-heller/uli-jbake)

Quellen
-------

* <http://stackoverflow.com/questions/14013644/hosting-a-maven-repository-on-github>
* <http://stackoverflow.com/questions/6270193/multiple-working-directories-with-git>
