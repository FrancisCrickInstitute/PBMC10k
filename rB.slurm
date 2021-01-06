

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
 $ echo  : symbol F
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

Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms

Attaching package: 'future'

The following object is masked from 'package:SummarizedExperiment':

    values

The following object is masked from 'package:GenomicRanges':

    values

The following object is masked from 'package:IRanges':

    values

The following object is masked from 'package:S4Vectors':

    values

Warning: Adding a command log without an assay associated with it
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
14:55:45 UMAP embedding parameters a = 0.9922 b = 1.112
14:55:45 Read 1116 rows and found 20 numeric columns
14:55:45 Using Annoy for neighbor search, n_neighbors = 30
14:55:45 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:55:45 Writing NN index file to temp file /tmp/slurm_20102158/RtmpEn74Xm/file23f97a2e147d
14:55:45 Searching Annoy index using 30 threads, search_k = 3000
14:55:45 Annoy recall = 100%
14:55:46 Commencing smooth kNN distance calibration using 30 threads
14:55:48 Initializing from normalized Laplacian + noise
14:55:48 Commencing optimization for 500 epochs, with 41878 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:55:52 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms

Attaching package: 'future'

The following object is masked from 'package:SummarizedExperiment':

    values

The following object is masked from 'package:GenomicRanges':

    values

The following object is masked from 'package:IRanges':

    values

The following object is masked from 'package:S4Vectors':

    values

Warning: Adding a command log without an assay associated with it
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:57:15 UMAP embedding parameters a = 0.9922 b = 1.112
14:57:15 Read 1116 rows and found 20 numeric columns
14:57:15 Using Annoy for neighbor search, n_neighbors = 30
14:57:15 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:57:15 Writing NN index file to temp file /tmp/slurm_20102158/RtmpEn74Xm/file23f9420fc50a
14:57:15 Searching Annoy index using 30 threads, search_k = 3000
14:57:15 Annoy recall = 100%
14:57:16 Commencing smooth kNN distance calibration using 30 threads
14:57:18 Initializing from normalized Laplacian + noise
14:57:18 Commencing optimization for 500 epochs, with 42010 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:57:23 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms

Attaching package: 'future'

The following object is masked from 'package:SummarizedExperiment':

    values

The following object is masked from 'package:GenomicRanges':

    values

The following object is masked from 'package:IRanges':

    values

The following object is masked from 'package:S4Vectors':

    values

Warning: Adding a command log without an assay associated with it
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:58:50 UMAP embedding parameters a = 0.9922 b = 1.112
14:58:50 Read 1116 rows and found 20 numeric columns
14:58:50 Using Annoy for neighbor search, n_neighbors = 30
14:58:50 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:58:51 Writing NN index file to temp file /tmp/slurm_20102158/RtmpEn74Xm/file23f93b9e7b91
14:58:51 Searching Annoy index using 30 threads, search_k = 3000
14:58:51 Annoy recall = 100%
14:58:52 Commencing smooth kNN distance calibration using 30 threads
14:58:53 Initializing from normalized Laplacian + noise
14:58:53 Commencing optimization for 500 epochs, with 41934 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:58:57 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc45, Dscc1, Rrm2, not searching for symbol synonyms
Warning: The following features are not present in the object: Cdc20, Dlgap5, Fam64a, Gtse1, Psrc1, not searching for symbol synonyms

Attaching package: 'future'

The following object is masked from 'package:SummarizedExperiment':

    values

The following object is masked from 'package:GenomicRanges':

    values

The following object is masked from 'package:IRanges':

    values

The following object is masked from 'package:S4Vectors':

    values

Warning: Adding a command log without an assay associated with it
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
Finished averaging integrated for cluster all
Centering and scaling data matrix
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
Finished averaging RNA for cluster mliGlia
Finished averaging SCT for cluster mliGlia
Centering and scaling data matrix
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
Finished averaging RNA for cluster mliNeuron
Finished averaging SCT for cluster mliNeuron
Centering and scaling data matrix
  |                                                                              |...........                                                           |  15%
   inline R code fragments

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

15:01:43 UMAP embedding parameters a = 0.9922 b = 1.112
15:01:43 Read 1116 rows and found 20 numeric columns
15:01:43 Using Annoy for neighbor search, n_neighbors = 30
15:01:43 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
15:01:43 Writing NN index file to temp file /tmp/slurm_20102158/RtmpEn74Xm/file23f97dbf620c
15:01:43 Searching Annoy index using 30 threads, search_k = 3000
15:01:43 Annoy recall = 100%
15:01:44 Commencing smooth kNN distance calibration using 30 threads
15:01:45 Initializing from normalized Laplacian + noise
15:01:45 Commencing optimization for 500 epochs, with 41934 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
15:01:49 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |..............                                                        |  20%
  ordinary text without R code

  |                                                                              |..............                                                        |  21%
label: data_prep_sample_UMAP_rendering (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

  |                                                                              |...............                                                       |  22%
   inline R code fragments

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
Finished averaging integrated for cluster all
Centering and scaling data matrix
Finished averaging RNA for cluster Glia1_GliaT_GliaT
Finished averaging RNA for cluster Glia1_NeuronT_GliaT
Finished averaging RNA for cluster Glia2_GliaT_GliaT
Finished averaging RNA for cluster Glia2_NeuronT_GliaT
Finished averaging RNA for cluster Glia3_GliaT_GliaT
Finished averaging RNA for cluster Glia3_NeuronT_GliaT
Finished averaging RNA for cluster N1_GliaT_GliaT
Finished averaging RNA for cluster N1_GliaT_NeuronT
Finished averaging RNA for cluster N1_NeuronT_NeuronT
Finished averaging RNA for cluster C4_GliaT_NeuronT
Finished averaging RNA for cluster C4_NeuronT_NeuronT
Finished averaging RNA for cluster C5_GliaT_NeuronT
Finished averaging RNA for cluster C5_NeuronT_NeuronT
Finished averaging RNA for cluster C6_GliaT_NeuronT
Finished averaging RNA for cluster C6_NeuronT_NeuronT
Finished averaging RNA for cluster N5_GliaT_NeuronT
Finished averaging RNA for cluster N5_NeuronT_NeuronT
Finished averaging RNA for cluster C8_GliaT_NeuronT
Finished averaging RNA for cluster C8_NeuronT_NeuronT
Finished averaging RNA for cluster C9_GliaT_NeuronT
Finished averaging RNA for cluster C9_NeuronT_NeuronT
Finished averaging SCT for cluster Glia1_GliaT_GliaT
Finished averaging SCT for cluster Glia1_NeuronT_GliaT
Finished averaging SCT for cluster Glia2_GliaT_GliaT
Finished averaging SCT for cluster Glia2_NeuronT_GliaT
Finished averaging SCT for cluster Glia3_GliaT_GliaT
Finished averaging SCT for cluster Glia3_NeuronT_GliaT
Finished averaging SCT for cluster N1_GliaT_GliaT
Finished averaging SCT for cluster N1_GliaT_NeuronT
Finished averaging SCT for cluster N1_NeuronT_NeuronT
Finished averaging SCT for cluster C4_GliaT_NeuronT
Finished averaging SCT for cluster C4_NeuronT_NeuronT
Finished averaging SCT for cluster C5_GliaT_NeuronT
Finished averaging SCT for cluster C5_NeuronT_NeuronT
Finished averaging SCT for cluster C6_GliaT_NeuronT
Finished averaging SCT for cluster C6_NeuronT_NeuronT
Finished averaging SCT for cluster N5_GliaT_NeuronT
Finished averaging SCT for cluster N5_NeuronT_NeuronT
Finished averaging SCT for cluster C8_GliaT_NeuronT
Finished averaging SCT for cluster C8_NeuronT_NeuronT
Finished averaging SCT for cluster C9_GliaT_NeuronT
Finished averaging SCT for cluster C9_NeuronT_NeuronT
Finished averaging integrated for cluster Glia1_GliaT_GliaT
Finished averaging integrated for cluster Glia1_NeuronT_GliaT
Finished averaging integrated for cluster Glia2_GliaT_GliaT
Finished averaging integrated for cluster Glia2_NeuronT_GliaT
Finished averaging integrated for cluster Glia3_GliaT_GliaT
Finished averaging integrated for cluster Glia3_NeuronT_GliaT
Finished averaging integrated for cluster N1_GliaT_GliaT
Finished averaging integrated for cluster N1_GliaT_NeuronT
Finished averaging integrated for cluster N1_NeuronT_NeuronT
Finished averaging integrated for cluster C4_GliaT_NeuronT
Finished averaging integrated for cluster C4_NeuronT_NeuronT
Finished averaging integrated for cluster C5_GliaT_NeuronT
Finished averaging integrated for cluster C5_NeuronT_NeuronT
Finished averaging integrated for cluster C6_GliaT_NeuronT
Finished averaging integrated for cluster C6_NeuronT_NeuronT
Finished averaging integrated for cluster N5_GliaT_NeuronT
Finished averaging integrated for cluster N5_NeuronT_NeuronT
Finished averaging integrated for cluster C8_GliaT_NeuronT
Finished averaging integrated for cluster C8_NeuronT_NeuronT
Finished averaging integrated for cluster C9_GliaT_NeuronT
Finished averaging integrated for cluster C9_NeuronT_NeuronT
Centering and scaling data matrix
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Finished averaging RNA for cluster Glia1
Finished averaging RNA for cluster Glia2
Finished averaging RNA for cluster Glia3
Finished averaging RNA for cluster N1
Finished averaging RNA for cluster N5
Finished averaging SCT for cluster C4
Finished averaging SCT for cluster C5
Finished averaging SCT for cluster C6
Finished averaging SCT for cluster C8
Finished averaging SCT for cluster C9
Finished averaging SCT for cluster Glia1
Finished averaging SCT for cluster Glia2
Finished averaging SCT for cluster Glia3
Finished averaging SCT for cluster N1
Finished averaging SCT for cluster N5
Finished averaging integrated for cluster C4
Finished averaging integrated for cluster C5
Finished averaging integrated for cluster C6
Finished averaging integrated for cluster C8
Finished averaging integrated for cluster C9
Finished averaging integrated for cluster Glia1
Finished averaging integrated for cluster Glia2
Finished averaging integrated for cluster Glia3
Finished averaging integrated for cluster N1
Finished averaging integrated for cluster N5
Centering and scaling data matrix
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Finished averaging RNA for cluster Glia1
Finished averaging RNA for cluster Glia2
Finished averaging RNA for cluster Glia3
Finished averaging RNA for cluster N1
Finished averaging RNA for cluster N5
Finished averaging RNA for cluster GliaT
Finished averaging RNA for cluster NeuronT
Finished averaging SCT for cluster GliaT
Finished averaging SCT for cluster NeuronT
Finished averaging integrated for cluster GliaT
Finished averaging integrated for cluster NeuronT
Centering and scaling data matrix
Finished averaging RNA for cluster GliaT
Finished averaging RNA for cluster NeuronT
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

Finished averaging RNA for cluster Glia1
Finished averaging RNA for cluster Glia2
Finished averaging RNA for cluster Glia3
Finished averaging RNA for cluster N1
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster N5
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Calculating cluster Glia1
Calculating cluster Glia2
Calculating cluster Glia3
Calculating cluster N1
Calculating cluster C4
Calculating cluster C5
Calculating cluster C6
Calculating cluster N5
Calculating cluster C8
Calculating cluster C9
Warning: No DE genes identified
Calculating cluster Glia1
Calculating cluster Glia2
Calculating cluster Glia3
Calculating cluster N1
Calculating cluster C4
Calculating cluster C5
Calculating cluster C6
Calculating cluster N5
Calculating cluster C8
Calculating cluster C9
Warning: No DE genes identified
Quitting from lines 2097-2809 (sc_PartB_Analysis.Rmd) 
Error in `[.data.frame`(dfGeneralMarkers, , c("gene", "cluster")) : 
  undefined columns selected
Calls: <Anonymous> ... withVisible -> eval -> eval -> unique -> [ -> [.data.frame
In addition: There were 50 or more warnings (use warnings() to see the first 50)

Execution halted
