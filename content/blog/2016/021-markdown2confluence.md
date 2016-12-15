title=Installation von markdown2confluence
date=2016-12-16
type=post
tags=ubuntu
status=published
~~~~~~

Installation von markdown2confluence
====================================

Grob bin ich so vorgegangen:

1. [Ruby-2.3.3](https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz)
   (neueste Version) installieren, die Standard-Version von Ubuntu-14.04 ist zu alt
2. `sudo -s`
3. Pfad setzen: `export PATH=/opt/ruby-2.3.3/bin:$PATH`
4. [markdown2confluence](https://github.com/jedi4ever/markdown2confluence) installieren: `gem install markdown2confluence`
5. Testaufruf:
    
```
export PATH=/opt/ruby-2.3.3/bin:$PATH`
markdown2confluence test.md
```

Links:

* [https://github.com/jedi4ever/markdown2confluence](https://github.com/jedi4ever/markdown2confluence)
