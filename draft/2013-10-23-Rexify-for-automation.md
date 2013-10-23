---
layout: post
title: Rexify for automation
date: 2013-10-23 11:26:06
categories:
	- rex
	- perl
---
### Introduction
A tool based on perl to automate many task with deployment or server constructor. There are other similar tools like puppet or vargant but I think it is the best choice if you are fimilar with perl. You can also extend it with many perl modules from cpan. So it is worthy to give a try to reduce your routine job by using **Rex** .
### Example
Create a script file called **Rexfile** with content like this.  

``` perl
user "user";
sudo_password "pass";
 
desc "Get Disk Free";
task "test_sample", sub {
	say 'Start install new package';
	sudo sub {
		install 'patch gcc-c++ patch readline-devel libyaml-devel libffi-devel libtool bison perl-ExtUtils-MakeMaker curl';
	};
};
```

Then execute the following command in the same directory with Rexfile.  

```
rex -H 192.168.6.188 -u user -p pass test_sample
```  

OK, the command line above means perform the task called **test_sample** on host 192.168.6.188 with user **user** and password **password**. The task is defined in the rexfile. In this example, this task will yum the package we want with sudo. Also we can do many other things...  

Execution Command  

``` bash
run 'ls -al'
```

File Editing  

``` bash
my $fh;
eval {
	$fh = file_append("/home/rd/.bashrc");
};
$fh->write("[[ -s \"\$HOME/.rvm/scripts/rvm\" ]] && source \"\$HOME/.rvm/scripts/rvm\"\n");
```

File Creating based on Template

``` perl
my $data_content = template("templates/etc/database.tpl", 
	username => "redmine", 
	password => 'redmine'
);
file "/home/rd/redmine-2.3/config/database.yml", content => $data_content;
```

Sed

``` bash
sed qr{lang = STDIN.gets.chomp!}, "lang = 'en'", "/home/rd/redmine-2.3/lib/tasks/load_default_data.rake";
```

Change own or group

``` bash
chown "rd", "/home/rd/passenger.te";
chgrp "rd", "/home/rd/passenger.pp";
```

### Reference
1. [Offical site of Rex](http://rexify.org/)
