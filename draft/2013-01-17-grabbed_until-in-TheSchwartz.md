---
layout: post
title: grabbed_until in TheSchwartz 
date: 2013-01-17 15:17:39
categories:
	-	perl
	-	TheSchwartz
---
Some problems about job retstart
------
When I was trying to restart a submitted job that has been interrupted by myself, it did not restart it as it claimed. Because I can not get more information on its CPAN page, so I decided to trace the source code and found out it.

First, I went into the TheSchwartz.pm and find the **work** subroutine and found it indeeded search for job queued in the database at the line 280 (subroutine **find_job_for_workers**). The comment of this subroutine explained how it works:

1. funcname is in the list of abilities this $client supports;
2. the job is scheduled to be run (run_after is in the past);
3. no one else is working on the job (grabbed_until is in the past).

According to its rule, I found the problem is arised from the **grabbed_unitl**. It seems that as someone called this worker(as I did before), this job would not to be called within 1 hours(I guessed). So in order to call the interrupted job any time I want, I decided to marked line 283 at the TheSchwartz.pm until I found a better solution to do it.
