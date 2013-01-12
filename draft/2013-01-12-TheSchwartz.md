---
layout: post
title: TheSchwartz
date: 2013-01-12 18:01:42
categories:
	- perl
	- ThsSchwartz
---
TheSchwartz Setup
======
Install Program
------
- Using cpanm to install in the path ~/perl5

		cpanm install TheSchwartz --local-lib=~/perl5

- Database Setup

		CREATE TABLE funcmap (
		        funcid         INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
		        funcname       VARCHAR(255) NOT NULL,
		        UNIQUE(funcname)
		);

		CREATE TABLE job (
		        jobid           BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
		        funcid          INT UNSIGNED NOT NULL,
		        arg             MEDIUMBLOB,
		        uniqkey         VARCHAR(255) NULL,
		        insert_time     INTEGER UNSIGNED,
		        run_after       INTEGER UNSIGNED NOT NULL,
		        grabbed_until   INTEGER UNSIGNED NOT NULL,
		        priority        SMALLINT UNSIGNED,
		        coalesce        VARCHAR(255),
		        INDEX (funcid, run_after),
		        UNIQUE(funcid, uniqkey),
		        INDEX (funcid, coalesce)
		);

		CREATE TABLE note (
		        jobid           BIGINT UNSIGNED NOT NULL,
		        notekey         VARCHAR(255),
		        PRIMARY KEY (jobid, notekey),
		        value           MEDIUMBLOB
		);

		CREATE TABLE error (
		        error_time      INTEGER UNSIGNED NOT NULL,
		        jobid           BIGINT UNSIGNED NOT NULL,
		        message         VARCHAR(255) NOT NULL,
		        funcid          INT UNSIGNED NOT NULL DEFAULT 0,
		        INDEX (funcid, error_time),
		        INDEX (error_time),
		        INDEX (jobid)
		);

		CREATE TABLE exitstatus (
		        jobid           BIGINT UNSIGNED PRIMARY KEY NOT NULL,
		        funcid          INT UNSIGNED NOT NULL DEFAULT 0,
		        status          SMALLINT UNSIGNED,
		        completion_time INTEGER UNSIGNED,
		        delete_after    INTEGER UNSIGNED,
		        INDEX (funcid),
		        INDEX (delete_after)
		);

Usage
------
- First Running

	This worker is name by Myworker. When this worker is called, this program will print out the jobid and funcid of this process.
	You can also send a arguemnts to MyWorker and use $job->arg to receive the argument.

		package MyWorker;
		use Data::Dumper;
		use base qw(TheSchwartz::Worker TheSchwartz::Job);  
		
		sub work {
		    my $class = shift;
		    my TheSchwartz::Job $job = shift;
		    print "Log> Get Work ID: ".$job->jobid.", function id: ".$job->funcid."\n";
		    $job->completed();
		}   
 
		package main;
		use base qw(TheSchwartz);
		my $client = TheSchwartz->new( databases =>
			[
				{
					dsn => 'dbi:mysql:db_schwartz;host=localhost',
					user => 'root',
					pass => 'pass',
				}   
			] );
		$client->can_do('MyWorker');
		$client->work();

	Here is a example of job submitted. This program will send a argument (arrayref) to the worker and receive by worker **MyWorker**

		#!/usr/bin/perl
		use base qw(TheSchwartz TheSchwartz::Job);
		my $client = TheSchwartz->new( databases =>
			[
				{
					dsn => 'dbi:mysql:db_schwartz;host=localhost',
					user => 'root',
					pass => 'pass',
				}
			] );
		
		my $job = TheSchwartz::Job->new_from_array('MyWorker', [ foo => 'bar' ]);
		$client->insert($job);

Reference
------
1. [TheSchwartz](http://wiki.dwscoalition.org/wiki/index.php/TheSchwartz)
2. [CPAN](http://search.cpan.org/~sixapart/TheSchwartz-1.10/lib/TheSchwartz.pm)
