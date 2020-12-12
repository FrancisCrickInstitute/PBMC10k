

processing file: sc_PartA_QC.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
  ordinary text without R code

  |                                                                              |...                                                                   |   4%
label: setup (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |....                                                                  |   5%
  ordinary text without R code

  |                                                                              |.....                                                                 |   7%
label: hpc_notes (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |......                                                                |   9%
  ordinary text without R code

  |                                                                              |........                                                              |  11%
label: init (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol T

  |                                                                              |.........                                                             |  13%
  ordinary text without R code

  |                                                                              |..........                                                            |  15%
label: dbpwd (with options) 
List of 2
 $ eval: symbol T
 $ echo: symbol F

  |                                                                              |...........                                                           |  16%
  ordinary text without R code

  |                                                                              |.............                                                         |  18%
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

  |                                                                              |..............                                                        |  20%
  ordinary text without R code

  |                                                                              |...............                                                       |  22%
label: saveobject (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |.................                                                     |  24%
  ordinary text without R code

  |                                                                              |..................                                                    |  25%
label: create_QC_Table (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |...................                                                   |  27%
  ordinary text without R code

  |                                                                              |....................                                                  |  29%
label: render_QCTable (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |......................                                                |  31%
  ordinary text without R code

  |                                                                              |.......................                                               |  33%
label: QC_raw_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |........................                                              |  35%
  ordinary text without R code

  |                                                                              |.........................                                             |  36%
label: Plot_tsne_data_plotting (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...........................                                           |  38%
  ordinary text without R code

  |                                                                              |............................                                          |  40%
label: start_seurat (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 15150 by 11594
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 11594 cells
Found 8 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 15150 genes
Computing corrected count matrix for 15150 genes
Calculating gene attributes
Wall clock passed: Time difference of 7.12457 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
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
14:20:52 UMAP embedding parameters a = 0.9922 b = 1.112
14:20:52 Read 11594 rows and found 20 numeric columns
14:20:52 Using Annoy for neighbor search, n_neighbors = 30
14:20:52 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:20:55 Writing NN index file to temp file /tmp/slurm_19561853/RtmpSetb5P/file549f6380e9d4
14:20:55 Searching Annoy index using 1 thread, search_k = 3000
14:21:00 Annoy recall = 100%
14:21:04 Commencing smooth kNN distance calibration using 1 thread
14:21:10 Initializing from normalized Laplacian + noise
14:21:11 Commencing optimization for 200 epochs, with 483630 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:21:32 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 16286 by 7227
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 7227 cells
Found 11 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 16286 genes
Computing corrected count matrix for 16286 genes
Calculating gene attributes
Wall clock passed: Time difference of 4.241344 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:27:18 UMAP embedding parameters a = 0.9922 b = 1.112
14:27:18 Read 7227 rows and found 20 numeric columns
14:27:18 Using Annoy for neighbor search, n_neighbors = 30
14:27:18 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:27:20 Writing NN index file to temp file /tmp/slurm_19561853/RtmpSetb5P/file549f310cefca
14:27:20 Searching Annoy index using 1 thread, search_k = 3000
14:27:22 Annoy recall = 100%
14:27:26 Commencing smooth kNN distance calibration using 1 thread
14:27:33 Initializing from normalized Laplacian + noise
14:27:33 Commencing optimization for 500 epochs, with 304714 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:28:05 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 16149 by 7356
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 7356 cells
Found 12 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 16149 genes
Computing corrected count matrix for 16149 genes
Calculating gene attributes
Wall clock passed: Time difference of 4.435761 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:33:52 UMAP embedding parameters a = 0.9922 b = 1.112
14:33:52 Read 7356 rows and found 20 numeric columns
14:33:52 Using Annoy for neighbor search, n_neighbors = 30
14:33:52 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:33:54 Writing NN index file to temp file /tmp/slurm_19561853/RtmpSetb5P/file549f4852acdd
14:33:54 Searching Annoy index using 1 thread, search_k = 3000
14:33:57 Annoy recall = 100%
14:34:01 Commencing smooth kNN distance calibration using 1 thread
14:34:07 Initializing from normalized Laplacian + noise
14:34:08 Commencing optimization for 500 epochs, with 305198 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:34:40 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Warning: Feature names cannot have underscores ('_'), replacing with dashes ('-')
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 15874 by 7030
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 7030 cells
Found 21 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 15874 genes
Computing corrected count matrix for 15874 genes
Calculating gene attributes
Wall clock passed: Time difference of 4.208803 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
Calculating gene variances
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Calculating feature variances of standardized and clipped values
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:40:04 UMAP embedding parameters a = 0.9922 b = 1.112
14:40:04 Read 7030 rows and found 20 numeric columns
14:40:04 Using Annoy for neighbor search, n_neighbors = 30
14:40:04 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:40:06 Writing NN index file to temp file /tmp/slurm_19561853/RtmpSetb5P/file549f145a9d8b
14:40:06 Searching Annoy index using 1 thread, search_k = 3000
14:40:08 Annoy recall = 100%
14:40:12 Commencing smooth kNN distance calibration using 1 thread
14:40:18 Initializing from normalized Laplacian + noise
14:40:19 Commencing optimization for 500 epochs, with 296298 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
14:40:49 Optimization finished
Computing nearest neighbor graph
Computing SNN
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
  |                                                                              |.............................                                         |  42%
  ordinary text without R code

  |                                                                              |...............................                                       |  44%
label: percent_mt (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

mixtools package, version 1.2.0, Released 2020-02-05
This package is based upon work supported by the National Science Foundation under Grant No. SES-0518772.

  |                                                                              |................................                                      |  45%
  ordinary text without R code

  |                                                                              |.................................                                     |  47%
label: Plot_percentMT_hist (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................                                    |  49%
  ordinary text without R code

  |                                                                              |....................................                                  |  51%
label: nFeature_data (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |.....................................                                 |  53%
  ordinary text without R code

  |                                                                              |......................................                                |  55%
label: Plot_nFeatureRNA_hist (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.......................................                               |  56%
  ordinary text without R code

  |                                                                              |.........................................                             |  58%
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

  |                                                                              |..........................................                            |  60%
  ordinary text without R code

  |                                                                              |...........................................                           |  62%
label: Plot_UMAP (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.............................................                         |  64%
  ordinary text without R code

  |                                                                              |..............................................                        |  65%
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
Variance stabilizing transformation of count matrix of size 16078 by 15459
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 15459 cells
Found 28 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 16078 genes
Computing corrected count matrix for 16078 genes
Calculating gene attributes
Wall clock passed: Time difference of 15.37193 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Apod, Scn7a, Prnp, Chl1, Scd2, Kcna2, Itih5, Cdh19, Timp3, Sfrp1 
	   Kcna1, Plp1, C4b, Ank3, Matn2, Abca8a, Gsn, Postn, Zbtb20, Rarres2 
	   Gpr37l1, Dst, Col20a1, Lgi4, Gpm6b, Pmepa1, Adam23, Cd59a, Igfbp7, Scarb2 
Negative:  C1qb, C1qa, C1qc, Cd74, Lyz2, Fcer1g, H2-Aa, H2-Ab1, H2-Eb1, Ctss 
	   Tyrobp, Laptm5, Ctsc, Pf4, Ly86, Cd52, Ptpn18, Aif1, Csf1r, Lcp1 
	   Fcgr3, Ccl6, Mgl2, Srgn, Mpeg1, Alox5ap, Cybb, Mrc1, Dab2, Ccl12 
PC_ 2 
Positive:  Fos, Junb, Jun, Zfp36, Egr1, Btg2, Socs3, Hspa1a, Apod, Cebpd 
	   Jund, Atf3, Gm26532, Dusp1, Fosb, Hspa1b, Hes1, Cyr61, Fabp5, G0s2 
	   Ier3, Cxcl1, Ier2, Ubc, H3f3b, Phlda1, Ifi27l2a, Prnp, Sat1, Rnd3 
Negative:  Tpm2, Acta2, Tagln, Cpe, Mylk, Des, Rgs5, Actg2, Tpm1, Myh11 
	   Cnn1, Myl9, Myl6, Grem1, Actn1, Synpo2, Ppp1r14a, Pgm5, Pdlim3, Dmpk 
	   mt-Co3, Pcp4, Chrm2, Fbxl22, Mustn1, Flna, Tnnt2, Sh3bgr, mt-Atp6, Pcp4l1 
PC_ 3 
Positive:  Gm42418, Crip1, Itih5, Ifi27l2a, Matn2, Prnp, Tmsb10, Aldh1a1, AY036118, B2m 
	   Kcna1, Apod, Marcks, Anxa5, Igfbp7, Scn7a, H2-D1, Pappa, Col3a1, Col20a1 
	   Gpm6b, Slitrk6, Prss23, Kcna2, Rarres2, Pdgfa, Postn, Sfrp5, Abca8a, Abca8b 
Negative:  Fos, Junb, Jun, Egr1, Zfp36, Ier2, Cpe, Socs3, Fosb, Cyr61 
	   Btg2, Atf3, Cebpd, Dusp1, Gm26532, Jund, Nr4a1, Hspa1a, Hes1, Slc18a2 
	   Dnajb1, Col9a2, Ramp1, Mt1, Dkk3, Nfkbiz, Klf2, Ier3, Ubc, G0s2 
PC_ 4 
Positive:  Fos, Tpm2, Des, Actg2, Tagln, Mylk, Acta2, Tpm1, Myh11, Myl9 
	   Myl6, Cnn1, Rgs5, Junb, Jun, Grem1, Jund, Hspa1a, Dstn, Synpo2 
	   Ppp1r14a, Apod, Fabp5, Pgm5, Fbxl22, Pdlim3, Mustn1, Cebpd, Btg2, Actn1 
Negative:  Cpe, Slc18a2, Col9a2, Pcsk1n, mt-Co3, mt-Co2, Gm42418, mt-Nd1, mt-Nd2, mt-Cytb 
	   mt-Co1, Ramp1, mt-Atp6, Dkk3, Col12a1, Apoe, mt-Nd3, mt-Nd4, Ctsb, Cst3 
	   Cpxm2, Ctgf, Fbln2, Igfbp4, Hmcn1, Scg3, Hey2, Entpd2, Col11a1, Meg3 
PC_ 5 
Positive:  C4b, Scn7a, Scd2, Acta2, Chl1, Myh11, Mylk, Gm26870, Actg2, Tagln 
	   mt-Nd2, Des, Timp3, Tpm2, mt-Atp6, mt-Co3, Cnn1, mt-Cytb, Postn, Adam11 
	   mt-Nd4, Sfrp1, Ctgf, Col12a1, Gsn, Abca8a, Scarb2, Col20a1, mt-Co2, Adam23 
Negative:  Scg2, Stmn2, Pcsk1n, Elavl4, Rtn1, Bex2, Syt1, Ptprn, Stmn3, Meg3 
	   Prph, Atp1b1, Eef1a2, Snhg11, Snap25, Resp18, Rab3c, Epha5, Celf4, Uchl1 
	   Ly6h, Chgb, Gng3, Tm4sf4, Rps24, Tmem59l, Spock2, Vstm2l, Slc5a7, Caly 
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 17034 by 9636
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 9636 cells
Found 11 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 17034 genes
Computing corrected count matrix for 17034 genes
Calculating gene attributes
Wall clock passed: Time difference of 11.82345 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Atf3, Malat1, Apod, Igfbp7, Gfap, Gadd45a, Ccl2, Adamtsl1, Gap43, mt-Co1 
	   Apoe, mt-Nd4, Tgfbi, Cd59a, Azin1, Col5a2, Fgl2, Plin2, Ank3, Cebpd 
	   Olfml3, Dtna, Cpe, Jun, Prnp, Kcna1, Gsn, Fos, Fam129a, Plp1 
Negative:  Hmgb2, Ube2c, Top2a, H2afz, Cenpf, Pclaf, Cdk1, Birc5, Cks2, Tubb4b 
	   Tuba1b, Prc1, Cdc20, Mki67, Ube2s, Ccnb1, Ran, Tpx2, Arl6ip1, Ccna2 
	   Nusap1, Ranbp1, Smc4, Cenpe, Hmmr, Ncl, Smc2, Cdca8, Cks1b, Ptma 
PC_ 2 
Positive:  Ass1, S100a6, Ftl1, Ccnd1, Ascl1, Npm1, Hsp90ab1, Ppp1r14b, Aprt, Spp1 
	   Anxa3, Insm1, Gsta4, Tm4sf1, Rps18, Ncl, Gchfr, Sec11c, Rpl12, Fam181b 
	   Rps2, Tpm1, Odc1, Srm, Rps26, Rps27a, Lgals1, Eif5a, Hspd1, Rps27l 
Negative:  Ube2c, Top2a, Cenpf, Prc1, Nusap1, Hmgb2, Cdk1, Arl6ip1, Cenpe, Mki67 
	   Cks2, Ccnb1, Tpx2, Cdc20, Birc5, Hmmr, Aspm, Igfbp7, H2afx, Cenpa 
	   Malat1, Plk1, Spc25, Cdca8, Smc4, Mis18bp1, Smc2, Fam64a, Aurkb, Aurka 
PC_ 3 
Positive:  mt-Nd2, mt-Co2, mt-Co3, mt-Nd4, Malat1, mt-Cytb, mt-Atp6, mt-Nd1, mt-Co1, mt-Nd3 
	   Xist, mt-Nd4l, mt-Nd5, Ascl1, Col18a1, Ass1, Fn1, Spp1, Col5a2, AY036118 
	   Phox2b, Top2a, Cpe, Insm1, Htr3a, Pxdn, Adamtsl1, Hes6, mt-Nd6, Ret 
Negative:  Fabp5, Fth1, Igfbp7, Ifi27l2a, Dbi, Vim, Prnp, Cebpd, Ppia, Actb 
	   Pmp22, Crip1, Tmsb10, Tmsb4x, Arpc1b, Serpina3n, S100a4, Tpt1, Ifitm3, Dhrs1 
	   Sparc, Rarres2, Rps2, Plp1, Crym, Rpsa, Eef1a1, Pdlim4, Anxa5, Rpl32 
PC_ 4 
Positive:  mt-Nd2, mt-Co2, mt-Nd1, mt-Nd4, mt-Co3, mt-Cytb, mt-Atp6, Fabp5, mt-Nd3, mt-Co1 
	   Pmp22, Ifi27l2a, Itgav, Crym, Itga6, Fth1, mt-Nd4l, AY036118, Col5a3, Col4a1 
	   Mal, Igfbp7, Col4a2, Serpina3n, mt-Nd5, Scn7a, Plscr2, Pdlim4, Scd2, Sorbs2 
Negative:  Gap43, Atf3, Apod, Gadd45a, Spp1, Tgfbi, Ascl1, Ass1, Fam19a5, Cpe 
	   Olfml3, Tmem158, Runx2, Gadd45g, Dok4, Ube2c, Cryab, Fgl2, Adamtsl1, Btc 
	   C1ql1, Wisp1, Tubb3, Phox2b, Igf1, Cd63, Ucn2, Tmod1, Hmgb2, Arsi 
PC_ 5 
Positive:  Tgfbi, Poc1a, Gap43, Rgcc, Olfml3, Cryab, Entpd2, Fam19a5, Gfap, Gadd45a 
	   Hspd1, Dok4, Sox10, Adamtsl1, Cpe, Ngfr, Cops9, Crym, Tagln2, Gpc1 
	   Hspe1, Epha5, Tmod1, Aqp1, Fn1, Col11a1, Plin2, Peg3, Prr7, Col27a1 
Negative:  Ascl1, Ass1, Htr3a, Ret, Fth1, Hes6, Insm1, Ifitm3, Ifi27l2a, Igfbp7 
	   Sec11c, Phox2b, Cdkn1a, Elavl4, Gal, Malat1, Nrn1, Rarres2, Atp1a1, Gsta4 
	   Fam181b, Etv1, Kcne1l, Scg5, Dpysl3, Bgn, Pdlim4, Apoe, Penk, C130073E24Rik 
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 16866 by 9808
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 9808 cells
Found 19 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 16866 genes
Computing corrected count matrix for 16866 genes
Calculating gene attributes
Wall clock passed: Time difference of 11.73591 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Apoe, Igfbp5, Sostdc1, Crlf1, Plp1, Dbi, Sox10, Mal, Fabp5, Nid1 
	   Arpc1b, Entpd2, Vim, Gatm, Egfl8, Hist1h1c, Mpz, Pou3f1, Cadm4, Prss12 
	   Zeb2, Mt1, Ctsc, Col14a1, Ahnak, Sparcl1, Sod3, Gas7, Sncg, Vwa1 
Negative:  Ass1, Crabp1, Penk, Ly6a, Phox2b, Htr3a, Cdkn1a, Tmsb4x, C1ql1, Dio2 
	   Aldh1a1, Gal, Efemp1, Ascl1, Dpysl3, Elavl4, S100a6, Gja1, Fstl1, Itm2b 
	   Bglap2, Tm4sf1, Bgn, Col8a1, Mpc1, Cxcl5, Ret, Anxa3, Pam, Id1 
PC_ 2 
Positive:  Gal, Elavl4, Htr3a, Scg5, Bglap2, Cox8b, Etv1, Npy, Dpysl3, Bub3 
	   Pirt, Stmn3, Sox4, Cd24a, Syt1, Ntm, Smpd3, C1ql1, Fam181b, Bex2 
	   Phox2b, Penk, Trbc2, Hes6, Tubb3, Kcne1l, Ppp1r14b, Ptprg, Bgn, Mllt11 
Negative:  Birc5, Top2a, Ube2c, Pclaf, Tpx2, Cdk1, Mki67, Ly6a, Cenpf, Nusap1 
	   Prc1, Hmmr, Cdca3, Hmgb2, H2afz, Cks2, Stmn1, Pbk, Cdca8, Cenpa 
	   Tuba1b, Smc2, Ccna2, Cdc20, Spc25, Crabp1, Ccnb1, Spc24, Ccnb2, Tubb4b 
PC_ 3 
Positive:  Ly6a, Crabp1, Cxcl5, Ass1, Plpp3, Dio2, Aldh1a1, Efemp1, Col8a1, Ccl2 
	   Gsn, Cyr61, Pde1a, Gja1, Cebpd, Junb, Gchfr, Col3a1, Fos, Igfbp7 
	   Fth1, Timp3, Klf4, Ier2, Col1a1, Serpinb6a, Pdlim2, Prelp, Hsd11b1, Ccnd1 
Negative:  Gal, Elavl4, Stmn1, H2afz, Scg5, Birc5, Bub3, Htr3a, Pclaf, Ube2c 
	   Bglap2, Top2a, Tubb5, Cox8b, Cenpf, Tpx2, Calm2, Mki67, Nusap1, Etv1 
	   Hmmr, Cdk1, Prc1, Hmgb2, Dpysl3, Cdca3, Npy, Smc2, Pbk, Cdca8 
PC_ 4 
Positive:  Sostdc1, Pou3f1, Cdkn1c, Crlf1, Sncg, Prss12, Tyrp1, Hist1h1c, Limch1, Fbln5 
	   Egfl8, Mlip, Id2, Mpz, Bzw2, Igfbp5, Mal, C1ql3, Ctsc, Nkd1 
	   Fjx1, Ass1, Kif21a, Sparcl1, Sod3, Lurap1l, Pde10a, Penk, Ucp2, Kcnq1ot1 
Negative:  Gap43, Lgals3, Apod, Fxyd1, Ptn, Entpd2, Serpina3n, Tgfbi, Klk8, Ccl2 
	   Epha5, Gas7, Csmd1, Mmp2, Tagln2, Ngfr, Cryab, Arpc1b, Fam129a, Aqp1 
	   Tubb2b, Ifit3, Jun, Tmsb10, Itm2a, Dbi, Prkcdbp, Postn, Anxa2, Synpr 
PC_ 5 
Positive:  Penk, Ascl1, Htr3a, Igfbp5, Apoe, C1ql1, Phox2b, Crabp1, Kcne1l, Atp1a1 
	   Gm42418, Malat1, Ndnf, Tmem108, Zbtb20, Tgfb2, AY036118, Sox4, Olfml3, Dkk3 
	   Gsn, Itm2b, Kctd12, Cd59a, Elavl2, Igfbp7, Olfm2, Plod2, Bgn, Nid1 
Negative:  Gal, Stmn3, Ccnd1, Tm4sf1, Cxcl5, Gchfr, Bex2, Ly6a, Sostdc1, Chga 
	   Tubb3, Ccl2, Tuba1a, Timp1, Crlf1, Calm1, Calm2, S100a6, Gap43, Fdps 
	   Actg1, Klf4, Areg, Mllt11, Actb, S100a10, Calb1, Trbc2, Tagln, Crmp1 
Calculating cell attributes for input UMI matrix
Variance stabilizing transformation of count matrix of size 16544 by 9373
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 9373 cells
Found 18 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 16544 genes
Computing corrected count matrix for 16544 genes
Calculating gene attributes
Wall clock passed: Time difference of 10.34954 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  Malat1, Pou3f1, Tyrp1, Apoe, Mpz, Cdkn1c, Plp1, Sostdc1, Igfbp5, Apod 
	   Crlf1, Egfl8, Entpd2, Nid1, Mal, Csrp2, Pmp22, Prss12, Aebp1, Epha5 
	   Postn, Col18a1, Fxyd6, Vwa1, Gldn, Nkd1, Aqp1, Cxcl14, Sox10, Lgals3 
Negative:  Ass1, Htr3a, Tm4sf1, Pcsk1n, Gal, Penk, Stmn3, Scg5, Dpysl3, Elavl4 
	   C1ql1, Phox2b, Bex2, Scg2, Meg3, Ifitm2, Snhg11, Pirt, Areg, Stmn2 
	   Atp1b1, Uchl1, Bglap2, Tubb3, Chga, Vip, Tm4sf4, Nrn1, Basp1, Fgf13 
PC_ 2 
Positive:  Apod, Aebp1, Entpd2, Ptn, Postn, Tnc, Nid1, Lgals3, Tgfbi, Aqp1 
	   Olfml3, Col18a1, Igfbp5, Col5a2, Crabp1, Igfbp7, Chl1, Gap43, Matn2, Anxa1 
	   Ccl2, Adamts1, Epha5, Ctsb, Emp3, Edil3, Serpina3n, Col1a1, Gpnmb, Col14a1 
Negative:  Pou3f1, Cdkn1c, Tyrp1, Mpz, Fxyd6, Csrp2, Pmp22, Sostdc1, Egfl8, Plp1 
	   Prss12, Cuedc2, Id2, Nkd1, Mbp, Ybx1, Mal, Cxcl14, Pllp, Cldn19 
	   Syt4, Neat1, Kcnq1ot1, Limch1, Dkk3, Cnp, Mag, Sncg, Lmo1, Bzw2 
PC_ 3 
Positive:  Crabp1, Penk, Ly6a, Fth1, Serf2, Tmsb10, Dbi, Gng5, Gpx1, Dio2 
	   Cryab, Ifitm3, Igfbp7, Selenow, Cdkn1a, Prdx1, Gapdh, Elob, Anxa1, Crip2 
	   Ost4, Rps2, Rps20, Gng11, Rpl41, Efemp1, S100a11, Atp5e, Igfbp4, Rps27l 
Negative:  Malat1, Stmn3, Stmn2, Apod, Scg2, Scg5, Meg3, Bex2, Snhg11, Pcsk1n 
	   Nid1, Igfbp5, Vip, Postn, mt-Co3, Tubb3, mt-Nd2, Htr3a, Aqp1, Col18a1 
	   Entpd2, Chga, Apoe, Aebp1, mt-Atp6, Tnc, mt-Nd4l, Tyrp1, Ptn, Rtn1 
PC_ 4 
Positive:  Malat1, Penk, Ass1, Gal, Tm4sf1, C1ql1, Fstl1, Npy, Gsta4, Ly6a 
	   Cdkn1a, Bglap2, Bgn, Mgst1, Anxa3, Trf, Ccnd2, Tm4sf4, Col3a1, Slco3a1 
	   Apoe, Bace2, Fam181b, Dio2, Ifitm3, Vcam1, mt-Nd2, Igfbp7, Itm2b, mt-Co3 
Negative:  Stmn2, Tmsb10, Bex2, Tubb3, Vip, Rtn1, Stmn3, Gap43, Gng3, Lgals3 
	   Snhg11, Meg3, Scg2, Cryab, Nap1l5, Ly6h, Fabp5, Tubb2a, Dbi, Uchl1 
	   Eef1a2, Tuba1a, Ttc9b, Mllt11, Stmn1, Tppp3, Tubb2b, Aldoc, AW551984, Syngr3 
PC_ 5 
Positive:  Gal, Apod, C1ql1, Ptn, Tnc, Bglap2, Npy, Aebp1, Pou3f1, Tm4sf4 
	   Lrtm1, Cdkn1c, Gap43, Fxyd6, Csrp2, Cdkn1a, Htr3a, Tmem158, Ntm, Lgals3 
	   Adamts1, Tgfbi, Elavl4, Postn, Pirt, Ccnd1, Rbp1, Mbp, Col5a2, Gpc1 
Negative:  Malat1, Apoe, Crabp1, Ly6a, Igfbp7, Cyr61, Igfbp5, Sostdc1, Fth1, Stmn2 
	   Ass1, Rarres2, Ccl2, Plpp3, Dio2, Cd9, Efemp1, Col3a1, Crlf1, Rtn1 
	   Meg3, Igfbp4, Vip, Ier2, Basp1, Aldh1a1, Ifitm3, Gng3, Cebpd, Snhg11 
  |                                                                              |...............................................                       |  67%
  ordinary text without R code

  |                                                                              |................................................                      |  69%
label: Plot_DF (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..................................................                    |  71%
  ordinary text without R code

  |                                                                              |...................................................                   |  73%
label: UMAP_percentage (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |....................................................                  |  75%
  ordinary text without R code

  |                                                                              |.....................................................                 |  76%
label: Plot_percent_MT (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |.......................................................               |  78%
  ordinary text without R code

  |                                                                              |........................................................              |  80%
label: UMAP_nFeatures (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: symbol F

  |                                                                              |.........................................................             |  82%
  ordinary text without R code

  |                                                                              |...........................................................           |  84%
label: Plot_nFeatureRNA (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |............................................................          |  85%
  ordinary text without R code

  |                                                                              |.............................................................         |  87%
label: saveobject_end (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |..............................................................        |  89%
  ordinary text without R code

  |                                                                              |................................................................      |  91%
label: saveSampleList (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol F

  |                                                                              |.................................................................     |  93%
  ordinary text without R code

  |                                                                              |..................................................................    |  95%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T

  |                                                                              |...................................................................   |  96%
  ordinary text without R code

  |                                                                              |..................................................................... |  98%
label: create_report_params (with options) 
List of 2
 $ eval   : symbol T
 $ results: chr "asis"

Loading required package: DBI
  |                                                                              |......................................................................| 100%
   inline R code fragments


output file: sc_PartA_QC.knit.md

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_PartA_QC.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output sc_PartA_QC.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_19561853/RtmpSetb5P/rmarkdown-str549f2048bb62.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: sc_PartA_QC.html
There were 50 or more warnings (use warnings() to see the first 50)
