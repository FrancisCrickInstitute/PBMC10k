

processing file: sc_PartA_QC.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   1%
  ordinary text without R code

  |                                                                              |..                                                                    |   3%
label: setup (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |...                                                                   |   4%
  ordinary text without R code

  |                                                                              |....                                                                  |   6%
label: hpc_notes (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |.....                                                                 |   7%
  ordinary text without R code

  |                                                                              |......                                                                |   9%
label: init (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol T

  |                                                                              |.......                                                               |  10%
  ordinary text without R code

  |                                                                              |........                                                              |  12%
label: dbpwd (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol F

  |                                                                              |.........                                                             |  13%
  ordinary text without R code

  |                                                                              |..........                                                            |  14%
label: set_directories (with options) 
List of 1
 $ eval: symbol T

Loading required package: S4Vectors
Loading required package: stats4
Loading required package: BiocGenerics
Loading required package: parallel

Attaching package: 'BiocGenerics'

The following objects are masked from 'package:parallel':

    clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    clusterExport, clusterMap, parApply, parCapply, parLapply,
    parLapplyLB, parRapply, parSapply, parSapplyLB

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

The following object is masked from 'package:base':

    expand.grid

Loading required package: IRanges
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

Loading required package: BiocParallel

Attaching package: 'DelayedArray'

The following objects are masked from 'package:matrixStats':

    colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges

The following objects are masked from 'package:base':

    aperm, apply, rowsum


Attaching package: 'dplyr'

The following object is masked from 'package:matrixStats':

    count

The following object is masked from 'package:Biobase':

    combine

The following objects are masked from 'package:GenomicRanges':

    intersect, setdiff, union

The following object is masked from 'package:GenomeInfoDb':

    intersect

The following objects are masked from 'package:IRanges':

    collapse, desc, intersect, setdiff, slice, union

The following objects are masked from 'package:S4Vectors':

    first, intersect, rename, setdiff, setequal, union

The following objects are masked from 'package:BiocGenerics':

    combine, intersect, setdiff, union

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
✔ tibble  3.0.1     ✔ purrr   0.3.4
✔ tidyr   1.1.0     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.5.0
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::collapse()   masks IRanges::collapse()
✖ dplyr::combine()    masks Biobase::combine(), BiocGenerics::combine()
✖ dplyr::count()      masks matrixStats::count()
✖ dplyr::desc()       masks IRanges::desc()
✖ tidyr::expand()     masks S4Vectors::expand()
✖ dplyr::filter()     masks stats::filter()
✖ dplyr::first()      masks S4Vectors::first()
✖ dplyr::lag()        masks stats::lag()
✖ ggplot2::Position() masks BiocGenerics::Position(), base::Position()
✖ purrr::reduce()     masks GenomicRanges::reduce(), IRanges::reduce()
✖ dplyr::rename()     masks S4Vectors::rename()
✖ purrr::simplify()   masks DelayedArray::simplify()
✖ dplyr::slice()      masks IRanges::slice()

Attaching package: 'Seurat'

The following object is masked from 'package:SummarizedExperiment':

    Assays


Attaching package: 'DT'

The following object is masked from 'package:Seurat':

    JS

  |                                                                              |...........                                                           |  16%
  ordinary text without R code

  |                                                                              |............                                                          |  17%
label: saveobject (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |.............                                                         |  19%
  ordinary text without R code

  |                                                                              |..............                                                        |  20%
label: create_QC_Table (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...............                                                       |  22%
   inline R code fragments

  |                                                                              |................                                                      |  23%
label: cellRangerCommands (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.................                                                     |  25%
   inline R code fragments

  |                                                                              |..................                                                    |  26%
label: render_QCTable (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...................                                                   |  28%
  ordinary text without R code

  |                                                                              |....................                                                  |  29%
label: QC_raw_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |.....................                                                 |  30%
   inline R code fragments

  |                                                                              |......................                                                |  32%
label: Plot_tsne_data_plotting (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.......................                                               |  33%
  ordinary text without R code

  |                                                                              |........................                                              |  35%
label: start_seurat (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Loading required package: DBI
Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
01:21:11 UMAP embedding parameters a = 0.9922 b = 1.112
01:21:11 Read 10185 rows and found 20 numeric columns
01:21:11 Using Annoy for neighbor search, n_neighbors = 30
01:21:11 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
01:21:14 Writing NN index file to temp file /tmp/slurm_21296601/RtmpZFVqJC/file7806f0fa5da
01:21:14 Searching Annoy index using 1 thread, search_k = 3000
01:21:18 Annoy recall = 100%
01:21:23 Commencing smooth kNN distance calibration using 1 thread
01:21:33 Initializing from normalized Laplacian + noise
01:21:34 Commencing optimization for 200 epochs, with 430296 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
01:21:53 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |.........................                                             |  36%
  ordinary text without R code

  |                                                                              |..........................                                            |  38%
label: percent_mt (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

mixtools package, version 1.2.0, Released 2020-02-05
This package is based upon work supported by the National Science Foundation under Grant No. SES-0518772.

  |                                                                              |...........................                                           |  39%
   inline R code fragments

  |                                                                              |............................                                          |  41%
label: Plot_percentMT_hist (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............................                                         |  42%
  ordinary text without R code

  |                                                                              |..............................                                        |  43%
label: nFeature_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...............................                                       |  45%
   inline R code fragments

  |                                                                              |................................                                      |  46%
label: Plot_nFeatureRNA_hist (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.................................                                     |  48%
  ordinary text without R code

  |                                                                              |..................................                                    |  49%
label: UMAP_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F


Attaching package: 'scales'

The following object is masked from 'package:purrr':

    discard

The following object is masked from 'package:readr':

    col_factor

  |                                                                              |....................................                                  |  51%
   inline R code fragments

  |                                                                              |.....................................                                 |  52%
label: Plot_UMAP (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |......................................                                |  54%
  ordinary text without R code

  |                                                                              |.......................................                               |  55%
label: UMAP_data_CC (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
  |                                                                              |........................................                              |  57%
   inline R code fragments

  |                                                                              |.........................................                             |  58%
label: Plot_UMAP_CC (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..........................................                            |  59%
  ordinary text without R code

  |                                                                              |...........................................                           |  61%
label: cell_cyle_hist_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
  |                                                                              |............................................                          |  62%
   inline R code fragments

  |                                                                              |.............................................                         |  64%
label: Plot_cellCycleBarchart (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..............................................                        |  65%
  ordinary text without R code

  |                                                                              |...............................................                       |  67%
label: DF_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Loading required package: fields
Loading required package: spam
Loading required package: dotCall64
Loading required package: grid

Attaching package: 'grid'

The following object is masked from 'package:mixtools':

    depth

Spam version 2.5-1 (2019-12-12) is loaded.
Type 'help( Spam)' or 'demo( spam)' for a short introduction 
and overview of this package.
Help for individual functions is also obtained by adding the
suffix '.spam' to the function name, e.g. 'help( chol.spam)'.

Attaching package: 'spam'

The following object is masked from 'package:stats4':

    mle

The following objects are masked from 'package:base':

    backsolve, forwardsolve

Loading required package: maps

Attaching package: 'maps'

The following object is masked from 'package:purrr':

    map

See https://github.com/NCAR/Fields for
 an extensive vignette, other supplements and source code 
Loading required package: KernSmooth
KernSmooth 2.23 loaded
Copyright M. P. Wand 1997-2009
Loading required package: sctransform

Attaching package: 'sctransform'

The following object is masked from 'package:DESeq2':

    vst

Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 19969 by 13580
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 13580 cells
Found 35 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 19969 genes
Computing corrected count matrix for 19969 genes
Calculating gene attributes
Wall clock passed: Time difference of 16.06973 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  IL32, LTB, IL7R, TRAC, TRBC2, CCL5, TRBC1, CD3E, NKG7, CD3D 
	   GNLY, RPS27, GZMA, CD3G, LDHB, RPS12, CTSW, CD7, RPSA, RPS3 
	   RPS5, RPL3, ARL4C, RPS18, IGHM, RPS27A, CD8B, RPL13, CST7, CD79A 
Negative:  LYZ, S100A9, S100A8, FCN1, CST3, CTSS, MNDA, TYROBP, VCAN, TYMP 
	   AIF1, FTL, S100A12, FGL2, NEAT1, PSAP, IFITM3, LST1, HLA-DRA, CD14 
	   SAT1, SERPINA1, FCER1G, FTH1, FOS, S100A11, CYBB, CEBPD, TMEM176B, S100A6 
PC_ 2 
Positive:  NKG7, GNLY, CCL5, GZMA, CST7, PRF1, GZMH, KLRD1, CTSW, FGFBP2 
	   S100A8, S100A9, IL32, CCL4, HOPX, KLRB1, SPON2, KLRF1, TRDC, GZMM 
	   KLRG1, HCST, LYZ, CD247, TRGC2, GZMB, CD7, LAIR2, VCAN, S100A12 
Negative:  IGHM, IGKC, CD79A, HLA-DRA, CD74, MS4A1, HLA-DQA1, HLA-DRB1, HLA-DPA1, IGHD 
	   HLA-DPB1, TCL1A, CD79B, BANK1, RALGPS2, JCHAIN, IGLC2, LINC00926, HLA-DRB5, HLA-DQB1 
	   FCER2, TCF4, TNFRSF13C, VPREB3, BCL11A, FAM129C, SPIB, CD22, CD37, BLK 
PC_ 3 
Positive:  S100A8, S100A9, IL7R, LYZ, TRAC, VCAN, S100A12, LDHB, TRBC1, LTB 
	   RPS12, TCF7, NOSIP, CD3E, LEF1, RPL32, CCR7, MAL, RPL13, RPL30 
	   RPL34, TRABD2A, EEF1A1, PIK3IP1, CD3D, TRBC2, RPS14, RPS3A, CD3G, RPS6 
Negative:  GNLY, NKG7, CCL5, GZMA, CST7, GZMB, PRF1, KLRD1, GZMH, FGFBP2 
	   HLA-DRA, CD74, FCGR3A, IGHM, CCL4, HLA-DPA1, IGKC, CLIC3, CTSW, HOPX 
	   SPON2, HLA-DQA1, HLA-DRB1, HLA-DPB1, KLRF1, CD79A, TRDC, MS4A1, HLA-DRB5, TCL1A 
PC_ 4 
Positive:  S100A8, S100A9, LYZ, IGHM, VCAN, IGKC, S100A12, CD79A, MS4A1, MNDA 
	   TCL1A, IGHD, GNLY, CD14, BANK1, JCHAIN, NKG7, GZMB, NCF1, RALGPS2 
	   TCF4, IGLC2, LINC00926, CCL5, CD79B, ALOX5AP, FAM129C, MZB1, CD36, SPIB 
Negative:  IFITM3, FCGR3A, CDKN1C, AIF1, LST1, HLA-DPA1, CST3, MS4A7, FCER1G, SERPINA1 
	   HLA-DPB1, WARS, SAT1, HES4, COTL1, HLA-DRB1, APOBEC3A, FTH1, SMIM25, CXCL10 
	   FTL, IFITM2, TNFSF10, CFD, HLA-DQA1, RHOC, TCF7L2, HLA-DRA, CSF1R, CALHM6 
PC_ 5 
Positive:  ITM2C, LILRA4, PLD4, SERPINF1, GZMB, JCHAIN, CLEC4C, TPM2, CCDC50, UGCG 
	   MZB1, DNASE1L3, PPP1R14B, PTCRA, TCF4, IRF8, IRF7, IL3RA, LRRC26, SCT 
	   C12orf75, LINC00996, DERL3, CLIC3, ALOX5AP, MAP1A, SMPD3, TSPAN13, PACSIN1, PTGDS 
Negative:  IGHM, CD79A, MS4A1, IGHD, CD79B, BANK1, IGKC, NKG7, LINC00926, GNLY 
	   RALGPS2, FCER2, VPREB3, IGLC2, TNFRSF13C, CCL5, CD22, HLA-DRA, GZMA, CST7 
	   CD37, P2RX5, PLPP5, PAX5, GZMH, FCRL1, HLA-DOB, CD24, SWAP70, FCRL3 
  |                                                                              |................................................                      |  68%
   inline R code fragments

  |                                                                              |.................................................                     |  70%
label: Plot_DF (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................                    |  71%
  ordinary text without R code

  |                                                                              |...................................................                   |  72%
label: UMAP_percentage (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |....................................................                  |  74%
   inline R code fragments

  |                                                                              |.....................................................                 |  75%
label: Plot_percent_MT (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |......................................................                |  77%
  ordinary text without R code

  |                                                                              |.......................................................               |  78%
label: UMAP_nFeatures (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |........................................................              |  80%
   inline R code fragments

  |                                                                              |.........................................................             |  81%
label: Plot_nFeatureRNA (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..........................................................            |  83%
  ordinary text without R code

  |                                                                              |...........................................................           |  84%
label: saveobject_end (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |............................................................          |  86%
  ordinary text without R code

  |                                                                              |.............................................................         |  87%
label: createIntegrated (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
01:46:27 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
01:46:27 Read 9200 rows and found 20 numeric columns
01:46:27 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
01:46:27 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
01:46:30 Writing NN index file to temp file /tmp/slurm_21296601/RtmpZFVqJC/file78065ed6d47d
01:46:30 Searching Annoy index using 1 thread, search_k = 3000
01:46:33 Annoy recall = 100%
01:46:36 Commencing smooth kNN distance calibration using 1 thread
01:46:42 Initializing from normalized Laplacian + noise
01:46:43 Commencing optimization for 500 epochs, with 396298 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
01:47:32 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
03:08:13 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
03:08:13 Read 9200 rows and found 20 numeric columns
03:08:13 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
03:08:13 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
03:08:16 Writing NN index file to temp file /tmp/slurm_21296601/RtmpZFVqJC/file780671dc6214
03:08:16 Searching Annoy index using 1 thread, search_k = 3000
03:08:19 Annoy recall = 100%
03:08:23 Commencing smooth kNN distance calibration using 1 thread
03:08:29 Initializing from normalized Laplacian + noise
03:08:30 Commencing optimization for 500 epochs, with 396298 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
03:09:09 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:30:19 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
04:30:19 Read 9200 rows and found 20 numeric columns
04:30:19 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
04:30:19 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:30:22 Writing NN index file to temp file /tmp/slurm_21296601/RtmpZFVqJC/file78065c0fa31f
04:30:22 Searching Annoy index using 1 thread, search_k = 3000
04:30:26 Annoy recall = 100%
04:30:28 Commencing smooth kNN distance calibration using 1 thread
04:30:33 Initializing from normalized Laplacian + noise
04:30:34 Commencing optimization for 500 epochs, with 396298 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:31:13 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: The following features are not present in the object: MLF1IP, not searching for symbol synonyms
Warning: The following features are not present in the object: FAM64A, HN1, not searching for symbol synonyms
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:39:46 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
04:39:46 Read 9200 rows and found 20 numeric columns
04:39:46 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
04:39:46 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:39:48 Writing NN index file to temp file /tmp/slurm_21296601/RtmpZFVqJC/file78062a1bdc2f
04:39:48 Searching Annoy index using 1 thread, search_k = 3000
04:39:52 Annoy recall = 100%
04:39:54 Commencing smooth kNN distance calibration using 1 thread
04:40:00 Initializing from normalized Laplacian + noise
04:40:00 Commencing optimization for 500 epochs, with 396298 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
04:40:39 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |..............................................................        |  88%
  ordinary text without R code

  |                                                                              |...............................................................       |  90%
label: AUC_prep_from_file (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

Quantiles for the number of genes detected by cell: 
(Non-detected genes are shuffled at the end of the ranking. Keep it in mind when choosing the threshold for calculating the AUC).
  |                                                                              |................................................................      |  91%
   inline R code fragments

  |                                                                              |.................................................................     |  93%
label: enrichment_plots (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................................    |  94%
  ordinary text without R code

  |                                                                              |...................................................................   |  96%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T

  |                                                                              |....................................................................  |  97%
  ordinary text without R code

  |                                                                              |..................................................................... |  99%
label: create_report_params (with options) 
List of 2
 $ eval   : symbol T
 $ results: chr "asis"

  |                                                                              |......................................................................| 100%
   inline R code fragments


output file: sc_PartA_QC.knit.md

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartA_QC.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/boeings/stefan.boeing/426_scRNAseq_PBMC_10k/workdir/html_local/sc_PartA_QC.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:paper' --include-in-header /tmp/slurm_21296601/RtmpZFVqJC/rmarkdown-str780615d4610a.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/boeings/stefan.boeing/426_scRNAseq_PBMC_10k/workdir/html_local/sc_PartA_QC.html
There were 50 or more warnings (use warnings() to see the first 50)
