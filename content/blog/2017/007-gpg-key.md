type=post
author=Uli Heller
status=published
title=GPG: Neuen Schlüssel erzeugen
date=2017-03-03 10:00
comments=true
tags=gpg
~~~~~~

Ablauf
------

* Altes GNUPG-Verzeichnis sichern: `cp -a .gnupg .gnupg-20170303`
* Neues Schlüsselpaar erzeugen: `gpg --gen-key`
    * Art des Schlüssels: 1 - (1) RSA und RSA
    * Schlüssellänge: 4096
    * Gültigkeit: 0 (ewig)
    * Name: Uli Heller
    * Email-Adresse: uli.heller@daemons-point.com
    * Kommentar: {leer}
    * Passphrase: {was-auch-immer}
    * Danach "hängt" die Ausführung eine ganze Weile, weil viele Zufallswerte benötigt werden
* Sichten: Welche Schlüsselpaare gibt es? `gpg --list-key`
    ```
    /home/uli/.gnupg/pubring.gpg
    ----------------------------
    pub   1024D/F8079705 2008-12-23
    uid                  Uli Heller <uli.heller@daemons-point.com>
    sub   2048g/C4539EA7 2008-12-23

    ...
    pub   4096R/F2DE542A 2017-03-04
    uid                  Uli Heller <uli.heller@daemons-point.com>
    sub   4096R/842F9CFD 2017-03-04
    ```
* Foto hinzufügen
    * `gpg --edit-key F2DE542A`
    * `addphoto`  -  `/tmp/uli3.jpg` ... Bild bestätigen
    * `save`
* Hash-Algorithmen stärken
    * `gpg --edit-key F2DE542A`
    * `setpref SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed` - `j`
    * `save`
* Unterschlüssel für Signierung
    * `gpg --edit-key F2DE542A`
    * `addkey`
    * `4` - (4) RSA (nur signieren/beglaubigen)
    * Schlüssellänge: `4096`
    * Gültigkeit: `0` (ewig)
    * Richtig? 'j'
    * Erzeugen? 'j'
    * `save`
* Widerrufszertifikat erzeugen: `gpg --output uli.heller@daemons-point.com.gpg-revocation-certificate --gen-revoke F2DE542A`
* Exportieren:
    * `gpg --export-secret-keys --armor F2DE542A >uli.heller@daemons-point.com.private.gpg-key`
    * `gpg --export --armor F2DE542A >uli.heller@daemons-point.com.public.gpg-key`
* Umwandeln in Laptop-Key
    * `gpg --export-secret-subkeys  F2DE542A >subkeys`
    * `gpg --delete-secret-key  F2DE542A `
    * `gpg --import subkeys`
    * `rm subkeys`
* Nochmal exportieren:
    * `gpg --export-secret-keys --armor F2DE542A >uli.heller@daemons-point.com.private.laptop.gpg-key`
    * `gpg --export --armor F2DE542A >uli.heller@daemons-point.com.public.laptop.gpg-key`

Links
-----

*[Alex Cabal: CREATING THE PERFECT GPG KEYPAIR](https://alexcabal.com/creating-the-perfect-gpg-keypair/)
