title=Warnung bei "apt-get update": xxx doesn't support architecture 'i386'
date=2016-03-10
type=post
tags=ubuntu
status=published
~~~~~~

Warnung bei "apt-get update": xxx doesn't support architecture 'i386'
=====================================================================

Seit ein paar Tagen erscheint diese Fehlermeldung:

```
uli$ sudo apt-get update
Ign:1 http://dl.google.com/linux/chrome/deb stable InRelease
OK:2 http://dl.google.com/linux/chrome/deb stable Release                     
OK:3 http://de.archive.ubuntu.com/ubuntu xenial InRelease                      
OK:4 http://de.archive.ubuntu.com/ubuntu xenial-updates InRelease              
OK:6 http://de.archive.ubuntu.com/ubuntu xenial-backports InRelease            
OK:7 http://security.ubuntu.com/ubuntu xenial-security InRelease             
Paketlisten werden gelesen... Fertig                 
N: Skipping acquire of configured file 'main/binary-i386/Packages' as repository 'http://dl.google.com/linux/chrome/deb stable InRelease' doesn't support architecture 'i386'
```

Abhilfe: Datei /etc/apt/sources.list.d/google-chrome.list editieren

``` diff
< deb http://dl.google.com/linux/chrome/deb/ stable main
---
> deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
```
