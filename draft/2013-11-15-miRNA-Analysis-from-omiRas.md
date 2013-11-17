---
layout: post
title: miRNA Analysis from omiRas
date: 2013-11-15 16:10:40
categories:
	- bioinformatics
	- RNA
---
# Thoughts

今天下午看到另一個miRNA的differential expression分析的服務，叫做omiRas，稍微研究一下他的[Workflow](http://tools.genxpro.net/omiras/)也跟我們的做一個比較。  

![WorkFlow](http://i.imgur.com/TdW5zrt.png)

# omiRas
## Simple Steps

- Read pre-processing  
	這部份其實跟miRDeep2做的事情是差不多的，把adapter拿掉b然後把重複的Sequence清一清，最後再拿Bowtie把資料mapping到genome上面，找mirdeep2的mapper.pl就可以做類似的事情。第4步是annotation及normalization，關於normalization我不熟，可能要再看paper一下。Quantification則是把mapping到非coding區域的reads拿給mirDeep2做De Novel預測，並且把所有表現的資料整理mapping的資訊及分佈，給下一步differential expression分析用  
- Combination of expression results and differential expression  
	有表現的ncRNAs會被拿去DEseq做分析，產生differential expression的結果  
- Visualization
	就是顯示結果

與我目前的單位比較，其實大家做的事情勢差不多的，但是我們是直接將Differential expression及miRNA分析這兩塊獨立開來。用來Differential expression的分析工具我也不是很確定，但應該是tophat及cufflinks。

## Expression Result  
[Expression Table](http://tools.genxpro.net/omiras/0be30597ffef/results/expression/a/Wt_r1_fastq/)  
[Mapping Statistics](http://tools.genxpro.net/omiras/0be30597ffef/results/plots/a/Wt_r1_fastq/)  

Mappng Statistics會顯示RNA的區域(Intergenic, intronic, exonic, ncRNA)及ncRNA的種類比例(premiRNA, tRNA, rRNA, snoRNA, scRNA),這部份在我們的pipeline並沒有(雖然有mapping到genome的資訊,但是對於mapping annotation的表示我們就沒有再進一步顯示)。Sequence Length Distribution則是基本的檢驗read的依據,所以大家都一樣。Expression Table就差不多了,只是他們還有計算normalized_mapping_loci這項數據，我想應該是把read出現在不同loci的次數作normalization。

之前一直在想還需要再加上些什麼分析，現在看來其實做的事情都大同小異，只是怎樣把這些大家都需要的工具做良好的安排及包裝，方便大家使用。或許之後可以把differential expression及miRNA的pipeline結果合併顯示，不知道這樣會不會比較有幫助些。

# Refs
[Paper](http://bioinformatics.oxfordjournals.org/content/early/2013/08/23/bioinformatics.btt457.abstract)
