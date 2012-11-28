---
layout: post
title: PHP with MSSQL
date: 2012-10-25 21:32:58
summary: This article illustrate how to setup MSSQL enviroment in the Linux with freetds and unixodbc and connect MSSQL with perl.
categories:
	- PHP
	- unixODBC
	- FreeTDS
---
Using MSSQL with PHP and Codeigniter
======
Setup for FreeTDS and PHP
------
1. Freetds 

	Edit /etc/freetds.conf

		[MSSQL]
		host = dbhost
		port = 1433
		client charset = UTF-8
		tds version = 8.0

2. Test with tsql

	 tsql -S server_host -U username -P passwd

3. Codeigniter

	Edit config/database.php

		$db['default']['hostname'] = 'MSSQL';
		$db['default']['username'] = 'USER';
		$db['default']['password'] = 'PASSWD';
		$db['default']['database'] = 'DataBaseName';
		$db['default']['dbdriver'] = 'mssql';

3. It is all done. Now get ready to connect database with modle as usual.

Setup for ODBC
------
1. odbcinst.ini

	Edit /etc/odbcinst.ini and your conf file should look like this.

		[FreeTDS]
		Description     = MSSQL
		Driver      = /usr/lib/libtdsodbc.so.0
		Setup       = /usr/lib/libtdsS.so.2
		Driver64        = /usr/lib64/libtdsodbc.so.0
		Setup64     = /usr/lib64/libtdsS.so.2
		FileUsage       = 5
		UsageCount      = 3

2. test with "odbcinst -q -d"

	The result will be like this

		[PostgreSQL]
		[MySQL]
		[FreeTDS]


3. odbc.ini

	Edit /etc/odbc.conf or ~/.odbc.ini

		[MSSQL]
		Driver = FreeTDS
		Description = MSSQL
		Trace = No
		Server = dbhost
		Database = BioInfo
		TDS_Version = 8.0
		Port = 1433
		UID = UserID

4. test with "odbcinst -q -s"

		[MSSQL]

5. test with osql

	Exexute the following statement: "osql -S MSSQL -U BIT -P BITBIT". This program will test your setting and tell you the result. If your configuration is success, this program will end up with isql execution result.

		Configuration looks OK.  Connection details:
		
		                   DSN: MSSQL
		              odbc.ini: /home/user/.odbc.ini
		                Driver: /usr/lib/libtdsodbc.so.0
		       Server hostname: dbhostw
		               Address: 1.1.1.1
		
		Attempting connection as UserID ...
		+ isql MSSQL UserID Passwd -v
		+---------------------------------------+
		| Connected!                            |
		|                                       |
		| sql-statement                         |
		| help [tablename]                      |
		| quit                                  |
		|                                       |
		+---------------------------------------+
		SQL> 

6. test with perl

		#!/usr/bin/perl
		use DBI;
		
		$dsn = "DBI:ODBC:MSSQL";
		$dbh = DBI->connect($dsn, 'UserID', 'Password');
		
		$sth = $dbh->prepare("SQL");

Reference
------

- [Gheek.net](http://gheeknet.wordpress.com/2011/10/13/perl-to-microsoft-sql-server-2008-standard-via-odbc-using-freetds-drivers/)
- [FreeTDS User Guide](http://freetds.schemamania.org/userguide/odbcdiagnose.htm)  
