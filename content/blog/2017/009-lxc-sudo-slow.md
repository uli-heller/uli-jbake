type=post
author=Uli Heller
status=published
title=LXC: SUDO sehr langsam innerhalb eines Containers
date=2017-03-08 10:00
comments=true
tags=lxc
~~~~~~

In letzter Zeit beobachte ich, dass `sudo -s`
sehr viel Zeit in Anspruch nimmt, bis der
Eingabeprompt erscheint.

Sichtung von /etc/hosts:

```
...
127.0.0.1   localhost
127.0.1.1   ubuntu-trusty
...
```

Ich sehe, dass hier noch der Name des Basis-Containers
drinsteht. Mein Container hat mittlerweile einen
anderen Hostnamen:

```
$ hostname
mars
```

Also: Ändern von /etc/hosts:

```
...
127.0.0.1   localhost
127.0.1.1   mars
...
```

Nochmaliger Test: `sudo -k` ... geht schnell, `sudo -s` ... geht auch schnell.
