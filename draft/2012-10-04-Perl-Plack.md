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

A Simple Mojo Tutorial
======
The following content comes from [mojolicious::lite doc](http://mojolicio.us/perldoc/Mojolicious/Lite).

Install mojolicious
------

		curl get.mojolicio.us | sh

A simple Code
------

		#!/usr/bin/perl
		use Mojolicious::Lite;

		get '/:foo' => sub {
			my $self = shift;
			my $foo = $self->param('foo');
			$self->render(text=>"This is $foo");
		}

Execute  
------
	- morbo app.pl
	- app.pl daemon

	But it is more convenient to start with morbo because it can automatically reload the program while you are updaing your program in the development stage.

Some functions
------
- GET/POST:  
	You can use $self->param('user') to get the GET/POST parameter. There are also [other ways](http://mojolicio.us/perldoc/Mojolicious/Controller#param) to get it too  

		# Get
		get '/data' => sub {
			my @values = $self->param;  
			my ($foo, $bar) = $c->param(['foo', 'bar']);
		}
		# Post
		post '/post' => sub {
			..
		}

- Stash:
	Set the variables and use it in the template. First I set the variables one and associated the template file.

		$data = $self->param('data');
		$self->stash(one=>$data);
		$self->render(template=>'tem',format=>'html');

	For more info about function render, you can find it in [this page](http://search.cpan.org/~sri/Mojolicious-3.44/lib/Mojolicious/Guides/Rendering.pod). Also if you want to know the detail of its syntax in the template file, please visit [this page](http://mojolicio.us/perldoc/Mojolicious/Guides/Rendering#Embedded_Perl).

	In the [offical tutorial](http://mojolicio.us/perldoc/Mojolicious/Lite#Stash_and_templates), you can see that the template is embeded in the pl source code. I seperate it and fill the html content in the templates/tem.html.ep so you can find the template like this ..
			
		<%= %one %>

- HTTP Header  
	Set the header  

		$self->res->headers->header('X-Header' => 'X-Header');

	Get the header info  

		$self->req->headers->user_agent;
 
- Layouts  
	Mojo provide the layouts that you can organize your template. Here is a example of tem.html.ep.

		% title 'This is a Title';
		% layout 'header';
		<h1><%= $format %></h1>
		<h1><%= $one %></h1>
		<ul>
			<li>User Agent: <%= $user_agent %></li>
		</ul>

	This template file use a layout named "header.html.ep" which defined in the foleder "layouts/header.html.ep". And your header.html.ep may look like this.

		<!DOCTYPE html>
		<html>
		<head>
			<meta http-equiv="content-type" content="text/html; charset=utf-8">
			<title><%= title %></title>
		</head>
		<body><%= content %></body>
		</html>

	So that the "<%= content %>" will be replaced with the content of tem.html.ep. There is more detail [Here](http://mojolicio.us/perldoc/Mojolicious/Guides/Rendering#Layouts)

- Logging  
	A glimpse of log. First you have to create a log folder and put this line in your program.

		app->log->level('debug');

	Also you can call it by yourself.

		$self->app->log->info('tem example is called');

	[More detail at Mojo::Log](http://mojolicio.us/perldoc/Mojo/Log)

Mojo with Plack
======
Run it
------
I find the mojo app can run without changing any code. you can do this..

		plackup app.pl

Also you can use plack as middleware and wrap your program like this.

		use Plack::Builder;
		get '/welcome' => sub {
			..
		}
		builder {
			enable 'Deflater';
			app->start;
		}

[Here is more detail](http://mojolicio.us/perldoc/Mojolicious/Guides/Cookbook#PSGIPlack)
