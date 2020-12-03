

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
Finished averaging RNA for cluster M1
Finished averaging RNA for cluster M4
Finished averaging RNA for cluster M5
Finished averaging RNA for cluster M6
Finished averaging RNA for cluster M7
Finished averaging RNA for cluster M8
Finished averaging SCT for cluster M1
Finished averaging SCT for cluster M4
Finished averaging SCT for cluster M5
Finished averaging SCT for cluster M6
Finished averaging SCT for cluster M7
Finished averaging SCT for cluster M8
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
Finished averaging RNA for cluster M1
Finished averaging RNA for cluster M4
Finished averaging RNA for cluster M5
Finished averaging RNA for cluster M6
Finished averaging RNA for cluster M7
Finished averaging RNA for cluster M8
Finished averaging SCT for cluster M1
Finished averaging SCT for cluster M4
Finished averaging SCT for cluster M5
Finished averaging SCT for cluster M6
Finished averaging SCT for cluster M7
Finished averaging SCT for cluster M8
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

Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
19:45:00 UMAP embedding parameters a = 0.9922 b = 1.112
19:45:00 Read 3520 rows and found 20 numeric columns
19:45:00 Using Annoy for neighbor search, n_neighbors = 30
19:45:00 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
19:45:01 Writing NN index file to temp file /tmp/slurm_19526080/RtmpWDGfQF/filea72279fc8023
19:45:01 Searching Annoy index using 30 threads, search_k = 3000
19:45:02 Annoy recall = 100%
19:45:03 Commencing smooth kNN distance calibration using 30 threads
19:45:06 Initializing from normalized Laplacian + noise
19:45:06 Commencing optimization for 500 epochs, with 144114 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
19:45:21 Optimization finished
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


Attaching package: 'scales'

The following object is masked from 'package:purrr':

    discard

The following object is masked from 'package:readr':

    col_factor

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
Finished averaging RNA for cluster C_3_mliGlia
Finished averaging RNA for cluster C_2_mliGlia
Finished averaging RNA for cluster C_1_mliGlia
Finished averaging RNA for cluster C_5_mliGlia
Finished averaging RNA for cluster C_0_mliGlia
Finished averaging RNA for cluster C_8_mliGlia
Finished averaging RNA for cluster C_10_mliGlia
Finished averaging RNA for cluster C_11_mliGlia
Finished averaging RNA for cluster C_13_mliGlia
Finished averaging RNA for cluster C_6_mliGlia
Finished averaging RNA for cluster C_12_mliGlia
Finished averaging RNA for cluster C_7_mliGlia
Finished averaging RNA for cluster C_4_mliGlia
Finished averaging RNA for cluster C_9_mliGlia
Finished averaging RNA for cluster C_8_mliNeuron
Finished averaging RNA for cluster C_4_mliNeuron
Finished averaging RNA for cluster C_11_mliNeuron
Finished averaging RNA for cluster C_9_mliNeuron
Finished averaging RNA for cluster C_12_mliNeuron
Finished averaging RNA for cluster C_1_mliNeuron
Finished averaging RNA for cluster C_10_mliNeuron
Finished averaging RNA for cluster C_3_mliNeuron
Finished averaging RNA for cluster C_6_mliNeuron
Finished averaging RNA for cluster C_2_mliNeuron
Finished averaging RNA for cluster C_0_mliNeuron
Finished averaging RNA for cluster C_7_mliNeuron
Finished averaging RNA for cluster C_5_mliNeuron
Finished averaging RNA for cluster C_13_mliNeuron
Finished averaging SCT for cluster C_3_mliGlia
Finished averaging SCT for cluster C_2_mliGlia
Finished averaging SCT for cluster C_1_mliGlia
Finished averaging SCT for cluster C_5_mliGlia
Finished averaging SCT for cluster C_0_mliGlia
Finished averaging SCT for cluster C_8_mliGlia
Finished averaging SCT for cluster C_10_mliGlia
Finished averaging SCT for cluster C_11_mliGlia
Finished averaging SCT for cluster C_13_mliGlia
Finished averaging SCT for cluster C_6_mliGlia
Finished averaging SCT for cluster C_12_mliGlia
Finished averaging SCT for cluster C_7_mliGlia
Finished averaging SCT for cluster C_4_mliGlia
Finished averaging SCT for cluster C_9_mliGlia
Finished averaging SCT for cluster C_8_mliNeuron
Finished averaging SCT for cluster C_4_mliNeuron
Finished averaging SCT for cluster C_11_mliNeuron
Finished averaging SCT for cluster C_9_mliNeuron
Finished averaging SCT for cluster C_12_mliNeuron
Finished averaging SCT for cluster C_1_mliNeuron
Finished averaging SCT for cluster C_10_mliNeuron
Finished averaging SCT for cluster C_3_mliNeuron
Finished averaging SCT for cluster C_6_mliNeuron
Finished averaging SCT for cluster C_2_mliNeuron
Finished averaging SCT for cluster C_0_mliNeuron
Finished averaging SCT for cluster C_7_mliNeuron
Finished averaging SCT for cluster C_5_mliNeuron
Finished averaging SCT for cluster C_13_mliNeuron
Finished averaging integrated for cluster C_3_mliGlia
Finished averaging integrated for cluster C_2_mliGlia
Finished averaging integrated for cluster C_1_mliGlia
Finished averaging integrated for cluster C_5_mliGlia
Finished averaging integrated for cluster C_0_mliGlia
Finished averaging integrated for cluster C_8_mliGlia
Finished averaging integrated for cluster C_10_mliGlia
Finished averaging integrated for cluster C_11_mliGlia
Finished averaging integrated for cluster C_13_mliGlia
Finished averaging integrated for cluster C_6_mliGlia
Finished averaging integrated for cluster C_12_mliGlia
Finished averaging integrated for cluster C_7_mliGlia
Finished averaging integrated for cluster C_4_mliGlia
Finished averaging integrated for cluster C_9_mliGlia
Finished averaging integrated for cluster C_8_mliNeuron
Finished averaging integrated for cluster C_4_mliNeuron
Finished averaging integrated for cluster C_11_mliNeuron
Finished averaging integrated for cluster C_9_mliNeuron
Finished averaging integrated for cluster C_12_mliNeuron
Finished averaging integrated for cluster C_1_mliNeuron
Finished averaging integrated for cluster C_10_mliNeuron
Finished averaging integrated for cluster C_3_mliNeuron
Finished averaging integrated for cluster C_6_mliNeuron
Finished averaging integrated for cluster C_2_mliNeuron
Finished averaging integrated for cluster C_0_mliNeuron
Finished averaging integrated for cluster C_7_mliNeuron
Finished averaging integrated for cluster C_5_mliNeuron
Finished averaging integrated for cluster C_13_mliNeuron
Centering and scaling data matrix
Finished averaging RNA for cluster C_0
Finished averaging RNA for cluster C_1
Finished averaging RNA for cluster C_10
Finished averaging RNA for cluster C_11
Finished averaging RNA for cluster C_12
Finished averaging RNA for cluster C_13
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
Finished averaging SCT for cluster C_13
Finished averaging SCT for cluster C_2
Finished averaging SCT for cluster C_3
Finished averaging SCT for cluster C_4
Finished averaging SCT for cluster C_5
Finished averaging SCT for cluster C_6
Finished averaging SCT for cluster C_7
Finished averaging SCT for cluster C_8
Finished averaging SCT for cluster C_9
Finished averaging integrated for cluster C_0
Finished averaging integrated for cluster C_1
Finished averaging integrated for cluster C_10
Finished averaging integrated for cluster C_11
Finished averaging integrated for cluster C_12
Finished averaging integrated for cluster C_13
Finished averaging integrated for cluster C_2
Finished averaging integrated for cluster C_3
Finished averaging integrated for cluster C_4
Finished averaging integrated for cluster C_5
Finished averaging integrated for cluster C_6
Finished averaging integrated for cluster C_7
Finished averaging integrated for cluster C_8
Finished averaging integrated for cluster C_9
Centering and scaling data matrix
Finished averaging RNA for cluster mliGlia
Finished averaging RNA for cluster mliNeuron
Finished averaging SCT for cluster mliGlia
Finished averaging SCT for cluster mliNeuron
Finished averaging integrated for cluster mliGlia
Finished averaging integrated for cluster mliNeuron
Centering and scaling data matrix
  |                                                                              |..................                                                    |  26%
  ordinary text without R code

  |                                                                              |...................                                                   |  27%
label: Plot_dimred_by_cluster_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

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

Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C9
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
Calculating cluster 13
  |                                                                              |...................                                                   |  28%
   inline R code fragments

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
   inline R code fragments

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
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, CKS2, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, TUBB4B, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C9
  |                                                                              |...........................                                           |  38%
   inline R code fragments

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

`summarise()` ungrouping output (override with `.groups` argument)
  |                                                                              |..............................                                        |  42%
   inline R code fragments

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
  |                                                                              |................................                                      |  46%
   inline R code fragments

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
   inline R code fragments

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
   inline R code fragments

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
label: CellTypePlot_dataprep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F


Registered S3 method overwritten by 'enrichplot':
  method               from
  fortify.enrichResult DOSE
clusterProfiler v3.12.0  For help: https://guangchuangyu.github.io/software/clusterProfiler

If you use clusterProfiler in published research, please cite:
Guangchuang Yu, Li-Gen Wang, Yanyan Han, Qing-Yu He. clusterProfiler: an R package for comparing biological themes among gene clusters. OMICS: A Journal of Integrative Biology. 2012, 16(5):284-287.

Attaching package: 'clusterProfiler'

The following object is masked from 'package:DelayedArray':

    simplify

The following object is masked from 'package:purrr':

    simplify

Loading required package: GSEABase
Loading required package: annotate
Loading required package: AnnotationDbi

Attaching package: 'AnnotationDbi'

The following object is masked from 'package:dplyr':

    select

Loading required package: XML
Loading required package: graph

Attaching package: 'graph'

The following object is masked from 'package:XML':

    addNode

The following object is masked from 'package:stringr':

    boundary

--> No gene can be mapped....
--> Expected input gene ID: Arrb1,Sp140,Fcgr2b,Tnfrsf13b,Nr4a3,Ncf2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: LOC100043921,Gm12407,Mmp12,Bend5,Siglec1,Abcb4
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Gpr97,Csf1,Hpgds,Tnfsf14,Ear5,Birc3
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Il1rl1,H2-Aa,Slc12a8,Slc12a1,Adamdec1,Lamp3
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Pla2g7,Ugt1a10,Siglec1,Igsf6,Sell,Tec
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Cd80,Pla2g7,Scn9a,Depdc5,Ltb,Stap1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Crybb1,Gm2023,Smpdl3b,Cd40,Prg2,Aif1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Adamdec1,Tlr7,Slc15a3,Aif1,Tnfrsf4,Gpr97
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Hhex,Slc15a3,Ncf2,Ccl17,Frk,D830031N03Rik
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Ccr7,Sell,Ptgir,Cd27,Fam198b,Treml2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Zfp286,Clec4a2,Cd79b,Epn2,Ear5,Rsad2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: LOC100043918,Ifi44l,Blk,Nme8,LOC100043918,Slc15a3
--> return NULL...
  |                                                                              |............................................                          |  63%
   inline R code fragments

  |                                                                              |.............................................                         |  64%
label: CellTypePlot (with options) 
List of 4
 $ echo   : logi TRUE
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
   inline R code fragments

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
   inline R code fragments

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
   inline R code fragments

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
   inline R code fragments

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

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartB_Analysis.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output sc_PartB_Analysis.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_19526080/RtmpWDGfQF/rmarkdown-stra722179ce5a8.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: sc_PartB_Analysis.html
There were 50 or more warnings (use warnings() to see the first 50)
