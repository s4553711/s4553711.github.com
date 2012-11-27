---
layout: post
title: Create empty branches
date: 2012-11-27 19:09:33
categories:
	- git
---
Create Empty branch without parent
======
Originally we can do it with:

		git checkout --orphan version2

But if the git version < 1.7.2, we have to do this with another way

		git symbolic-ref HEAD refs/heads/newbranch 
		rm .git/index 
		git clean -fdx 
		..
		..
		git add your files 
		git commit -m 'Initial commit'

Data Source:  

- [StackOverflow](http://stackoverflow.com/questions/5689960/how-do-i-create-a-commit-without-a-parent-in-git)
- [shacon](http://schacon.github.com/gitbook/5_creating_new_empty_branches.html)  
