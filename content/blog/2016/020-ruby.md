title=Ruby: Installation von Ruby-2.3.3
date=2016-12-15
type=post
tags=ubuntu
status=published
~~~~~~

Ruby: Installation von Ruby-2.3.3
=================================

Grob bin ich so vorgegangen:

1. [Ruby-2.3.3](https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz)
   (neueste Version) herunterladen: `wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz`
2. Auspacken und installieren
    
```
 mkdir ruby-tmp
 cd tuby-tmp
 gzip -cd .../ruby-2.3.3.tar.gz |tar xf -
 cd ruby-2.3.3
 ./configure --prefix=/opt/ruby-2.3.3
 make
 sudo make install
```


Links:

* [https://www.r-bloggers.com/installing-ruby-on-linux-as-a-user-other-than-root/](https://www.r-bloggers.com/installing-ruby-on-linux-as-a-user-other-than-root/)
