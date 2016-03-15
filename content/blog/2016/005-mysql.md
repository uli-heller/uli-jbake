title=MySQL: Einige Handhabungshinweise
date=2016-03-12
type=post
tags=ubuntu
status=published
~~~~~~

MySQL: Einige Handhabungshinweise
=================================

Sicherung erstellen
-------------------

```
$ mysqldump --all-databases -p >/data/backup/mysql_20160312.dump
Enter password: XXX
$
```

Sicherung einspielen
--------------------

```
$ mysql -p
Enter password: XXX
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| owncloud           |
| performance_schema |
+--------------------+
mysql> drop database owncloud;
Query OK, 43 rows affected (0.54 sec)
mysql> exit
Bye
$ mysql -p </data/backup/mysql_20160312.dump
Enter password: XXX
$
```
