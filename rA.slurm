

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
Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
This message will be shown once per session
11:16:21 UMAP embedding parameters a = 0.9922 b = 1.112
11:16:21 Read 1938 rows and found 20 numeric columns
11:16:21 Using Annoy for neighbor search, n_neighbors = 30
11:16:21 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:16:21 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file1418877cb124c
11:16:21 Searching Annoy index using 1 thread, search_k = 3000
11:16:22 Annoy recall = 100%
11:16:22 Commencing smooth kNN distance calibration using 1 thread
11:16:24 Initializing from normalized Laplacian + noise
11:16:24 Commencing optimization for 500 epochs, with 73768 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:16:32 Optimization finished
Computing nearest neighbor graph
Computing SNN
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
11:18:07 UMAP embedding parameters a = 0.9922 b = 1.112
11:18:07 Read 1938 rows and found 20 numeric columns
11:18:07 Using Annoy for neighbor search, n_neighbors = 30
11:18:07 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:18:08 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file1418811cd3183
11:18:08 Searching Annoy index using 1 thread, search_k = 3000
11:18:09 Annoy recall = 100%
11:18:09 Commencing smooth kNN distance calibration using 1 thread
11:18:11 Initializing from normalized Laplacian + noise
11:18:11 Commencing optimization for 500 epochs, with 73768 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:18:19 Optimization finished
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

Warning: The following features are not present in the object: MCM5, PCNA, TYMS, FEN1, MCM2, MCM4, RRM1, UNG, GINS2, MCM6, CDCA7, DTL, PRIM1, UHRF1, MLF1IP, HELLS, RFC2, RPA2, NASP, RAD51AP1, GMNN, WDR76, SLBP, CCNE2, UBR7, POLD3, MSH2, ATAD2, RAD51, RRM2, CDC45, CDC6, EXO1, TIPIN, DSCC1, BLM, CASP8AP2, USP1, CLSPN, POLA1, CHAF1B, BRIP1, E2F8, not searching for symbol synonyms
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, CKS2, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, TUBB4B, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
Warning: The following features are not present in the object: MCM5, PCNA, TYMS, FEN1, MCM2, MCM4, RRM1, UNG, GINS2, MCM6, CDCA7, DTL, PRIM1, UHRF1, MLF1IP, HELLS, RFC2, RPA2, NASP, RAD51AP1, GMNN, WDR76, SLBP, CCNE2, UBR7, POLD3, MSH2, ATAD2, RAD51, RRM2, CDC45, CDC6, EXO1, TIPIN, DSCC1, BLM, CASP8AP2, USP1, CLSPN, POLA1, CHAF1B, BRIP1, E2F8, not searching for symbol synonyms
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, CKS2, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, TUBB4B, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
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

Warning: The following features are not present in the object: MCM5, PCNA, TYMS, FEN1, MCM2, MCM4, RRM1, UNG, GINS2, MCM6, CDCA7, DTL, PRIM1, UHRF1, MLF1IP, HELLS, RFC2, RPA2, NASP, RAD51AP1, GMNN, WDR76, SLBP, CCNE2, UBR7, POLD3, MSH2, ATAD2, RAD51, RRM2, CDC45, CDC6, EXO1, TIPIN, DSCC1, BLM, CASP8AP2, USP1, CLSPN, POLA1, CHAF1B, BRIP1, E2F8, not searching for symbol synonyms
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, CKS2, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, TUBB4B, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
Warning: The following features are not present in the object: MCM5, PCNA, TYMS, FEN1, MCM2, MCM4, RRM1, UNG, GINS2, MCM6, CDCA7, DTL, PRIM1, UHRF1, MLF1IP, HELLS, RFC2, RPA2, NASP, RAD51AP1, GMNN, WDR76, SLBP, CCNE2, UBR7, POLD3, MSH2, ATAD2, RAD51, RRM2, CDC45, CDC6, EXO1, TIPIN, DSCC1, BLM, CASP8AP2, USP1, CLSPN, POLA1, CHAF1B, BRIP1, E2F8, not searching for symbol synonyms
Warning: The following features are not present in the object: HMGB2, CDK1, NUSAP1, UBE2C, BIRC5, TPX2, TOP2A, NDC80, CKS2, NUF2, CKS1B, MKI67, TMPO, CENPF, TACC3, FAM64A, SMC4, CCNB2, CKAP2L, CKAP2, AURKB, BUB1, KIF11, ANP32E, TUBB4B, GTSE1, KIF20B, HJURP, CDCA3, HN1, CDC20, TTK, CDC25C, KIF2C, RANGAP1, NCAPD2, DLGAP5, CDCA2, CDCA8, ECT2, KIF23, HMMR, AURKA, PSRC1, ANLN, LBR, CKAP5, CENPE, CTCF, NEK2, G2E3, GAS2L3, CBX5, CENPA, not searching for symbol synonyms
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
Variance stabilizing transformation of count matrix of size 18438 by 2584
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 2584 cells
Found 8 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 18438 genes
Computing corrected count matrix for 18438 genes
Calculating gene attributes
Wall clock passed: Time difference of 2.932424 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Nmu, Cdh8, Calb2, Mgat4c, Cpne4, Ngfr, Zfp804a, Robo2, Cbln2, Dgkg 
	   Grp, Efr3a, Calcb, Cntnap2, Tmeff2, Gm21847, Ntrk3, Kcnb2, Grin3a, Rab27b 
	   Pcdh10, Cntn5, Gpr149, Ano2, Ccbe1, Myl1, Htr3a, Cdh6, Nrxn3, Vgll3 
Negative:  Nos1, Cacnb2, Epha5, Galntl6, Pde1c, Tenm2, Kcnab1, Col25a1, Ndst4, Grid2 
	   Syn3, Kcnip4, Lrrc4c, Lrp1b, Fat3, Grik2, Nrg3, Pcdh7, Zfp536, Pcdh15 
	   Lrrtm3, Csmd3, Kirrel3, Synpr, Unc5d, Olfm3, Kcnd2, Hmcn1, Ryr2, Gria1 
PC_ 2 
Positive:  Nos1, Dgkb, Rgs6, Hmcn1, Kcnab1, Gfra1, Cmah, Slc44a5, Etv1, Cacnb2 
	   Vip, Thsd7a, Dpp10, Vwa5b1, Thsd7b, Cadps2, Rarb, Alcam, Creb5, Lrrc4c 
	   Ntrk3, Unc13c, Slc4a4, Col25a1, Cdh12, Ass1, Stxbp6, Bves, Epha5, A330015K06Rik 
Negative:  Pde4b, Unc5d, Bnc2, Tac1, Fam19a2, Fam19a1, Alk, Lrp1b, Grm7, Gpc6 
	   Rbfox1, Kctd8, Pld5, Pcdh7, Grik1, Penk, Ptprt, Dock10, Stxbp5l, Gm20754 
	   Olfm3, Stac, Skap1, Lingo2, Nxph1, Kctd16, Tox, Meis1, Cdh18, Gfra2 
PC_ 3 
Positive:  Ptprt, Galntl6, Tshz2, Gm26883, Rbfox1, Nlgn1, Alk, Ptprd, Cpne4, Ccbe1 
	   Ntrk3, Nrxn3, Pcdh7, Dlgap2, Chsy3, Grik1, Frmd4b, Epha6, Plcxd3, St6galnac3 
	   Pcdh9, Cdh8, Dcc, B3galt1, Nmu, Cdc14a, Dgkg, Cntnap2, Nfib, Fhit 
Negative:  Ntng1, Vip, Nsg1, Penk, Cd24a, Skap1, Nefl, Tac1, Serpini1, Pbx3 
	   Asic2, Col25a1, Egfem1, Kirrel3, Gng2, Stac, Tm4sf4, Ebf1, Pcp4l1, L3mbtl4 
	   Slc18a2, Chrm3, Htr2b, Sgcz, Tnr, Nos1, Grid1, Dlc1, Pde1a, Syt4 
PC_ 4 
Positive:  Cntn5, Prkg1, Pde1c, Col25a1, Lingo2, Grm7, Tenm2, Kctd8, Dock10, Unc5d 
	   Kirrel3, Tac1, Syn3, Ptprz1, Ndst4, Col27a1, Ntrk2, Kctd16, Dgkg, Ntrk3 
	   Kcnt2, Fras1, Dlgap1, Plcb1, Cntnap2, Epha5, Zfp804a, Dach1, Nhs, Dmd 
Negative:  Vip, Ptprt, Galntl6, Alk, Chsy3, Pcdh7, Rbfox1, Tshz2, Gm26883, Plcxd3 
	   Dbh, Dkk3, Fam19a2, S100a6, Ntng1, Ptprm, Tmem132c, Nefl, Gm26905, Rpl9-ps6 
	   Cdc14a, Grik1, Gfra2, Nrp1, Rps8, Sdk2, Adamts1, Arhgap24, Tmsb4x, Fgfr1 
PC_ 5 
Positive:  Tac1, Unc5d, Gda, Dock10, Kctd8, Lingo2, Prkcb, Ndst4, Nxph1, Galntl6 
	   Olfm3, Ntrk2, Grm7, S100a6, Synpr, Crispld1, Rgs4, Prkg1, Epha5, Tox 
	   Calcrl, Olfm1, Pcsk1n, Col25a1, Ptprz1, Lrp1b, Tmsb4x, Lrrc7, Sphkap, Csmd3 
Negative:  Ntng1, Kcnh7, Csmd1, Pcdh7, Trps1, Sgcz, Tmeff2, Klhl1, March1, Ano5 
	   Cdh18, Dlc1, Tnr, Kif26b, Hs6st3, Pbx3, Enox1, Gng2, Fam19a2, Nxph2 
	   Serpini1, Pde4b, Sez6l, Kcnb2, Slc17a6, Skap1, Galnt18, Nefl, Tmtc2, Pcp4l1 
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 18438 by 2584
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 2584 cells
Found 4 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 18438 genes
Computing corrected count matrix for 18438 genes
Calculating gene attributes
Wall clock passed: Time difference of 2.747097 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Nos1, Cacnb2, Galntl6, Pde1c, Epha5, Kcnab1, Tenm2, Col25a1, Ndst4, Grid2 
	   Lrp1b, Pcdh7, Kcnip4, Fat3, Syn3, Lrrc4c, Grik2, Nrg3, Unc5d, Lrrtm3 
	   Kirrel3, Csmd3, Olfm3, Gria1, Zfp536, Bnc2, Pcdh15, Kcnd2, Slc44a5, Synpr 
Negative:  Nmu, Cdh8, Calb2, Mgat4c, Cpne4, Ngfr, Robo2, Zfp804a, Cbln2, Dgkg 
	   Efr3a, Grp, Tmeff2, Calcb, Ntrk3, Cntnap2, Kcnb2, Grin3a, Gm21847, Pcdh10 
	   Cntn5, Gpr149, Rab27b, Ccbe1, Myl1, Ano2, Cdh6, 6330403A02Rik, Htr3a, Nrxn3 
PC_ 2 
Positive:  Nos1, Dgkb, Rgs6, Kcnab1, Hmcn1, Gfra1, Cmah, Slc44a5, Etv1, Vip 
	   Thsd7a, Cacnb2, Dpp10, Cadps2, Thsd7b, Rarb, Vwa5b1, Creb5, Alcam, Unc13c 
	   Slc4a4, Ntrk3, Lrrc4c, Col25a1, Ass1, Cdh12, Bves, Gria3, Pde1a, Stxbp6 
Negative:  Pde4b, Unc5d, Bnc2, Tac1, Lrp1b, Fam19a1, Alk, Fam19a2, Grm7, Gpc6 
	   Pld5, Kctd8, Pcdh7, Rbfox1, Grik1, Ptprt, Penk, Dock10, Stxbp5l, Olfm3 
	   Cdh18, Nxph1, Skap1, Stac, Gm20754, Tox, Meis1, Gfra2, Lingo2, Kctd16 
PC_ 3 
Positive:  Ntng1, Vip, Nsg1, Penk, Cd24a, Skap1, Tac1, Nefl, Serpini1, Asic2 
	   Col25a1, Pbx3, Egfem1, Gng2, Kirrel3, Tm4sf4, Slc18a2, Ebf1, Htr2b, Stac 
	   Syt4, Nos1, Pcp4l1, Kctd12, L3mbtl4, Chrm3, Ret, Slitrk4, Gpx3, Etv1 
Negative:  Ptprt, Galntl6, Tshz2, Gm26883, Rbfox1, Nlgn1, Alk, Ntrk3, Pcdh7, Cpne4 
	   Ptprd, Ccbe1, Nrxn3, Chsy3, Dlgap2, Frmd4b, Grik1, Pcdh9, Epha6, St6galnac3 
	   Cdh8, Dcc, Plcxd3, B3galt1, Nmu, Cdc14a, Dgkg, Mgat4c, Fhit, Nfib 
PC_ 4 
Positive:  Cntn5, Pde1c, Col25a1, Prkg1, Tenm2, Lingo2, Grm7, Dock10, Kctd8, Kirrel3 
	   Unc5d, Syn3, Ptprz1, Kcnt2, Ntrk3, Dgkg, Ntrk2, Tac1, Col27a1, Plcb1 
	   Ndst4, Nhs, Dlgap1, Spock3, Cntnap2, Robo2, Plcl1, Kctd16, Dach1, Dmd 
Negative:  Ptprt, Vip, Galntl6, Chsy3, Alk, Gm26883, Tshz2, Plcxd3, Rbfox1, S100a6 
	   Dkk3, Rpl9-ps6, Pcdh7, Gm26905, Ptprm, Dbh, Tmem132c, Cdc14a, Fam19a2, Grik1 
	   Gfra2, Rps8, Rps23, Prdx6, Xist, Rps29, Rps27rt, Muc3, Pcsk1n, Adamts1 
PC_ 5 
Positive:  Ntng1, Csmd1, Kcnh7, Pcdh7, Trps1, March1, Sgcz, Klhl1, Tmeff2, Ano5 
	   Cdh18, Tnr, Enox1, Dlc1, Kif26b, Fam19a2, Gng2, Pbx3, Serpini1, Hs6st3 
	   Nefl, Alk, Nxph2, Pde4b, Sez6l, Slc17a6, Pcp4l1, Plxna4, Galnt18, Tmtc2 
Negative:  Tac1, Unc5d, Gda, Dock10, Lingo2, Kctd8, Ndst4, Olfm3, Grm7, Ntrk2 
	   Prkcb, Prkg1, Nxph1, Epha5, Galntl6, Synpr, Rgs4, Calcrl, Crispld1, Col25a1 
	   Ptprz1, Tox, Pde1c, Col27a1, Lrp1b, Olfm1, Csmd3, S100a6, Bnc2, Htr2b 
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
11:28:12 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:28:12 Read 3716 rows and found 20 numeric columns
11:28:12 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:28:12 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:28:13 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file1418877bbc658
11:28:13 Searching Annoy index using 30 threads, search_k = 3000
11:28:13 Annoy recall = 100%
11:28:15 Commencing smooth kNN distance calibration using 30 threads
11:28:18 Initializing from normalized Laplacian + noise
11:28:18 Commencing optimization for 500 epochs, with 145026 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:28:32 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|

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
11:32:12 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:32:12 Read 3716 rows and found 20 numeric columns
11:32:12 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:32:12 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:32:13 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file1418819f8b44e
11:32:13 Searching Annoy index using 30 threads, search_k = 3000
11:32:13 Annoy recall = 100%
11:32:15 Commencing smooth kNN distance calibration using 30 threads
11:32:18 Initializing from normalized Laplacian + noise
11:32:18 Commencing optimization for 500 epochs, with 145456 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:32:33 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|

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
11:36:34 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:36:34 Read 3716 rows and found 20 numeric columns
11:36:34 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:36:34 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:36:35 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file141881d4f7058
11:36:35 Searching Annoy index using 30 threads, search_k = 3000
11:36:36 Annoy recall = 100%
11:36:37 Commencing smooth kNN distance calibration using 30 threads
11:36:40 Initializing from normalized Laplacian + noise
11:36:40 Commencing optimization for 500 epochs, with 145838 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:36:55 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|

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
11:41:02 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:41:02 Read 3716 rows and found 20 numeric columns
11:41:02 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:41:02 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:41:03 Writing NN index file to temp file /tmp/slurm_20454929/RtmpzMeFX4/file14188c510391
11:41:03 Searching Annoy index using 30 threads, search_k = 3000
11:41:03 Annoy recall = 100%
11:41:05 Commencing smooth kNN distance calibration using 30 threads
11:41:08 Initializing from normalized Laplacian + noise
11:41:09 Commencing optimization for 500 epochs, with 145026 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:41:24 Optimization finished
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

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartA_QC.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_PartA_QC.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:paper' --include-in-header /tmp/slurm_20454929/RtmpzMeFX4/rmarkdown-str1418815c1330e.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_PartA_QC.html
There were 50 or more warnings (use warnings() to see the first 50)
