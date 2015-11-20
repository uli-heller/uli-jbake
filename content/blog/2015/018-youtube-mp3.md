title=Ubuntu: MP3s aus Youtube-Videos extrahieren
date=2015-11-20
type=post
tags=ubuntu,linux,trusty
status=published
~~~~~~

Ubuntu: MP3s aus Youtube-Videos extrahieren
===========================================

Dieser Artikel bezieht sich auf Ubuntu Server 14.04 - Trusty.

Grobablauf:

1. Video herunterladen: `youtube-dl {url}`
2. Audio extrahieren: `avconv -i {downloadedFile} {audio}.wav`
3. Nach MP3 wandeln: `lame {audio}.wav {audio}.mp3`
