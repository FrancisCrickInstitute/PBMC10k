

processing file: sc_PartB_Analysis.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   1%
  ordinary text without R code

  |                                                                              |.                                                                     |   2%
label: setup (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |..                                                                    |   3%
  ordinary text without R code

  |                                                                              |...                                                                   |   4%
label: init (with options) 
List of 3
 $ eval  : symbol F
 $ echo  : symbol T
 $ engine: chr "bash"

  |                                                                              |....                                                                  |   5%
  ordinary text without R code

  |                                                                              |....                                                                  |   6%
label: dbpwd (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol F

  |                                                                              |.....                                                                 |   7%
  ordinary text without R code

  |                                                                              |......                                                                |   8%
label: set_directories (with options) 
List of 1
 $ eval: symbol T


Attaching package: 'dplyr'

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
✔ tibble  3.0.1     ✔ purrr   0.3.4
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

The following object is masked from 'package:tidyr':

    expand

The following objects are masked from 'package:dplyr':

    first, rename

The following object is masked from 'package:base':

    expand.grid

Loading required package: IRanges

Attaching package: 'IRanges'

The following object is masked from 'package:purrr':

    reduce

The following objects are masked from 'package:dplyr':

    collapse, desc, slice

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

  |                                                                              |......                                                                |   9%
  ordinary text without R code

  |                                                                              |.......                                                               |  10%
label: CreateReferenceGeneList (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Loading required package: DBI
  |                                                                              |........                                                              |  11%
  ordinary text without R code

  |                                                                              |.........                                                             |  12%
label: Normalize_Subset_Find_Variable (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
  |                                                                              |.........                                                             |  13%
  ordinary text without R code

  |                                                                              |..........                                                            |  14%
label: create-individual-varFeatures (with options) 
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
Finished averaging RNA for cluster all
Finished averaging SCT for cluster all
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Finished averaging RNA for cluster S
Finished averaging SCT for cluster S
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
  |                                                                              |...........                                                           |  15%
  ordinary text without R code

  |                                                                              |............                                                          |  16%
label: create-var-feature-plot-II (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |............                                                          |  18%
  ordinary text without R code

  |                                                                              |.............                                                         |  19%
label: PCA_UMAP_tSNE (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
11:02:35 UMAP embedding parameters a = 0.9922 b = 1.112
11:02:35 Read 1940 rows and found 20 numeric columns
11:02:35 Using Annoy for neighbor search, n_neighbors = 30
11:02:35 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:02:35 Writing NN index file to temp file /tmp/slurm_19073551/RtmpoAPePZ/file2b276bbedc7c
11:02:35 Searching Annoy index using 1 thread, search_k = 3000
11:02:36 Annoy recall = 100%
11:02:37 Commencing smooth kNN distance calibration using 1 thread
11:02:38 Initializing from normalized Laplacian + noise
11:02:38 Commencing optimization for 500 epochs, with 78222 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:02:45 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |..............                                                        |  20%
  ordinary text without R code

  |                                                                              |..............                                                        |  21%
label: Plot_tsne_data_rendering (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...............                                                       |  22%
  ordinary text without R code

  |                                                                              |................                                                      |  23%
label: Plot_tsne_data_plotting (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.................                                                     |  24%
  ordinary text without R code

  |                                                                              |.................                                                     |  25%
label: Identify differential expressed genes across conditions (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

Finished averaging RNA for cluster all
Finished averaging SCT for cluster all
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
Finished averaging RNA for cluster C_1_S
Finished averaging RNA for cluster C_2_S
Finished averaging RNA for cluster C_6_S
Finished averaging RNA for cluster C_3_S
Finished averaging RNA for cluster C_10_S
Finished averaging RNA for cluster C_0_S
Finished averaging RNA for cluster C_8_S
Finished averaging RNA for cluster C_5_S
Finished averaging RNA for cluster C_7_S
Finished averaging RNA for cluster C_4_S
Finished averaging RNA for cluster C_9_S
Finished averaging RNA for cluster C_11_S
Finished averaging RNA for cluster C_12_S
Finished averaging SCT for cluster C_1_S
Finished averaging SCT for cluster C_2_S
Finished averaging SCT for cluster C_6_S
Finished averaging SCT for cluster C_3_S
Finished averaging SCT for cluster C_10_S
Finished averaging SCT for cluster C_0_S
Finished averaging SCT for cluster C_8_S
Finished averaging SCT for cluster C_5_S
Finished averaging SCT for cluster C_7_S
Finished averaging SCT for cluster C_4_S
Finished averaging SCT for cluster C_9_S
Finished averaging SCT for cluster C_11_S
Finished averaging SCT for cluster C_12_S
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
Finished averaging RNA for cluster C_0
Finished averaging RNA for cluster C_1
Finished averaging RNA for cluster C_10
Finished averaging RNA for cluster C_11
Finished averaging RNA for cluster C_12
Finished averaging RNA for cluster C_2
Finished averaging RNA for cluster C_3
Finished averaging RNA for cluster C_4
Finished averaging RNA for cluster C_5
Finished averaging RNA for cluster C_6
Finished averaging RNA for cluster C_7
Finished averaging RNA for cluster C_8
Finished averaging RNA for cluster C_9
Finished averaging SCT for cluster C_0
Finished averaging SCT for cluster C_1
Finished averaging SCT for cluster C_10
Finished averaging SCT for cluster C_11
Finished averaging SCT for cluster C_12
Finished averaging SCT for cluster C_2
Finished averaging SCT for cluster C_3
Finished averaging SCT for cluster C_4
Finished averaging SCT for cluster C_5
Finished averaging SCT for cluster C_6
Finished averaging SCT for cluster C_7
Finished averaging SCT for cluster C_8
Finished averaging SCT for cluster C_9
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
Finished averaging RNA for cluster S
Finished averaging SCT for cluster S
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
  |                                                                              |..................                                                    |  26%
  ordinary text without R code

  |                                                                              |...................                                                   |  27%
label: Plot_dimred_by_cluster_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE


Attaching package: 'scales'

The following object is masked from 'package:purrr':

    discard

The following object is masked from 'package:readr':

    col_factor

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

Finished averaging RNA for cluster 0
Finished averaging RNA for cluster 1
Finished averaging RNA for cluster 2
Finished averaging RNA for cluster 3
Finished averaging RNA for cluster 4
Finished averaging RNA for cluster 5
Finished averaging RNA for cluster 6
Finished averaging RNA for cluster 7
Finished averaging RNA for cluster 8
Finished averaging RNA for cluster 9
Finished averaging RNA for cluster 10
Finished averaging RNA for cluster 11
Finished averaging RNA for cluster 12
Calculating cluster 0
Calculating cluster 1
Calculating cluster 2
Calculating cluster 3
Calculating cluster 4
Calculating cluster 5
Calculating cluster 6
Calculating cluster 7
Calculating cluster 8
Calculating cluster 9
Calculating cluster 10
Calculating cluster 11
Calculating cluster 12
  |                                                                              |...................                                                   |  28%
  ordinary text without R code

  |                                                                              |....................                                                  |  29%
label: Plot_dim_red_by_cluster (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.....................                                                 |  30%
  ordinary text without R code

  |                                                                              |......................                                                |  31%
label: Plot_umap_sleepwalk (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

Estimating 'maxdist' for feature matrix 1
  |                                                                              |......................                                                |  32%
  ordinary text without R code

  |                                                                              |.......................                                               |  33%
label: doublet-data (with options) 
List of 5
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE
 $ message: logi FALSE

  |                                                                              |........................                                              |  34%
  ordinary text without R code

  |                                                                              |.........................                                             |  35%
label: doublet-plot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.........................                                             |  36%
  ordinary text without R code

  |                                                                              |..........................                                            |  37%
label: Plot_dimred_by_cell_cycle_phase_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Warning: The following features are not present in the object: MCM5, PCNA, TYMS, FEN1, MCM2, MCM4, RRM1, UNG, GINS2, MCM6, CDCA7, DTL, PRIM1, UHRF1, MLF1IP, HELLS, RFC2, RPA2, NASP, RAD51AP1, GMNN, WDR76, SLBP, CCNE2, UBR7, POLD3, MSH2, ATAD2, RAD51, RRM2, CDC45, CDC6, EXO1, TIPIN, DSCC1, BLM, CASP8AP2, USP1, CLSPN, POLA1, CHAF1B, BRIP1, E2F8, not searching for symbol synonyms
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
Finished averaging RNA for cluster 0
Finished averaging RNA for cluster 1
Finished averaging RNA for cluster 2
Finished averaging RNA for cluster 3
Finished averaging RNA for cluster 4
Finished averaging RNA for cluster 5
Finished averaging RNA for cluster 6
Finished averaging RNA for cluster 7
Finished averaging RNA for cluster 8
Finished averaging RNA for cluster 9
Finished averaging RNA for cluster 10
Finished averaging RNA for cluster 11
Finished averaging RNA for cluster 12
  |                                                                              |...........................                                           |  38%
  ordinary text without R code

  |                                                                              |...........................                                           |  39%
label: Plot_dim_red_by_cell_cycle_phase (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |............................                                          |  40%
  ordinary text without R code

  |                                                                              |.............................                                         |  41%
label: make_percent_N_cells_barchart (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..............................                                        |  42%
  ordinary text without R code

  |                                                                              |..............................                                        |  43%
label: plot_barchart (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...............................                                       |  44%
  ordinary text without R code

  |                                                                              |................................                                      |  45%
label: AUC_prep_from_file (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Quantiles for the number of genes detected by cell: 
(Non-detected genes are shuffled at the end of the ranking. Keep it in mind when choosing the threshold for calculating the AUC).
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
  |                                                                              |................................                                      |  46%
  ordinary text without R code

  |                                                                              |.................................                                     |  47%
label: enrichment_plots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................                                    |  48%
  ordinary text without R code

  |                                                                              |...................................                                   |  49%
label: data_pre_linear_regression (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...................................                                   |  51%
  ordinary text without R code

  |                                                                              |....................................                                  |  52%
label: plot_linear_regression (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.....................................                                 |  53%
  ordinary text without R code

  |                                                                              |......................................                                |  54%
label: Cluster_overview_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Scale for 'fill' is already present. Adding another scale for 'fill', which
will replace the existing scale.
Scale for 'fill' is already present. Adding another scale for 'fill', which
will replace the existing scale.
Coordinate system already present. Adding new coordinate system, which will replace the existing one.
  |                                                                              |......................................                                |  55%
  ordinary text without R code

  |                                                                              |.......................................                               |  56%
label: Cluster_overview (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |........................................                              |  57%
  ordinary text without R code

  |                                                                              |........................................                              |  58%
label: ClusterTable_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"


Attaching package: 'DT'

The following object is masked from 'package:Seurat':

    JS

  |                                                                              |.........................................                             |  59%
  ordinary text without R code

  |                                                                              |..........................................                            |  60%
label: render_ClusterTable (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...........................................                           |  61%
  ordinary text without R code

  |                                                                              |...........................................                           |  62%
label: create-markdown-enrichment-chunks-prepare-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |............................................                          |  63%
  ordinary text without R code

  |                                                                              |.............................................                         |  64%
label: create-markdown-enrichment-chunks-dynamically (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............................................                         |  65%
  ordinary text without R code

  |                                                                              |..............................................                        |  66%
label: MakeHM (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...............................................                       |  67%
  ordinary text without R code

  |                                                                              |................................................                      |  68%
label: calculate-markdown-heatmap-chunks-dynamically (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |................................................                      |  69%
  ordinary text without R code

  |                                                                              |.................................................                     |  70%
label: ExampleFeaturePlot_dataprep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................                    |  71%
  ordinary text without R code

  |                                                                              |...................................................                   |  72%
label: ExampleFeaturePlot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...................................................                   |  73%
  ordinary text without R code

  |                                                                              |....................................................                  |  74%
label: elbow_plot (with options) 
List of 3
 $ fig.height: num 6
 $ fig.width : num 10
 $ fig.cap   : language paste0("**Figure, ", figureCount, ": Elbowplot** Variance explained per PCA dimension")

  |                                                                              |.....................................................                 |  75%
  ordinary text without R code

  |                                                                              |.....................................................                 |  76%
label: PCA_dataprep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |......................................................                |  77%
  ordinary text without R code

  |                                                                              |.......................................................               |  78%
label: plot_PCADimPlots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |........................................................              |  79%
  ordinary text without R code

  |                                                                              |........................................................              |  80%
label: pca_boxplot_dataprep (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |.........................................................             |  81%
  ordinary text without R code

  |                                                                              |..........................................................            |  82%
label: pca_boxplot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..........................................................            |  84%
  ordinary text without R code

  |                                                                              |...........................................................           |  85%
label: create-pca-enrichment-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Welcome to enrichR
Checking connection ... Connection is Live!
  |                                                                              |............................................................          |  86%
  ordinary text without R code

  |                                                                              |.............................................................         |  87%
label: create-pca-enrichment-plot (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............................................................         |  88%
  ordinary text without R code

  |                                                                              |..............................................................        |  89%
label: pseudotime-enrichment-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F


Attaching package: 'destiny'

The following object is masked from 'package:SummarizedExperiment':

    distance

The following object is masked from 'package:GenomicRanges':

    distance

The following object is masked from 'package:IRanges':

    distance

  |                                                                              |...............................................................       |  90%
  ordinary text without R code

  |                                                                              |................................................................      |  91%
label: pseudotime-plot (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |................................................................      |  92%
  ordinary text without R code

  |                                                                              |.................................................................     |  93%
label: Additional tables (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |..................................................................    |  94%
  ordinary text without R code

  |                                                                              |..................................................................    |  95%
label: saveobject (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |...................................................................   |  96%
  ordinary text without R code

  |                                                                              |....................................................................  |  97%
label: create_report_params (with options) 
List of 2
 $ eval   : symbol T
 $ results: chr "asis"

  |                                                                              |..................................................................... |  98%
  ordinary text without R code

  |                                                                              |..................................................................... |  99%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T

  |                                                                              |......................................................................| 100%
   inline R code fragments


output file: sc_PartB_Analysis.knit.md

/camp/apps/misc/stp/babs/conda/envs/R_deps/bin/pandoc +RTS -K512m -RTS sc_PartB_Analysis.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output sc_PartB_Analysis.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_19073551/RtmpoAPePZ/rmarkdown-str2b2740e5a284.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 
File sc_PartB_Analysis_files/figure-html/varplot_Integrated_Samples-1.png not found in resource path
Error: pandoc document conversion failed with error 99
In addition: There were 50 or more warnings (use warnings() to see the first 50)
Execution halted
