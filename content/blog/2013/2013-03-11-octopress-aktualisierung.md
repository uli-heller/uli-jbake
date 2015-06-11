type=post
author=Uli Heller
status=published
title=Octopress-Aktualisierung 1/2 - Grundtests
date=2013-03-11 08:00
comments=true
tags=linux,ubuntu,precise,ruby,blog,octopress
~~~~~~

Aktualisierung meiner Octopress-Installation (1/2)
==================================================

Vor grob 5 Monaten habe ich Octopress erstmalig aufgesetzt und seitdem die
Finger von den Aktualisierungen gelassen. Dadurch funktionieren in "meiner" Installation
nun gewisse Dinge nicht ganz so gut wir im Original. Beispielsweise soll die Verlinkung
von Blog-Posts im Original über einen Methodenaufruf funktionieren, bei meiner Variante
muß ich mir den Link mühsam zusammenklauben.

Erstmal möchte ich testen, ob die aktualisierte Version überhaupt funktioniert. Diese Tests
mache ich mit "master" und "source-2.1".

<!-- more -->

Aktuelle Octopress-Version runterladen
--------------------------------------

*Listing: Octropress runterladen*

``` sh
git clone git://github.com/imathis/octopress.git octopress
cd octopress
git branch -a
* master
remotes/origin/2.1
remotes/origin/HEAD -> origin/master
remotes/origin/colorize
remotes/origin/gh-pages
remotes/origin/guard
remotes/origin/linklog
remotes/origin/master
remotes/origin/migrator
remotes/origin/refactor_with_tests
remotes/origin/rubygemcli
remotes/origin/site
remotes/origin/site-2.1
```

Kurztest Octopress-2.0
----------------------

*Listing: Kurztest Octropress-2.0*

``` sh
cd octopress
gem install bundler
bundle install
rake install
rake generate
rake preview
```

... danach dann im Browser den Link [http://localhost:4000](http://localhost:4000) öffnen - es
wird die Octopress-Grundseite angezeigt.

Kurztest Octopress-2.1
----------------------

*Listing: Kurztest Octropress-2.1 - Mecker wegen JavaScript runtime*

``` sh
cd octopress
git checkout 2.1
gem install bundler
bundle install
rake install
rake aborted!
Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes.
/home/uli/.rvm/gems/ruby-1.9.3-p327/gems/execjs-1.4.0/lib/execjs/runtimes.rb:51:in `autodetect'
/home/uli/.rvm/gems/ruby-1.9.3-p327/gems/execjs-1.4.0/lib/execjs.rb:5:in `<module:ExecJS>'
/home/uli/.rvm/gems/ruby-1.9.3-p327/gems/execjs-1.4.0/lib/execjs.rb:4:in `<top (required)>'
/home/uli/.rvm/gems/ruby-1.9.3-p327/gems/uglifier-1.2.6/lib/uglifier.rb:3:in `require'
/home/uli/.rvm/gems/ruby-1.9.3-p327/gems/uglifier-1.2.6/lib/uglifier.rb:3:in `<top (required)>'
/home/uli/tmp/o/octopress/lib/octopress/js_asset_manager.rb:4:in `require'
/home/uli/tmp/o/octopress/lib/octopress/js_asset_manager.rb:4:in `<top (required)>'
/home/uli/tmp/o/octopress/lib/octopress.rb:5:in `require'
/home/uli/tmp/o/octopress/lib/octopress.rb:5:in `<top (required)>'
/home/uli/tmp/o/octopress/Rakefile:9:in `require'
/home/uli/tmp/o/octopress/Rakefile:9:in `<top (required)>'
/home/uli/.rvm/gems/ruby-1.9.3-p327/bin/ruby_noexec_wrapper:14:in `eval'
/home/uli/.rvm/gems/ruby-1.9.3-p327/bin/ruby_noexec_wrapper:14:in `<main>'
(See full trace by running task with --trace)
```

... funktioniert also nicht so richtig.

Am einfachsten korrigiert man's durch Anpassung vom Gemfile:

*Listing: Anpassungen am Gemfile*

``` diff
diff --git a/Gemfile b/Gemfile
@@ -15,6 +15,7 @@
group :development do
gem 'tzinfo', '~> 0.3.35'
gem 'stitch-rb'
gem 'uglifier'
+  gem 'therubyracer'

# Guard related
gem 'guard'
```

Danach dann `bundle install` und alles wird gut! Nach `rake install`, `rake generate`
und `rake preview` kann man wie üblich
im Browser den Link [http://localhost:4000](http://localhost:4000) öffnen und es
wird die Octopress-Grundseite angezeigt.
