---
layout: post
title: Perl-Plack
date: 2012-10-04 21:36:59
categories:
	- perl
---
Perl-Plack Setup
======

The following steps will lead you to run a simple PSGI program at port 5000 and use the nginx as reverse proxy 
to pass the connecton from http://domain.name/plack to PSGI service at http://domain.name:5000

Nginx Setup
------
- edit /etc/nginx/conf.d/default.conf and add the following statement

		location /plack {
			proxy_pass http://127.0.0.1:5000/;
		}

- restart nginx

		/etc/rc.d/init.d/nginx restart

Plack Setup
------
- Install Plack with cpanm

		cpanm Task::Plack

- Create plack.psgi

<script src="https://gist.github.com/3833600.js?file=gistfile1.pl"></script>

- Running the program

		plackup plack.psgi

- Data Source  
	- [Plack](http://plackperl.org/)  
	- [Nginx for reverse proxy](http://www.arthurtoday.com/2010/07/nginx-apache-reverse-proxy-server.html#.UG2L2E2miCg)
