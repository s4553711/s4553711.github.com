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

``` perl
my $schema = Tool::DB::ORM::GeneTex::Bio->connect(
	"DBI:ODBC:driver={SQL Server};Server=db;Database=database;UID=UID;PWD=PID",
	{	
		LongReadLen => 0,
		LongTruncOk => 1
	}
);
```

Select
------
- By search  

	``` perl
	my $rs = $schema->resultset('PJ')->search({
		key1 => 'abc',
		key2 => 'def'
	});
	while(my $entity = $rs->next){
		print $entity->column;
	}
	```
- By find  

	This statement will find the data with the primary key equal to "abc"

	``` perl
	my $entity = $schema->resultset('PJ')->find('abc');
	print $entity->column;
	```

Update
------
We can set the data with another value and update to database by this way.  

``` perl
$entity->set_column('column1','abc2');
if ($entity->is_changed){
	$entity->update();
}
```
Insert
------

``` perl
my $ad = $schema->resultset('ResultSet_you_choose')->create(
	{
		Accn => 'data1'
	}
);
$ad->update();
```

Debug
------
There are several ways to show debug info

``` perl
$schema->storage->debug(1);
or
export DBIC_TRACE=1
```

Also you can print out the connect info like this

``` perl
$schema->storage->connect_info;
```

More WHERE Clauses
------
- OR

	``` perl
	Field => [1,2]
	```

- Combined AND/OR

	``` perl
	{
		Institution => {'!=' => [undef,''] },
		-or => [
			city => [undef,''],
			state => [undef,'']
		]
	},
	```

- NOT

	``` perl
	Field => { '!=' => 'ABC'}
	```

- DISTINCT

	``` perl
	{},{
		columns => [qw/FieldA FieldB/],
		distinct => 1
	}
	```

- Sub-query

	Defined the sub-query statement

	``` perl	
	my $collection = $job->search(
		{
			fieldA => 1,
		},
		{
			distinct => 1,
			columns => [qw/ID/]
		}
	);
	```

	Execution the main query statement within the result of sub-query

	``` perl
	my $final_list = $job->search(
		{
			ID => {
				'-in' => $collection->get_column('ID')->as_query
			}
		},
		{
			distinct => 1,
			columns => [qw/ID/]
		},
	);
	```

For more information, please refer to [SQL::Abstract](http://search.cpan.org/perldoc?SQL%3A%3AAbstract#WHERE_CLAUSES)
