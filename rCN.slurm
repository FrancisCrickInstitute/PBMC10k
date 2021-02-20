

processing file: ClusterFinder.module.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |....                                                                  |   6%
   inline R code fragments

  |                                                                              |........                                                              |  11%
label: setup (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |............                                                          |  17%
  ordinary text without R code

  |                                                                              |................                                                      |  22%
label: init (with options) 
List of 3
 $ eval  : symbol F
 $ echo  : symbol T
 $ engine: chr "bash"

  |                                                                              |...................                                                   |  28%
  ordinary text without R code

  |                                                                              |.......................                                               |  33%
label: populate_meta_data_database (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol F
 $ results: symbol F

── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
✔ ggplot2 3.3.2     ✔ purrr   0.3.4
✔ tibble  3.0.1     ✔ dplyr   1.0.0
✔ tidyr   1.1.0     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.5.0
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
Loading required package: S4Vectors
Loading required package: stats4
Loading required package: BiocGenerics
Loading required package: parallel

Attaching package: 'BiocGenerics'

The following objects are masked from 'package:parallel':

    clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    clusterExport, clusterMap, parApply, parCapply, parLapply,
    parLapplyLB, parRapply, parSapply, parSapplyLB

The following objects are masked from 'package:dplyr':

    combine, intersect, setdiff, union

The following objects are masked from 'package:stats':

    IQR, mad, sd, var, xtabs

The following objects are masked from 'package:base':

    anyDuplicated, append, as.data.frame, basename, cbind, colnames,
    dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
    grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
    order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
    rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
    union, unique, unsplit, which, which.max, which.min


Attaching package: 'S4Vectors'

The following objects are masked from 'package:dplyr':

    first, rename

The following object is masked from 'package:tidyr':

    expand

The following object is masked from 'package:base':

    expand.grid

Loading required package: IRanges

Attaching package: 'IRanges'

The following objects are masked from 'package:dplyr':

    collapse, desc, slice

The following object is masked from 'package:purrr':

    reduce

Loading required package: GenomicRanges
Loading required package: GenomeInfoDb
Loading required package: SummarizedExperiment
Loading required package: Biobase
Welcome to Bioconductor

    Vignettes contain introductory material; view with
    'browseVignettes()'. To cite Bioconductor, see
    'citation("Biobase")', and for packages 'citation("pkgname")'.

Loading required package: DelayedArray
Loading required package: matrixStats

Attaching package: 'matrixStats'

The following objects are masked from 'package:Biobase':

    anyMissing, rowMedians

The following object is masked from 'package:dplyr':

    count

Loading required package: BiocParallel

Attaching package: 'DelayedArray'

The following objects are masked from 'package:matrixStats':

    colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges

The following object is masked from 'package:purrr':

    simplify

The following objects are masked from 'package:base':

    aperm, apply, rowsum


Attaching package: 'SummarizedExperiment'

The following object is masked from 'package:Seurat':

    Assays

  |                                                                              |...........................                                           |  39%
  ordinary text without R code

  |                                                                              |...............................                                       |  44%
label: PCA_UMAP_tSNE (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
12:13:31 UMAP embedding parameters a = 0.9922 b = 1.112
12:13:31 Read 7117 rows and found 20 numeric columns
12:13:31 Using Annoy for neighbor search, n_neighbors = 30
12:13:31 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
12:13:34 Writing NN index file to temp file /tmp/slurm_21271820/RtmpidmQY8/filee3743da80a62
12:13:34 Searching Annoy index using 1 thread, search_k = 3000
12:13:36 Annoy recall = 100%
12:13:37 Commencing smooth kNN distance calibration using 1 thread
12:13:39 Initializing from normalized Laplacian + noise
12:13:39 Commencing optimization for 500 epochs, with 291476 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
12:14:11 Optimization finished
Computing nearest neighbor graph
Computing SNN
  |                                                                              |...................................                                   |  50%
  ordinary text without R code

  |                                                                              |.......................................                               |  56%
label: populate_expr_database_1 (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol F
 $ results: symbol F

0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Registered S3 method overwritten by 'treeio':
  method     from
  root.phylo ape 
ggtree v1.16.6  For help: https://yulab-smu.github.io/treedata-book/

If you use ggtree in published research, please cite the most appropriate paper(s):

[36m-[39m Guangchuang Yu, Tommy Tsan-Yuk Lam, Huachen Zhu, Yi Guan. Two methods for mapping and visualizing associated data on phylogeny using ggtree. Molecular Biology and Evolution 2018, 35(12):3041-3043. doi: 10.1093/molbev/msy194
[36m-[39m Guangchuang Yu, David Smith, Huachen Zhu, Yi Guan, Tommy Tsan-Yuk Lam. ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. Methods in Ecology and Evolution 2017, 8(1):28-36, doi:10.1111/2041-210X.12628



Attaching package: 'ggtree'

The following object is masked from 'package:IRanges':

    collapse

The following object is masked from 'package:S4Vectors':

    expand

The following object is masked from 'package:tidyr':

    expand

0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
Finished averaging integrated for cluster 25
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
Finished averaging integrated for cluster 25
Finished averaging integrated for cluster 26
Finished averaging integrated for cluster 27
Finished averaging integrated for cluster 28
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
Finished averaging integrated for cluster 25
Finished averaging integrated for cluster 26
Finished averaging integrated for cluster 27
Finished averaging integrated for cluster 28
Finished averaging integrated for cluster 29
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
Finished averaging integrated for cluster 25
Finished averaging integrated for cluster 26
Finished averaging integrated for cluster 27
Finished averaging integrated for cluster 28
Finished averaging integrated for cluster 29
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging integrated for cluster 0
Finished averaging integrated for cluster 1
Finished averaging integrated for cluster 2
Finished averaging integrated for cluster 3
Finished averaging integrated for cluster 4
Finished averaging integrated for cluster 5
Finished averaging integrated for cluster 6
Finished averaging integrated for cluster 7
Finished averaging integrated for cluster 8
Finished averaging integrated for cluster 9
Finished averaging integrated for cluster 10
Finished averaging integrated for cluster 11
Finished averaging integrated for cluster 12
Finished averaging integrated for cluster 13
Finished averaging integrated for cluster 14
Finished averaging integrated for cluster 15
Finished averaging integrated for cluster 16
Finished averaging integrated for cluster 17
Finished averaging integrated for cluster 18
Finished averaging integrated for cluster 19
Finished averaging integrated for cluster 20
Finished averaging integrated for cluster 21
Finished averaging integrated for cluster 22
Finished averaging integrated for cluster 23
Finished averaging integrated for cluster 24
Finished averaging integrated for cluster 25
Finished averaging integrated for cluster 26
Finished averaging integrated for cluster 27
Finished averaging integrated for cluster 28
Finished averaging integrated for cluster 29
Finished averaging integrated for cluster 30
Finished averaging integrated for cluster 31
Finished averaging integrated for cluster 32
  |                                                                              |...........................................                           |  61%
   inline R code fragments

  |                                                                              |...............................................                       |  67%
label: Plot_tsne_data_plotting (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...................................................                   |  72%
  ordinary text without R code

  |                                                                              |......................................................                |  78%
label: AUC_prep_from_file (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

Quantiles for the number of genes detected by cell: 
(Non-detected genes are shuffled at the end of the ranking. Keep it in mind when choosing the threshold for calculating the AUC).
  |                                                                              |..........................................................            |  83%
   inline R code fragments

  |                                                                              |..............................................................        |  89%
label: enrichment_plots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................................    |  94%
  ordinary text without R code

  |                                                                              |......................................................................| 100%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T


output file: ClusterFinder.module.knit.md

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS ClusterFinder.module.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/malanchii/nicolas.rabas/422_scRNAseq_liver_4T1/workdir/html_local/ClusterFinder.module.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable 'theme:paper' --include-in-header /tmp/slurm_21271820/RtmpidmQY8/rmarkdown-stre37472d60bfc.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/malanchii/nicolas.rabas/422_scRNAseq_liver_4T1/workdir/html_local/ClusterFinder.module.html
Warning messages:
1: In FindVariableFeatures.Assay(object = assay.data, selection.method = selection.method,  :
  selection.method set to 'vst' but count slot is empty; will use data slot instead
2: In eval(predvars, data, env) : NaNs produced
3: In hvf.info$variance.expected[not.const] <- 10^fit$fitted :
  number of items to replace is not a multiple of replacement length
4: Using `as.character()` on a quosure is deprecated as of rlang 0.3.0.
Please use `as_label()` or `as_name()` instead.
This warning is displayed once per session. 
5: `data_frame()` is deprecated as of tibble 1.1.0.
Please use `tibble()` instead.
This warning is displayed once every 8 hours.
Call `lifecycle::last_warnings()` to see where this warning was generated. 
6: `mutate_()` is deprecated as of dplyr 0.7.0.
Please use `mutate()` instead.
See vignette('programming') for more help
This warning is displayed once every 8 hours.
Call `lifecycle::last_warnings()` to see where this warning was generated. 
7: In block_exec(params) :
  Failed to tidy R code in chunk 'AUC_prep_from_file'. Reason:
Error in base::parse(text = code, keep.source = FALSE) : 
  <text>:11:1: unexpected symbol
10: stringsAsFactors = F
11: invisible
    ^

