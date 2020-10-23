

processing file: template.singlecell.partB.Analysis_V1.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   1%
   inline R code fragments

  |                                                                              |..                                                                    |   2%
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

  |                                                                              |.....                                                                 |   7%
label: dbpwd (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol F

  |                                                                              |.....                                                                 |   8%
  ordinary text without R code

  |                                                                              |......                                                                |   9%
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

  |                                                                              |.......                                                               |  10%
  ordinary text without R code

  |                                                                              |........                                                              |  11%
label: CreateReferenceGeneList (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Loading required package: DBI
  |                                                                              |........                                                              |  12%
  ordinary text without R code

  |                                                                              |.........                                                             |  13%
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
  |                                                                              |..........                                                            |  14%
  ordinary text without R code

  |                                                                              |...........                                                           |  15%
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
Finished averaging RNA for cluster PD7_1
Finished averaging SCT for cluster PD7_1
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
Finished averaging RNA for cluster PD4_2
Finished averaging SCT for cluster PD4_2
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
Finished averaging RNA for cluster E18_5_1
Finished averaging SCT for cluster E18_5_1
Centering and scaling data matrix
  |                                                                              |...........                                                           |  16%
  ordinary text without R code

  |                                                                              |............                                                          |  17%
label: create-var-feature-plot-II (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............                                                         |  18%
  ordinary text without R code

  |                                                                              |..............                                                        |  20%
label: PCA_UMAP_tSNE (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: logi FALSE

Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
13:27:40 UMAP embedding parameters a = 0.9922 b = 1.112
13:27:40 Read 22804 rows and found 20 numeric columns
13:27:40 Using Annoy for neighbor search, n_neighbors = 30
13:27:40 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
13:27:48 Writing NN index file to temp file /tmp/slurm_18210347/Rtmp2Tx1XF/file14bf5472ca889
13:27:48 Searching Annoy index using 30 threads, search_k = 3000
13:27:50 Annoy recall = 100%
13:27:52 Commencing smooth kNN distance calibration using 30 threads
13:27:55 Initializing from normalized Laplacian + noise
13:27:58 Commencing optimization for 200 epochs, with 977710 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
13:28:38 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |..............                                                        |  21%
  ordinary text without R code

  |                                                                              |...............                                                       |  22%
label: Plot_tsne_data_rendering (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |................                                                      |  23%
  ordinary text without R code

  |                                                                              |.................                                                     |  24%
label: Plot_tsne_data_plotting (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................                                                    |  25%
  ordinary text without R code

  |                                                                              |..................                                                    |  26%
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
Finished averaging RNA for cluster 13
Finished averaging RNA for cluster 14
Finished averaging RNA for cluster 15
Finished averaging RNA for cluster 16
Finished averaging RNA for cluster 17
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
Calculating cluster 14
Calculating cluster 15
Calculating cluster 16
Calculating cluster 17
  |                                                                              |...................                                                   |  27%
  ordinary text without R code

  |                                                                              |....................                                                  |  28%
label: Plot_dim_red_by_cluster (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.....................                                                 |  29%
  ordinary text without R code

  |                                                                              |.....................                                                 |  30%
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

  |                                                                              |........................                                              |  35%
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
Finished averaging RNA for cluster 13
Finished averaging RNA for cluster 14
Finished averaging RNA for cluster 15
Finished averaging RNA for cluster 16
Finished averaging RNA for cluster 17
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

  |                                                                              |...............................                                       |  45%
  ordinary text without R code

  |                                                                              |................................                                      |  46%
label: Identify_cluster_marker (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ fig.cap: chr "**Figure 1:** tSNE"

  |                                                                              |.................................                                     |  47%
  ordinary text without R code

  |                                                                              |.................................                                     |  48%
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
  |                                                                              |..................................                                    |  49%
  ordinary text without R code

  |                                                                              |...................................                                   |  50%
label: enrichment_plots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |....................................                                  |  51%
  ordinary text without R code

  |                                                                              |.....................................                                 |  52%
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
  |                                                                              |.....................................                                 |  53%
  ordinary text without R code

  |                                                                              |......................................                                |  54%
label: Cluster_overview (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.......................................                               |  55%
  ordinary text without R code

  |                                                                              |........................................                              |  57%
label: ClusterTable_data_prep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"


Attaching package: 'DT'

The following object is masked from 'package:Seurat':

    JS

  |                                                                              |........................................                              |  58%
  ordinary text without R code

  |                                                                              |.........................................                             |  59%
label: render_ClusterTable (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..........................................                            |  60%
  ordinary text without R code

  |                                                                              |...........................................                           |  61%
label: create-markdown-enrichment-chunks-prepare-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...........................................                           |  62%
  ordinary text without R code

  |                                                                              |............................................                          |  63%
label: create-markdown-enrichment-chunks-dynamically (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............................................                         |  64%
  ordinary text without R code

  |                                                                              |..............................................                        |  65%
label: MakeHM (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..............................................                        |  66%
  ordinary text without R code

  |                                                                              |...............................................                       |  67%
label: calculate-markdown-heatmap-chunks-dynamically (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |................................................                      |  68%
  ordinary text without R code

  |                                                                              |.................................................                     |  70%
label: Identify differential expressed genes across conditions (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

Finished averaging RNA for cluster C_0_PD7_1
Finished averaging RNA for cluster C_4_PD7_1
Finished averaging RNA for cluster C_5_PD7_1
Finished averaging RNA for cluster C_1_PD7_1
Finished averaging RNA for cluster C_12_PD7_1
Finished averaging RNA for cluster C_10_PD7_1
Finished averaging RNA for cluster C_14_PD7_1
Finished averaging RNA for cluster C_8_PD7_1
Finished averaging RNA for cluster C_2_PD7_1
Finished averaging RNA for cluster C_9_PD7_1
Finished averaging RNA for cluster C_7_PD7_1
Finished averaging RNA for cluster C_3_PD7_1
Finished averaging RNA for cluster C_11_PD7_1
Finished averaging RNA for cluster C_6_PD7_1
Finished averaging RNA for cluster C_13_PD7_1
Finished averaging RNA for cluster C_16_PD7_1
Finished averaging RNA for cluster C_15_PD7_1
Finished averaging RNA for cluster C_17_PD7_1
Finished averaging RNA for cluster C_1_PD4_2
Finished averaging RNA for cluster C_4_PD4_2
Finished averaging RNA for cluster C_3_PD4_2
Finished averaging RNA for cluster C_8_PD4_2
Finished averaging RNA for cluster C_2_PD4_2
Finished averaging RNA for cluster C_11_PD4_2
Finished averaging RNA for cluster C_9_PD4_2
Finished averaging RNA for cluster C_0_PD4_2
Finished averaging RNA for cluster C_10_PD4_2
Finished averaging RNA for cluster C_12_PD4_2
Finished averaging RNA for cluster C_5_PD4_2
Finished averaging RNA for cluster C_13_PD4_2
Finished averaging RNA for cluster C_7_PD4_2
Finished averaging RNA for cluster C_6_PD4_2
Finished averaging RNA for cluster C_14_PD4_2
Finished averaging RNA for cluster C_16_PD4_2
Finished averaging RNA for cluster C_15_PD4_2
Finished averaging RNA for cluster C_17_PD4_2
Finished averaging RNA for cluster C_0_E18_5_1
Finished averaging RNA for cluster C_1_E18_5_1
Finished averaging RNA for cluster C_2_E18_5_1
Finished averaging RNA for cluster C_5_E18_5_1
Finished averaging RNA for cluster C_13_E18_5_1
Finished averaging RNA for cluster C_7_E18_5_1
Finished averaging RNA for cluster C_6_E18_5_1
Finished averaging RNA for cluster C_8_E18_5_1
Finished averaging RNA for cluster C_12_E18_5_1
Finished averaging RNA for cluster C_3_E18_5_1
Finished averaging RNA for cluster C_16_E18_5_1
Finished averaging RNA for cluster C_10_E18_5_1
Finished averaging RNA for cluster C_4_E18_5_1
Finished averaging RNA for cluster C_14_E18_5_1
Finished averaging RNA for cluster C_11_E18_5_1
Finished averaging RNA for cluster C_17_E18_5_1
Finished averaging RNA for cluster C_15_E18_5_1
Finished averaging RNA for cluster C_9_E18_5_1
Finished averaging SCT for cluster C_0_PD7_1
Finished averaging SCT for cluster C_4_PD7_1
Finished averaging SCT for cluster C_5_PD7_1
Finished averaging SCT for cluster C_1_PD7_1
Finished averaging SCT for cluster C_12_PD7_1
Finished averaging SCT for cluster C_10_PD7_1
Finished averaging SCT for cluster C_14_PD7_1
Finished averaging SCT for cluster C_8_PD7_1
Finished averaging SCT for cluster C_2_PD7_1
Finished averaging SCT for cluster C_9_PD7_1
Finished averaging SCT for cluster C_7_PD7_1
Finished averaging SCT for cluster C_3_PD7_1
Finished averaging SCT for cluster C_11_PD7_1
Finished averaging SCT for cluster C_6_PD7_1
Finished averaging SCT for cluster C_13_PD7_1
Finished averaging SCT for cluster C_16_PD7_1
Finished averaging SCT for cluster C_15_PD7_1
Finished averaging SCT for cluster C_17_PD7_1
Finished averaging SCT for cluster C_1_PD4_2
Finished averaging SCT for cluster C_4_PD4_2
Finished averaging SCT for cluster C_3_PD4_2
Finished averaging SCT for cluster C_8_PD4_2
Finished averaging SCT for cluster C_2_PD4_2
Finished averaging SCT for cluster C_11_PD4_2
Finished averaging SCT for cluster C_9_PD4_2
Finished averaging SCT for cluster C_0_PD4_2
Finished averaging SCT for cluster C_10_PD4_2
Finished averaging SCT for cluster C_12_PD4_2
Finished averaging SCT for cluster C_5_PD4_2
Finished averaging SCT for cluster C_13_PD4_2
Finished averaging SCT for cluster C_7_PD4_2
Finished averaging SCT for cluster C_6_PD4_2
Finished averaging SCT for cluster C_14_PD4_2
Finished averaging SCT for cluster C_16_PD4_2
Finished averaging SCT for cluster C_15_PD4_2
Finished averaging SCT for cluster C_17_PD4_2
Finished averaging SCT for cluster C_0_E18_5_1
Finished averaging SCT for cluster C_1_E18_5_1
Finished averaging SCT for cluster C_2_E18_5_1
Finished averaging SCT for cluster C_5_E18_5_1
Finished averaging SCT for cluster C_13_E18_5_1
Finished averaging SCT for cluster C_7_E18_5_1
Finished averaging SCT for cluster C_6_E18_5_1
Finished averaging SCT for cluster C_8_E18_5_1
Finished averaging SCT for cluster C_12_E18_5_1
Finished averaging SCT for cluster C_3_E18_5_1
Finished averaging SCT for cluster C_16_E18_5_1
Finished averaging SCT for cluster C_10_E18_5_1
Finished averaging SCT for cluster C_4_E18_5_1
Finished averaging SCT for cluster C_14_E18_5_1
Finished averaging SCT for cluster C_11_E18_5_1
Finished averaging SCT for cluster C_17_E18_5_1
Finished averaging SCT for cluster C_15_E18_5_1
Finished averaging SCT for cluster C_9_E18_5_1
Finished averaging integrated for cluster C_0_PD7_1
Finished averaging integrated for cluster C_4_PD7_1
Finished averaging integrated for cluster C_5_PD7_1
Finished averaging integrated for cluster C_1_PD7_1
Finished averaging integrated for cluster C_12_PD7_1
Finished averaging integrated for cluster C_10_PD7_1
Finished averaging integrated for cluster C_14_PD7_1
Finished averaging integrated for cluster C_8_PD7_1
Finished averaging integrated for cluster C_2_PD7_1
Finished averaging integrated for cluster C_9_PD7_1
Finished averaging integrated for cluster C_7_PD7_1
Finished averaging integrated for cluster C_3_PD7_1
Finished averaging integrated for cluster C_11_PD7_1
Finished averaging integrated for cluster C_6_PD7_1
Finished averaging integrated for cluster C_13_PD7_1
Finished averaging integrated for cluster C_16_PD7_1
Finished averaging integrated for cluster C_15_PD7_1
Finished averaging integrated for cluster C_17_PD7_1
Finished averaging integrated for cluster C_1_PD4_2
Finished averaging integrated for cluster C_4_PD4_2
Finished averaging integrated for cluster C_3_PD4_2
Finished averaging integrated for cluster C_8_PD4_2
Finished averaging integrated for cluster C_2_PD4_2
Finished averaging integrated for cluster C_11_PD4_2
Finished averaging integrated for cluster C_9_PD4_2
Finished averaging integrated for cluster C_0_PD4_2
Finished averaging integrated for cluster C_10_PD4_2
Finished averaging integrated for cluster C_12_PD4_2
Finished averaging integrated for cluster C_5_PD4_2
Finished averaging integrated for cluster C_13_PD4_2
Finished averaging integrated for cluster C_7_PD4_2
Finished averaging integrated for cluster C_6_PD4_2
Finished averaging integrated for cluster C_14_PD4_2
Finished averaging integrated for cluster C_16_PD4_2
Finished averaging integrated for cluster C_15_PD4_2
Finished averaging integrated for cluster C_17_PD4_2
Finished averaging integrated for cluster C_0_E18_5_1
Finished averaging integrated for cluster C_1_E18_5_1
Finished averaging integrated for cluster C_2_E18_5_1
Finished averaging integrated for cluster C_5_E18_5_1
Finished averaging integrated for cluster C_13_E18_5_1
Finished averaging integrated for cluster C_7_E18_5_1
Finished averaging integrated for cluster C_6_E18_5_1
Finished averaging integrated for cluster C_8_E18_5_1
Finished averaging integrated for cluster C_12_E18_5_1
Finished averaging integrated for cluster C_3_E18_5_1
Finished averaging integrated for cluster C_16_E18_5_1
Finished averaging integrated for cluster C_10_E18_5_1
Finished averaging integrated for cluster C_4_E18_5_1
Finished averaging integrated for cluster C_14_E18_5_1
Finished averaging integrated for cluster C_11_E18_5_1
Finished averaging integrated for cluster C_17_E18_5_1
Finished averaging integrated for cluster C_15_E18_5_1
Finished averaging integrated for cluster C_9_E18_5_1
Centering and scaling data matrix
Finished averaging RNA for cluster C_0
Finished averaging RNA for cluster C_1
Finished averaging RNA for cluster C_10
Finished averaging RNA for cluster C_11
Finished averaging RNA for cluster C_12
Finished averaging RNA for cluster C_13
Finished averaging RNA for cluster C_14
Finished averaging RNA for cluster C_15
Finished averaging RNA for cluster C_16
Finished averaging RNA for cluster C_17
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
Finished averaging SCT for cluster C_14
Finished averaging SCT for cluster C_15
Finished averaging SCT for cluster C_16
Finished averaging SCT for cluster C_17
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
Finished averaging integrated for cluster C_14
Finished averaging integrated for cluster C_15
Finished averaging integrated for cluster C_16
Finished averaging integrated for cluster C_17
Finished averaging integrated for cluster C_2
Finished averaging integrated for cluster C_3
Finished averaging integrated for cluster C_4
Finished averaging integrated for cluster C_5
Finished averaging integrated for cluster C_6
Finished averaging integrated for cluster C_7
Finished averaging integrated for cluster C_8
Finished averaging integrated for cluster C_9
Centering and scaling data matrix
Finished averaging RNA for cluster PD7_1
Finished averaging RNA for cluster PD4_2
Finished averaging RNA for cluster E18_5_1
Finished averaging SCT for cluster PD7_1
Finished averaging SCT for cluster PD4_2
Finished averaging SCT for cluster E18_5_1
Finished averaging integrated for cluster PD7_1
Finished averaging integrated for cluster PD4_2
Finished averaging integrated for cluster E18_5_1
Centering and scaling data matrix
  |                                                                              |.................................................                     |  71%
  ordinary text without R code

  |                                                                              |..................................................                    |  72%
label: ExampleFeaturePlot_dataprep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...................................................                   |  73%
  ordinary text without R code

  |                                                                              |....................................................                  |  74%
label: ExampleFeaturePlot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |....................................................                  |  75%
  ordinary text without R code

  |                                                                              |.....................................................                 |  76%
label: elbow_plot (with options) 
List of 3
 $ fig.height: num 6
 $ fig.width : num 10
 $ fig.cap   : language paste0("**Figure, ", figureCount, ": Elbowplot** Variance explained per PCA dimension")

  |                                                                              |......................................................                |  77%
  ordinary text without R code

  |                                                                              |.......................................................               |  78%
label: PCA_dataprep (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |........................................................              |  79%
  ordinary text without R code

  |                                                                              |........................................................              |  80%
label: plot_PCADimPlots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.........................................................             |  82%
  ordinary text without R code

  |                                                                              |..........................................................            |  83%
label: pca_boxplot_dataprep (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...........................................................           |  84%
  ordinary text without R code

  |                                                                              |...........................................................           |  85%
label: pca_boxplot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |............................................................          |  86%
  ordinary text without R code

  |                                                                              |.............................................................         |  87%
label: create-pca-enrichment-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Welcome to enrichR
Checking connection ... Connection is Live!
  |                                                                              |..............................................................        |  88%
  ordinary text without R code

  |                                                                              |..............................................................        |  89%
label: create-pca-enrichment-plot (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...............................................................       |  90%
  ordinary text without R code

  |                                                                              |................................................................      |  91%
label: pseudotime-enrichment-data (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |.................................................................     |  92%
  ordinary text without R code

  |                                                                              |.................................................................     |  93%
label: pseudotime-plot (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................................    |  95%
  ordinary text without R code

  |                                                                              |...................................................................   |  96%
label: Additional tables (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |....................................................................  |  97%
  ordinary text without R code

  |                                                                              |....................................................................  |  98%
label: saveobject (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |..................................................................... |  99%
  ordinary text without R code

  |                                                                              |......................................................................| 100%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T


output file: template.singlecell.partB.Analysis_V1.knit.md

/camp/apps/misc/stp/babs/conda/envs/R_deps/bin/pandoc +RTS -K512m -RTS template.singlecell.partB.Analysis_V1.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output template.singlecell.partB.Analysis_V1.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_18210347/Rtmp2Tx1XF/rmarkdown-str14bf5171e3d2.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: template.singlecell.partB.Analysis_V1.html
There were 50 or more warnings (use warnings() to see the first 50)
