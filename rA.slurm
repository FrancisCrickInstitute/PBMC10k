

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

Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
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
11:14:40 UMAP embedding parameters a = 0.9922 b = 1.112
11:14:40 Read 3837 rows and found 20 numeric columns
11:14:40 Using Annoy for neighbor search, n_neighbors = 30
11:14:40 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:14:41 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e34f0e9be1
11:14:41 Searching Annoy index using 1 thread, search_k = 3000
11:14:43 Annoy recall = 100%
11:14:45 Commencing smooth kNN distance calibration using 1 thread
11:14:51 Initializing from normalized Laplacian + noise
11:14:51 Commencing optimization for 500 epochs, with 155766 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:15:09 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:19:04 UMAP embedding parameters a = 0.9922 b = 1.112
11:19:04 Read 5041 rows and found 20 numeric columns
11:19:04 Using Annoy for neighbor search, n_neighbors = 30
11:19:04 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:19:06 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e317d6b1ec
11:19:06 Searching Annoy index using 1 thread, search_k = 3000
11:19:08 Annoy recall = 100%
11:19:11 Commencing smooth kNN distance calibration using 1 thread
11:19:16 Initializing from normalized Laplacian + noise
11:19:17 Commencing optimization for 500 epochs, with 210776 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:19:39 Optimization finished
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
Variance stabilizing transformation of count matrix of size 15897 by 5116
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 5116 cells
Found 11 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 15897 genes
Computing corrected count matrix for 15897 genes
Calculating gene attributes
Wall clock passed: Time difference of 5.975206 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Malat1, Cxcl10, Ly6a, Fcgr2b, Fabp4, Igfbp7, Aqp1, Cxcl9, Gpihbp1, Ctsl 
	   Gja4, Csf2rb2, Stab1, Stab2, Lyve1, Xist, Car4, Egfl7, Cd36, Plpp1 
	   Bmp2, Ctla2a, Cd55, Cldn5, Klf2, Vcam1, Ehd3, F2r, Flt4, Plpp3 
Negative:  Apoc1, Fabp1, Apoa2, Wfdc21, Mt1, Orm1, Ttr, Mt2, Apoc3, Saa1 
	   Alb, Apoa1, Apoc4, Cdo1, Saa2, Hp, Bhmt, Ttc36, Chchd10, Hpd 
	   Trf, Fgb, Hmgcs2, Hpx, Ass1, Stard10, Aldob, Fbp1, Scp2, Gnmt 
PC_ 2 
Positive:  Tyrobp, Cd74, Wfdc17, Lgals3, H2-Aa, H2-Ab1, H2-Eb1, Laptm5, Ctss, Ctsc 
	   Crip1, Ccl6, Aif1, Cebpb, Fcgr4, Mpeg1, Ifi27l2a, Cybb, Cd52, C1qa 
	   C1qc, Rac2, Ccl24, H2-DMa, H2-DMb1, Fcgr3, C1qb, Csf1r, Cd53, AW112010 
Negative:  Gja4, Cd36, Fcgr2b, Aqp1, Stab1, Csf2rb2, Stab2, Fabp4, Fabp5, Gpihbp1 
	   Car4, Cd55, Bmp2, Cldn5, Ehd3, Cyp4b1, Lyve1, Egfl7, Flt4, Igfbp7 
	   Mt1, Ackr1, Fabp1, Adam23, Lrg1, Ctla2a, Plpp3, F2r, Cxcl9, Ly6a 
PC_ 3 
Positive:  Wfdc17, Ctss, Tyrobp, Ccl6, Aif1, Ccl24, C1qb, C1qa, C1qc, Csf1r 
	   Cybb, Ly86, Mpeg1, Cd5l, mt-Nd3, Fcgr4, mt-Nd1, Laptm5, Fcgr3, Lst1 
	   Cfp, mt-Co1, Vsig4, Clec4f, mt-Nd5, Itgal, Cd300c2, Mafb, Cd53, Cd52 
Negative:  Dcn, Bgn, Serping1, Cxcl12, Rarres2, Ifitm1, Sod3, Colec11, Col14a1, Ecm1 
	   Col1a2, Col3a1, Cd63, Steap4, Fn1, Mustn1, Rgs5, Ramp1, Reln, Rbp1 
	   Tnfrsf11b, Colec10, Col6a1, Tmem176a, Lum, Cp, Postn, Gdf2, Tgfbi, Pdgfra 
PC_ 4 
Positive:  Dcn, Cxcl12, Sod3, Colec11, Serping1, Steap4, Tgfbi, Ifi27l2a, Rgs5, Col14a1 
	   Mustn1, Rarres2, Ifitm1, Bgn, Colec10, Reln, Lrat, Gdf2, Postn, mt-Nd1 
	   Lum, Col1a2, mt-Nd2, mt-Nd3, Col3a1, mt-Nd4, Tnfrsf11b, mt-Co3, Ecm1, mt-Co1 
Negative:  Hmgb2, Stmn1, Top2a, Birc5, Ube2c, Cks1b, Cdk1, Prc1, Nusap1, Ccna2 
	   Ccnb2, Cenpf, Pttg1, Mki67, Cenpa, Pclaf, Gapdh, Cks2, Lgals1, Tuba1c 
	   Rrm2, Cdca8, Cd9, Racgap1, Tpx2, H2afz, Vim, Ube2s, Fam64a, Hmgn2 
PC_ 5 
Positive:  Cxcl10, Mt1, Fabp5, Malat1, Ly6a, Cxcl9, Gja4, Csf2rb2, Fcgr2b, Cd36 
	   Car4, Fabp4, Prdx1, Mt2, Hpgd, Iigp1, Cyb5a, Aqp1, Fabp1, Vcam1 
	   Igfbp7, Cd55, Gpihbp1, Stab2, Ehd3, Ctsl, Dbi, Lifr, Apoc1, Ftl1 
Negative:  mt-Atp6, mt-Cytb, mt-Co3, mt-Co2, mt-Nd2, mt-Nd4, mt-Nd3, mt-Co1, mt-Nd1, mt-Nd4l 
	   mt-Nd5, mt-Atp8, mt-Nd6, C3, Hpx, Top2a, Birc5, Alb, Ube2c, Stmn1 
	   Fgb, Cks1b, Hmgb2, Cdk1, Hp, Fga, Prc1, Ccna2, Nusap1, Cenpf 
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 15566 by 6721
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 6721 cells
Found 6 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 15566 genes
Computing corrected count matrix for 15566 genes
Calculating gene attributes
Wall clock passed: Time difference of 6.583907 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Hpx, Alb, Fgb, Fgg, Apoa1, Hp, Ahsg, Fga, Serpina1c, C3 
	   Saa1, Lcn2, Trf, Kng1, Gc, Saa2, Serpina1b, Serpina1a, Serpina3k, Orm1 
	   Ambp, Itih4, Ttr, Orm2, Cp, Apoh, Apcs, Vtn, Hamp, Apob 
Negative:  Malat1, Igfbp7, Clec4g, Fcgr2b, Aqp1, Ly6a, Fabp4, Il6st, Serpina3g, Eng 
	   Sparc, Dnase1l3, Stab1, Egfl7, Stab2, Tmsb4x, Ctsl, Ptprb, Ramp2, Cd55 
	   Maf, Csf2rb2, Gpihbp1, Esam, Cd36, Gpr182, Plpp1, Kdr, Bmp2, Gatm 
PC_ 2 
Positive:  Igfbp7, Clec4g, Aqp1, Hpx, Fcgr2b, Alb, Il6st, Fgb, Eng, Fabp4 
	   Stab1, Ly6a, Sparc, Fgg, Stab2, Egfl7, Dnase1l3, Fga, Ctsl, Ahsg 
	   Ptprb, Apoa1, Itih4, Kng1, Hp, Ramp2, Gc, C3, Cd55, Gpihbp1 
Negative:  Tyrobp, Wfdc17, Tmsb4x, Ctss, Lgals3, Cd74, H2-Aa, Ccl6, Laptm5, H2-Eb1 
	   C1qb, H2-Ab1, C1qa, C1qc, Aif1, Fcgr4, Ctsc, Cyba, Cybb, Ccl24 
	   Lst1, Cd5l, Fcer1g, Fcgr3, Cd52, Csf1r, Vsig4, Clec4f, Ifi27l2a, Cfp 
PC_ 3 
Positive:  mt-Nd2, mt-Nd1, mt-Nd4, mt-Nd3, mt-Nd5, mt-Nd4l, mt-Atp8, mt-Cytb, mt-Atp6, mt-Co2 
	   mt-Co1, mt-Co3, mt-Nd6, Akr1c6, Glul, Rgn, Gstm1, Gsta3, Oat, Pcp4l1 
	   Pebp1, Cyb5a, Car2, Fabp5, Gstp1, Car3, Gnmt, Gstm2, Akr1c20, Hmgb3 
Negative:  Hpx, Alb, Fgb, Fga, Fgg, C3, Itih4, Cp, Ahsg, Kng1 
	   Gc, Hp, Apob, Apoa1, Trf, Ambp, Fn1, Pzp, Itih3, Serpina1c 
	   Serpina1a, Apoh, Vtn, Malat1, Lcn2, Serpina1b, Serpina3k, C4b, Cfh, Plg 
PC_ 4 
Positive:  mt-Nd1, mt-Nd4, mt-Nd2, mt-Nd3, mt-Nd5, mt-Nd4l, mt-Atp8, mt-Cytb, Cp, C3 
	   Itih4, mt-Co1, Apob, Fn1, mt-Atp6, mt-Co2, Fga, mt-Co3, C4b, Pzp 
	   Cfh, Itih3, Alb, Plg, Hc, Serpina3n, mt-Nd6, Hpx, Pigr, Fgb 
Negative:  Akr1c6, Bhmt, Glul, Rgn, Gsta3, Fabp1, Saa2, Gstm1, Cdo1, Gnmt 
	   Hpd, Ass1, Cyb5a, Wfdc21, Saa1, Ttc36, Fbp1, Oat, Scp2, Dbi 
	   Ttr, Fabp5, Dnajc12, Hamp, Rida, Pebp1, Ddt, Mt2, Chchd10, Acaa2 
PC_ 5 
Positive:  C1qa, C1qc, Cd5l, C1qb, Clec4f, Vsig4, Sdc3, Ccl24, H2-Aa, H2-Ab1 
	   Ctsb, Cd74, H2-Eb1, Aif1, Slc40a1, Lgmn, Fcna, Csf1r, Timd4, Mafb 
	   Psap, Cfp, Folr2, C6, H2-DMb1, Adgre1, Marco, Hmox1, Cd163, Ear2 
Negative:  Ifitm1, Coro1a, S100a6, S100a11, Alox5ap, Pglyrp1, Cd52, Anxa1, S100a9, Lsp1 
	   S100a8, Rac2, Srgn, Plac8, Selplg, BC100530, Anxa2, Ltb, Ifitm6, Mcemp1 
	   Stfa2l1, Hmgb2, Retnlg, Asprv1, Ncf4, Slpi, Tmsb10, Slfn1, Csf3r, Arhgdib 
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

Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')

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
11:41:05 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:41:05 Read 7117 rows and found 20 numeric columns
11:41:05 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:41:05 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:41:07 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e3152be553
11:41:07 Searching Annoy index using 30 threads, search_k = 3000
11:41:08 Annoy recall = 100%
11:41:13 Commencing smooth kNN distance calibration using 30 threads
11:41:20 Initializing from normalized Laplacian + noise
11:41:21 Commencing optimization for 500 epochs, with 289362 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:41:52 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')

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
11:48:48 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:48:48 Read 7117 rows and found 20 numeric columns
11:48:48 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:48:48 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:48:51 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e337330f75
11:48:51 Searching Annoy index using 30 threads, search_k = 3000
11:48:51 Annoy recall = 100%
11:48:56 Commencing smooth kNN distance calibration using 30 threads
11:49:02 Initializing from normalized Laplacian + noise
11:49:02 Commencing optimization for 500 epochs, with 292872 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:49:33 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')

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
11:57:01 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:57:01 Read 7117 rows and found 20 numeric columns
11:57:01 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
11:57:01 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:57:03 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e35b2ee665
11:57:03 Searching Annoy index using 30 threads, search_k = 3000
11:57:03 Annoy recall = 100%
11:57:07 Commencing smooth kNN distance calibration using 30 threads
11:57:12 Initializing from normalized Laplacian + noise
11:57:13 Commencing optimization for 500 epochs, with 291784 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
11:57:43 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')

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
12:04:40 UMAP embedding parameters a = 0.9922 b = 1.112
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
12:04:40 Read 7117 rows and found 20 numeric columns
12:04:40 Using Annoy for neighbor search, n_neighbors = 30
Found more than one class "dist" in cache; using the first, from namespace 'BiocGenerics'
Also defined by 'spam'
12:04:40 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
12:04:43 Writing NN index file to temp file /tmp/slurm_21271346/RtmpuQjsGY/file80e3184c9a8a
12:04:43 Searching Annoy index using 30 threads, search_k = 3000
12:04:43 Annoy recall = 100%
12:04:47 Commencing smooth kNN distance calibration using 30 threads
12:04:54 Initializing from normalized Laplacian + noise
12:04:55 Commencing optimization for 500 epochs, with 289362 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
12:05:26 Optimization finished
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

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartA_QC.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/malanchii/nicolas.rabas/422_scRNAseq_liver_4T1/workdir/html_local/sc_PartA_QC.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:paper' --include-in-header /tmp/slurm_21271346/RtmpuQjsGY/rmarkdown-str80e34ea6d168.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/malanchii/nicolas.rabas/422_scRNAseq_liver_4T1/workdir/html_local/sc_PartA_QC.html
There were 50 or more warnings (use warnings() to see the first 50)
