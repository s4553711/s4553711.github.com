---
layout: post
title: Some note about DBIX::Class
date: 2012-12-10 10:25:05
categories:
	-	perl
	-	DBIx::Class
---
Basic
======
Connection
------
It is a example of using SQL server. The first argument can be changed to another DSN you want.  

	$schema = Tool::DB::ORM::GeneTex::Bio->connect(
		"DBI:ODBC:driver={SQL Server};Server=db;Database=database;UID=UID;PWD=PID",
		{	
			LongReadLen => 0,
			LongTruncOk => 1
		}
	);


Select
------
- By search  

	my $rs $schema->resultset('PJ')->search({
		key1 => 'abc',
		key2 => 'def'
	});
	while(my $entity = $rs->next){
		print $entity->column;
	}

- By find  

	This statement will find the data with the primary key equal to "abc"

	my $entity = $schema->resultset('PJ')->find('abc');
	print $entity->column;

Update
------
We can set the data with another value and update to database by this way.  

	$entity->set_column('column1','abc2');
	if ($entity->is_changed){
		$entity->update();
	}

Insert
------

	my $ad = $schema->resultset('ResultSet_you_choose')->create(
		{
			Accn => 'data1'
		}
	);
	$ad->update();

Debug
------
There are several ways to show debug info

	$schema->storage->debug(1);
	or
	export DBIC_TRACE=1

Also you can print out the connect info like this

	$schema->storage->connect_info;

