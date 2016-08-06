title=Windows: Screencast mit KRUT und FFMPEG
date=2016-08-06
type=post
tags=windows
status=published
~~~~~~

Windows: Screencast mit KRUT und FFMPEG
=======================================

Ziel: Ich würde gerne meinen Bildschirm aufzeichnen und
als animiertes GIF bereitstellen.

* (KRUT)[http://krut.sourceforge.net/] installieren (ich hab's mit 0.9.4 getestet; benötigt Java)
* (FFMPEG)[https://ffmpeg.zeranoe.com/builds/] installieren (ich hab's mit der statischen 32-bit-Version getestet)

Das Aufzeichnen geht dann so:

1. KRUT starten
2. Aufnahmebereich auswählen (das ist Mist)
    * "Pfeilchen" drücken im KRUT-Fenster
    * Maus positionieren auf die "obere linke Ecke" des Aufnahmebereichs
    * CTRL-Taste drücken und gedrückt halten
    * Maus positionieren auf die "untere rechte Ecke" des Aufnahmebereichs
    * CTRL-Taste loslassen
3. Aufnahmebereich kontrollieren
    * "Snap" drücken im KRUT-Fenster
    * Neues Fenster erscheint mit dem Inhalt des Aufnahmebereichs
    * Schließen
4. Aufnahme starten
    * "Rec" drücken im KRUT-Fenster
5. Aufnahme stoppen
    * "Stop" drücken im KRUT-Fenster
    * Die Aufnahme liegt als "movie.mov" im KRUT-Ordner

Wandeln nach GIF geht so:

1. Kommandozeile öffnen
2. Wandeln mit FFMPEG: `ffmpeg -i movie.mov -pix_fmt rgb24 -r 10 output.gif`
    * Alternativ mit Größenanpassung (absolut): `ffmpeg -i movie.mov -pix_fmt rgb24 -r 10 -s 800x600 output.gif`
    * Alternativ mit Größenanpassung (skaliert): `ffmpeg -i movie.mov -pix_fmt rgb24 -r 10 -filter:v scale=800:-1 output.gif`
3. "movie.mov" löschen

Dateigrößen:

* movie.mov: Etwa 150MB
* output.gif: Etwa 1MB
