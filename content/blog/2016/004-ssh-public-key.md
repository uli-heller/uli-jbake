title=SSH: Public Key
date=2016-03-08
type=post
tags=ubuntu
status=published
~~~~~~

SSH: Public Key
===============

Public Key aus Private Key extrahieren
--------------------------------------

```
$ ssh-keygen -y -f {privateKey}
Enter passphrase: XXX
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1cdBC88JrLfbQtjR6QSCBfK/7zba4O1Cj
raiB7MT59ztpc9Br1z7uLbXn3OvCmIaTl/BkYPSVMKJK1xT6ce4i6suFWosd9H8e13hMr
lqGtahbohOJdg32XKwWNo7vqM8HCrCgYQE+y4d/PzdqIq4KQbEYJNqEw3ZFN+Fep7bH0k
YCay0keKJdhBcIzPYOpG5WbZyYjN07NiDDJMFuimnk1QBUj0K/FMfvtMfxqPv3tdcKGo0
TSWE6QteborIXmQVcZ9Zsir+diFb6cS0HsHZ0xrkde8xQrX0B+2bPEYZhax3ro2Qj/Cv7
RGbS4H7jidxUAp6Q+VFQ/eAnpCZDoITmw==
```

Public Key wandeln in PKCS8
---------------------------

```
$ ssh-keygen -e -m PKCS8 -f {publicKey}
-----BEGIN PUBLIC KEY-----
MIIBIDANBgkqhkiG9w0BAQEFAAOCAQ0AMIIBCAKCAQEA1cdBC88JrLfbQtjR6QSC
BfK/7zba4O1CjraiB7MT59ztpc9Br1z7uLbXn3OvCmIaTl/BkYPSVMKJK1xT6ce4
i6suFWosd9H8e13hMrlqGtahbohOJdg32XKwWNo7vqM8HCrCgYQE+y4d/PzdqIq4
KQbEYJNqEw3ZFN+Fep7bH0kYCay0keKJdhBcIzPYOpG5WbZyYjN07NiDDJMFuimn
k1QBUj0K/FMfvtMfxqPv3tdcKGo0TSWE6QteborIXmQVcZ9Zsir+diFb6cS0HsHZ
0xrkde8xQrX0B+2bPEYZhax3ro2Qj/Cv7RGbS4H7jidxUAp6Q+VFQ/eAnpCZDoIT
mwIBIw==
-----END PUBLIC KEY-----
```
