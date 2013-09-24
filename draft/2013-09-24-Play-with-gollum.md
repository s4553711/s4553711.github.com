---
layout: post
title: Play with gollum
date: 2013-09-24 17:42:19
categories:
	- ruby
	- gollum
---
It is a github-like wiki system which use git as a version control system. The following steps are the quick start to create it.

### Install ###
1. First install rvm with ruby 1.9.3. (the ruby 2.0.0 will have problem with grit-2.5)
2. Install with gem. (this step may take a while)  
``` bash
$ gem install gollum
```
3. Create project folder and empty repo  
``` bash
$ mkdir wiki; cd wiki;
$ git init
```
4. Start program
``` bash
$ gollum
```
5. Open the **http://localhost:4567** with your browser and now you can start to edit the first wiki page.

### Reference ###
1. [Gollum](https://github.com/gollum/gollum)
2. [体验gollum](http://sailxjx.github.io/blog/blog/2012/07/12/ti-yan-gollum/)
3. [Issue about ruby-2.0.0 with grit-2.5.0](https://github.com/scttnlsn/dandelion/issues/31)
4. [RVM - Ruby enVironment (Version) Manager](http://www.openfoundry.org/tw/tech-column/8513-rvm-ruby-environment-version-manager)
