title=GCC-4.9 für Ubuntu-14.04
date=2016-01-13
type=post
tags=ubuntu
status=published
~~~~~~

GCC-4.9 für Ubuntu-14.04
========================

Installieren und Aktivieren von GCC-4.9
---------------------------------------

```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get install gcc-4.9 g++-4.9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
```

Hinweis: Bei mir hat's ohne das PPA nicht funktioniert!
Es wurden dann keinerlei Programm-Binaries installiewrt, GCC-4.9 war
nicht aufrufbar!

Zurück zu GCC-4.8
-----------------

```
sudo apt-get install gcc-4.8 g++-4.8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
```

Sichten der aktiven GCC-Version
-------------------------------

```
sudo update-alternatives --config gcc
```

Links
-----

* [AskUbuntu: How do I use the latest gcc 4.9 on Ubuntu 14.04}(http://askubuntu.com/questions/466651/how-do-i-use-the-latest-gcc-4-9-on-ubuntu-14-04)
