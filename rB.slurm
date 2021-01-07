

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

Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
14:07:39 UMAP embedding parameters a = 0.9922 b = 1.112
14:07:39 Read 3716 rows and found 20 numeric columns
14:07:39 Using Annoy for neighbor search, n_neighbors = 30
14:07:39 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:07:40 Writing NN index file to temp file /tmp/slurm_20125532/Rtmpg2cl5B/file7f256bdae0e1
14:07:40 Searching Annoy index using 30 threads, search_k = 3000
14:07:40 Annoy recall = 100%
14:07:40 Commencing smooth kNN distance calibration using 30 threads
14:07:42 Initializing from normalized Laplacian + noise
14:07:42 Commencing optimization for 500 epochs, with 145026 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:07:53 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|

Attaching package: 'scales'

The following object is masked from 'package:purrr':

    discard

The following object is masked from 'package:readr':

    col_factor

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
Finished averaging RNA for cluster C0_GliaT
Finished averaging RNA for cluster C0_NeuronT
Finished averaging RNA for cluster C1_GliaT
Finished averaging RNA for cluster C1_NeuronT
Finished averaging RNA for cluster C2_GliaT
Finished averaging RNA for cluster C2_NeuronT
Finished averaging RNA for cluster C3_GliaT
Finished averaging RNA for cluster C3_NeuronT
Finished averaging RNA for cluster C4_GliaT
Finished averaging RNA for cluster C4_NeuronT
Finished averaging RNA for cluster C5_GliaT
Finished averaging RNA for cluster C5_NeuronT
Finished averaging RNA for cluster C6_GliaT
Finished averaging RNA for cluster C6_NeuronT
Finished averaging RNA for cluster C7_GliaT
Finished averaging RNA for cluster C7_NeuronT
Finished averaging RNA for cluster C8_GliaT
Finished averaging RNA for cluster C8_NeuronT
Finished averaging RNA for cluster C9_GliaT
Finished averaging RNA for cluster C9_NeuronT
Finished averaging RNA for cluster C10_GliaT
Finished averaging RNA for cluster C10_NeuronT
Finished averaging RNA for cluster C11_GliaT
Finished averaging RNA for cluster C11_NeuronT
Finished averaging RNA for cluster C12_GliaT
Finished averaging RNA for cluster C12_NeuronT
Finished averaging RNA for cluster C13_GliaT
Finished averaging RNA for cluster C13_NeuronT
Finished averaging RNA for cluster C14_GliaT
Finished averaging RNA for cluster C14_NeuronT
Finished averaging RNA for cluster C15_GliaT
Finished averaging RNA for cluster C15_NeuronT
Finished averaging SCT for cluster C0_GliaT
Finished averaging SCT for cluster C0_NeuronT
Finished averaging SCT for cluster C1_GliaT
Finished averaging SCT for cluster C1_NeuronT
Finished averaging SCT for cluster C2_GliaT
Finished averaging SCT for cluster C2_NeuronT
Finished averaging SCT for cluster C3_GliaT
Finished averaging SCT for cluster C3_NeuronT
Finished averaging SCT for cluster C4_GliaT
Finished averaging SCT for cluster C4_NeuronT
Finished averaging SCT for cluster C5_GliaT
Finished averaging SCT for cluster C5_NeuronT
Finished averaging SCT for cluster C6_GliaT
Finished averaging SCT for cluster C6_NeuronT
Finished averaging SCT for cluster C7_GliaT
Finished averaging SCT for cluster C7_NeuronT
Finished averaging SCT for cluster C8_GliaT
Finished averaging SCT for cluster C8_NeuronT
Finished averaging SCT for cluster C9_GliaT
Finished averaging SCT for cluster C9_NeuronT
Finished averaging SCT for cluster C10_GliaT
Finished averaging SCT for cluster C10_NeuronT
Finished averaging SCT for cluster C11_GliaT
Finished averaging SCT for cluster C11_NeuronT
Finished averaging SCT for cluster C12_GliaT
Finished averaging SCT for cluster C12_NeuronT
Finished averaging SCT for cluster C13_GliaT
Finished averaging SCT for cluster C13_NeuronT
Finished averaging SCT for cluster C14_GliaT
Finished averaging SCT for cluster C14_NeuronT
Finished averaging SCT for cluster C15_GliaT
Finished averaging SCT for cluster C15_NeuronT
Finished averaging integrated for cluster C0_GliaT
Finished averaging integrated for cluster C0_NeuronT
Finished averaging integrated for cluster C1_GliaT
Finished averaging integrated for cluster C1_NeuronT
Finished averaging integrated for cluster C2_GliaT
Finished averaging integrated for cluster C2_NeuronT
Finished averaging integrated for cluster C3_GliaT
Finished averaging integrated for cluster C3_NeuronT
Finished averaging integrated for cluster C4_GliaT
Finished averaging integrated for cluster C4_NeuronT
Finished averaging integrated for cluster C5_GliaT
Finished averaging integrated for cluster C5_NeuronT
Finished averaging integrated for cluster C6_GliaT
Finished averaging integrated for cluster C6_NeuronT
Finished averaging integrated for cluster C7_GliaT
Finished averaging integrated for cluster C7_NeuronT
Finished averaging integrated for cluster C8_GliaT
Finished averaging integrated for cluster C8_NeuronT
Finished averaging integrated for cluster C9_GliaT
Finished averaging integrated for cluster C9_NeuronT
Finished averaging integrated for cluster C10_GliaT
Finished averaging integrated for cluster C10_NeuronT
Finished averaging integrated for cluster C11_GliaT
Finished averaging integrated for cluster C11_NeuronT
Finished averaging integrated for cluster C12_GliaT
Finished averaging integrated for cluster C12_NeuronT
Finished averaging integrated for cluster C13_GliaT
Finished averaging integrated for cluster C13_NeuronT
Finished averaging integrated for cluster C14_GliaT
Finished averaging integrated for cluster C14_NeuronT
Finished averaging integrated for cluster C15_GliaT
Finished averaging integrated for cluster C15_NeuronT
Centering and scaling data matrix
Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C14
Finished averaging RNA for cluster C15
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Finished averaging SCT for cluster C0
Finished averaging SCT for cluster C1
Finished averaging SCT for cluster C10
Finished averaging SCT for cluster C11
Finished averaging SCT for cluster C12
Finished averaging SCT for cluster C13
Finished averaging SCT for cluster C14
Finished averaging SCT for cluster C15
Finished averaging SCT for cluster C2
Finished averaging SCT for cluster C3
Finished averaging SCT for cluster C4
Finished averaging SCT for cluster C5
Finished averaging SCT for cluster C6
Finished averaging SCT for cluster C7
Finished averaging SCT for cluster C8
Finished averaging SCT for cluster C9
Finished averaging integrated for cluster C0
Finished averaging integrated for cluster C1
Finished averaging integrated for cluster C10
Finished averaging integrated for cluster C11
Finished averaging integrated for cluster C12
Finished averaging integrated for cluster C13
Finished averaging integrated for cluster C14
Finished averaging integrated for cluster C15
Finished averaging integrated for cluster C2
Finished averaging integrated for cluster C3
Finished averaging integrated for cluster C4
Finished averaging integrated for cluster C5
Finished averaging integrated for cluster C6
Finished averaging integrated for cluster C7
Finished averaging integrated for cluster C8
Finished averaging integrated for cluster C9
Centering and scaling data matrix
Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C14
Finished averaging RNA for cluster C15
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
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

Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C14
Finished averaging RNA for cluster C15
Calculating cluster C0
Calculating cluster C1
Calculating cluster C2
Calculating cluster C3
Calculating cluster C4
Calculating cluster C5
Calculating cluster C6
Calculating cluster C7
Calculating cluster C8
Calculating cluster C9
Calculating cluster C10
Calculating cluster C11
Calculating cluster C12
Calculating cluster C13
Calculating cluster C14
Calculating cluster C15
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
Finished averaging RNA for cluster C0
Finished averaging RNA for cluster C1
Finished averaging RNA for cluster C2
Finished averaging RNA for cluster C3
Finished averaging RNA for cluster C4
Finished averaging RNA for cluster C5
Finished averaging RNA for cluster C6
Finished averaging RNA for cluster C7
Finished averaging RNA for cluster C8
Finished averaging RNA for cluster C9
Finished averaging RNA for cluster C10
Finished averaging RNA for cluster C11
Finished averaging RNA for cluster C12
Finished averaging RNA for cluster C13
Finished averaging RNA for cluster C14
Finished averaging RNA for cluster C15
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

`summarise()` ungrouping output (override with `.groups` argument)
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
Scale for 'fill' is already present. Adding another scale for 'fill', which
will replace the existing scale.
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

`summarise()` ungrouping output (override with `.groups` argument)
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
--> Expected input gene ID: Cd180,Alox15,Stap1,Pdcd1lg2,H2-Aa,Sept8
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Pir,Ace2,Alas2,Map2,Col4a1,Musk
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Rabif,Fasl,Mep1a,Krt33b,Lpl,Lmna
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Fgf15,Sntb1,Mto1,Mpped2,Col4a4,Acbd3
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Ptgir,Cd22,Lag3,Stxbp6,P2rx5,Mmp12
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Mxd1,Cd68,Dcstamp,P2ry14,P2ry14,Sell
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Htr2b,Gm13309,P2rx1,Cd19,Cxcr5,Fcer2a
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Ccr7,Mxd1,Htr2b,Cd79a,Ptgir,Fcer2a
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Cd69,Tnfaip6,Cfp,Dennd5b,Ppfibp1,Hdc
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: P2rx5,Blk,Gpr183,Ly86,Mmp12,Gm2564
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: P2ry10,Fam198b,Htr2b,Faim3,Aif1,Tec
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Abcb4,Irf8,Tnfrsf17,Cd80,Ccl17,Cd79a
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: H2-M3,Eif3j1,Gamt,Lpl,Ar,Spi1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Fads2,Krt31,Gnai2,Hsd3b2,Adcy6,Nrxn2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: 5031414D18Rik,D830031N03Rik,Cyp27b1,Nme8,Fcgr2b,Nox3
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Samsn1,Slc12a8,Prg2,Ido1,Smpdl3b,Hrh1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Il7,P2ry10,H2-Aa,Chst7,Slc12a8,Tlr8
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: P2rx5,Gpr97,Rgs13,Stxbp6,Npl,Braf
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


Attaching package: 'ggpubr'

The following object is masked from 'package:ggtree':

    rotate


Attaching package: 'gridExtra'

The following object is masked from 'package:Biobase':

    combine

The following object is masked from 'package:BiocGenerics':

    combine

The following object is masked from 'package:dplyr':

    combine

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

--> No gene can be mapped....
--> Expected input gene ID: Cd19,Cd209e,Kynu,Fam198b,Ms4a2,Pla1a
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Slc12a1,Tmem156,Epn2,Cd80,Atp8b4,Npl
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Il18r1,Ido1,Slc15a3,Ccl5,Ifi44l,Il1rl1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Il1a,Ccl5,Cd79a,Il18r1,Faim3,Prg2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Alox15,Dhrs11,Ccl19,Vpreb3,P2ry10,Rrp12
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Il18r1,Mxd1,D830031N03Rik,Cd86,Hoxa1,Ctsg
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Nmbr,Il2ra,Cd79a,Ctsg,Sp140,Pla1a
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Irf8,Aqp9,LOC100861618,Tmem255a,Clec4a2,Rrp12
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: P2ry2,Ltc4s,Tnfrsf11a,Gm2023,Ido1,Myb
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Reps2,Il5ra,Ptgir,Slc12a8,Ly86,Egr2
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Tmem255a,Aif1,Slc15a3,Fzd2,Adamdec1,Dach1
--> return NULL...
--> No gene can be mapped....
--> Expected input gene ID: Mxd1,Adamdec1,Ms4a2,Cr2,Ifi44l,Trem2
--> return NULL...
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

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartB_Analysis.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_PartB_Analysis.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_20125532/Rtmpg2cl5B/rmarkdown-str7f259ef323b.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_PartB_Analysis.html
There were 50 or more warnings (use warnings() to see the first 50)
