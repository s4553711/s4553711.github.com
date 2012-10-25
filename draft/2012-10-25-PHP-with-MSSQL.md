---
layout: post
title: PHP with MSSQL
date: 2012-10-25 21:32:58
categories:
---
Using MSSQL with PHP and Codeigniter
======
Setup
------
1. Freetds 

	Edit /etc/freetds.conf

		[MSSQL]
		host = db01
		port = 1433
		client charset = UTF-8
		tds version = 8.0

2. Codeigniter

	Edit config/database.php

		$db['default']['hostname'] = 'MSSQL';
		$db['default']['username'] = 'USER';
		$db['default']['password'] = 'PASSWD';
		$db['default']['database'] = 'DataBaseName';
		$db['default']['dbdriver'] = 'mssql';

3. It is all done. Now get ready to connect database with modle as usual.
