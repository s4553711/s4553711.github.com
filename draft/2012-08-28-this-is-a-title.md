---
layout: post
title: this is a title
date: 2012-08-28 22:28:16
categories: [pubmed]
---

PubMed資料收集
======
PubMed之Reference數目
------
1. 需求
    - Gmetrics之Reference數目統計

            (EGFR [title/abstract] or EGFR antibody [title/abstract]) AND 2020/01/01 [Publication Date]: 2020/12/31 [Publication Date]

1. 檔案
    - 格式
        - C#
    - 名稱
        - pubmed\_tot_tool.cs

2. Input格式
    - GeneID
    - Symbol

3. Output格式
    - GeneID
    - Symbol
    - Reference Number

4. 執行

        % grun.exe input.txt
5. 編譯

        % gmcs pubmed_tot_tool.cs ../utility/proxy.cs ../bio/PubMed.cs -out:gcount.exe -r:System.dll -r:System.Data.dll

