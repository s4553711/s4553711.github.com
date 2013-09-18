---
layout: post
title: BWA performance benchmark
date: 2013-09-18 16:51:28
categories:
	- Bioinformatics
	- Bwa
---
Objection
===
I recently learned about some NGS techniques and find the most important steps are sequence alignment and de novo assembly.
The Bwa and Bowtie are both very popular choice in this field so I will start from bwa. Here is some tests I have done.

### Problems
When I was compiling Bwa, some error message came up.
> bam_tview_curses.c:5:20: fatal error: curses.h: No such file or directory
It mean that you have to install libncurses5-dev
``` bash
sudo apt-get install libncurses5-dev
```

Some errors are about the sse2 support, so I add the **-msse2** to CFLAG in configure

### Test Machine
- VM: Core i7-2900 @ 3.4GHz, 3954 Ram
- Dev: ntel(R) Xeon(R) CPU X5670@ 2.93GHz, 96735 Ram

### Test Data
- Index
	- [main] Real time: 169.073 sec; CPU: 146.793 sec (my vm)
	- [main] Real time: 206.512 sec; CPU: 203.299 sec (dev)
- Align with MEM
	- Real time: 25.229 sec; CPU: 21.173 sec (my vm)
	- Real time: 22.795 sec; CPU: 21.885 sec (dev)
	- Real time: 13.739 sec; CPU: 23.481 sec (dev 2 threads)
	- Real time: 7.749 sec; CPU: 23.182 sec (dev 4 threads)
	- Real time: 4.891 sec; CPU: 24.171 sec (dev 8 threads)
	- Real time: 3.945 sec; CPU: 29.117 sec (dev 16 threads)
- Align with aln
	- Real time: 33.600 sec; CPU: 29.070 sec (my vm)
	- Real time: 31.259 sec; CPU: 31.201 sec (dev)
	- Real time: 18.859 sec; CPU: 34.206 sec (dev 2 threads)
	- Real time: 9.952 sec; CPU: 34.614 sec (dev 4 threads)
	- Real time: 5.563 sec; CPU: 35.721 sec (dev 8 threads)
	- Real time: 4.048 sec; CPU: 42.602 sec (dev 16 threads)
- Generate alignments in the SAM
	- Real time: 8.590 sec; CPU: 1.364 sec (my vm)
	- Real time: 2.201 sec; CPU: 1.404 sec (dev)

![Performance](http://i.imgur.com/V5QaDUd.png)

### Reference
[Manual of Bwa](http://bio-bwa.sourceforge.net/bwa.shtml)
