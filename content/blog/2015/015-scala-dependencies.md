title=Scala: Dependencie
date=2015-07-05
type=post
tags=scala
status=published
~~~~~~

Dependencies
============

I've looked into [gitbucket ticket #748](https://github.com/takezoe/gitbucket/issues/748) which is about dupicate versions of c3p0.

Unfortunately, there isn't an easy way to display all transitive dependencies within SBT. You have to install a plugin first.

sbt-dependency-graph
--------------------

I've installed [this plugin](https://github.com/jrudolph/sbt-dependency-graph) to get a list of all dependencies. The installation
is pretty easy:

1. Determine the SBT version: `sbt --version` -> 0.13.8
2. Create/extend the file ~/.sbt/0.13/plugins/plugins.sbt: `addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.7.5")`
3. Create/extend the file ~/.sbt/0.13/global.sbt: `net.virtualvoid.sbt.graph.Plugin.graphSettings`

Show Dependencies
-----------------

```
cd gitbucket
. env.sh
sbt dependency-tree
...
[info] gitbucket:gitbucket_2.11:3.4u4 [S]
[info]   +-com.enragedginger:akka-quartz-scheduler_2.11:1.3.0-akka-2.3.x [S]
[info]   | +-org.quartz-scheduler:quartz:2.2.1
[info]   |   +-c3p0:c3p0:0.9.1.1
[info]   |   +-org.slf4j:slf4j-api:1.6.6 (evicted by: 1.7.10)
[info]   |   +-org.slf4j:slf4j-api:1.7.10
[info]   |   
[info]   +-com.h2database:h2:1.4.180
[info]   +-com.mchange:c3p0:0.9.5
[info]   | +-com.mchange:mchange-commons-java:0.2.9
...
```

"c3p0" shows up twice within the dependency tree. Unfortunately, different organizations are used for the two versions, so SBT cannot
evict the older version.

Fix Dependencies
----------------

The dependencies can be fixed by modifying the file "project/build.scala":

```
-  "com.enragedginger" %% "akka-quartz-scheduler" % "1.3.0-akka-2.3.x"
+  "com.enragedginger" %% "akka-quartz-scheduler" % "1.3.0-akka-2.3.x" exclude("c3p0","c3p0")
```

Basically, you have to add ' exclude("c3p0","c3p0")' to the dependency "akka-quartz-scheduler".
