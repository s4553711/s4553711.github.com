---
layout: post
title: Redmine sync with git repository
date: 2013-10-24 23:20:02
categories:
	- git
---
Before start
---
This is not the best solution for me but now I could only combine redmine and gitolite in this way. I have found there are some plugins which can integrate the gitolite into redmine but it does not meet my condition. My goal is just to have separate redmine website and git server and link the redmine repo information to the gitolite. Below is the solution according to [this article](http://www.redmine.org/projects/redmine/wiki/HowTo_keep_in_sync_your_git_repository_for_redmine)

Step by Step
---
First, setup a mirror of your gitolite repository

``` bash
$ git clone --mirror git@domain.com:project.git
```

Then fetch all update

``` bash
$ cd project.git
$ git fetch -q --all
```

Keep your mirror sync with your gitolite repo

```
$ sudo vi /etc/cron.d/sync_git_repos
*/5 * * * * user cd /path/to/project.git && git fetch -q --all
```

Ok, everything is ready. Now we just go to redmine project setting panel and set your repo path to the mirror repo. The system crontab job will keep update the mirror repo with the gitolite repo.
