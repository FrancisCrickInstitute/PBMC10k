

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
Variance stabilizing transformation of count matrix of size 20571 by 2705
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 2705 cells
Found 1 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 20571 genes
Computing corrected count matrix for 20571 genes
Calculating gene attributes
Wall clock passed: Time difference of 1.798649 mins
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
10:11:55 UMAP embedding parameters a = 0.9922 b = 1.112
10:11:55 Read 2705 rows and found 20 numeric columns
10:11:55 Using Annoy for neighbor search, n_neighbors = 30
10:11:55 Building Annoy index with metric = cosine, n_trees = 50
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
10:11:56 Writing NN index file to temp file /tmp/slurm_19073176/Rtmp8NVoLY/file66e1988b0ff
10:11:56 Searching Annoy index using 1 thread, search_k = 3000
10:11:56 Annoy recall = 100%
10:11:58 Commencing smooth kNN distance calibration using 1 thread
10:12:02 Initializing from normalized Laplacian + noise
10:12:02 Commencing optimization for 500 epochs, with 110476 positive edges
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
10:12:12 Optimization finished
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
Variance stabilizing transformation of count matrix of size 21749 by 3607
Model formula is y ~ log_umi
Get Negative Binomial regression parameters per gene
Using 2000 genes, 3607 cells
Found 9 outliers - those will be ignored in fitting/regularization step

Second step: Get residuals using fitted parameters for 21749 genes
Computing corrected count matrix for 21749 genes
Calculating gene attributes
Wall clock passed: Time difference of 2.735258 mins
Determine variable features
Set 3000 variable features
Place corrected count matrix in counts slot
Centering data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
Set default assay to SCT
PC_ 1 
Positive:  scn4ab, fosb, hsp90aa1.2, f3b, prex2, dnajb1b, qkib, hsp70l, foxp4, gulp1a 
	   hspg2, ncam1b, mid2, ahnak, hsp70.1, ank2b, sorcs2, ablim1b, foxo1a, col15a1b 
	   gabbr2, anxa2a, celf2, col14a1a, fosl1a, nfatc2a, socs3a, itgb4, cdh4, ppp2r3a 
Negative:  nos1, CR392045.1, ebf3a, rims3, vipb, grid1b, cadm4, cntn3b, myo16, nrxn2a 
	   tph1b, slit3, dscamb, nmu, unc5a, etv1, camk1gb, CR407584.1, ptprfa, dlg2 
	   gfra1a, clstn2, cadpsa, si:dkey-1f12.3, kcnd2, prkg1b, arpp21, ddc, alcama, BX571942.1 
PC_ 2 
Positive:  tph1b, myo16, gfra2a, bnc2, ntm, ddc, slc18a2, nkain2, shank3a, crhbp 
	   si:dkey-71h2.2, satb2, slc6a4b, BX571942.1, cadm4, FO907089.1, arpp21, si:dkey-1f12.3, BX571707.1, wnk4b 
	   trpc4b, si:dkey-112m2.1, adcyap1r1a, CLSTN2 (1 of many), tnfaip8l3, iqsec2b, tacr1a, cntn3b, drp2, gria3a 
Negative:  grid1b, nmu, ptprt.1, nrxn2a, pitpnm3, CR407584.1, ntrk1, dlg2, prkg1b, cadpsa 
	   sdk1b, calcrla, grid1a, chata, si:ch211-207d6.2, nav3, etv1, cpne7, cacna1da, pde4cb 
	   grid2, tox, asic2, KCNB2, myo3b, stxbp5l, cntn4, gfra1a, scn1laa, klhl4 
PC_ 3 
Positive:  nos1, ebf3a, rims3, CR392045.1, kif26ba, camk1gb, vipb, dscamb, BX248331.2, ptprfb 
	   ptprfa, adcyap1b, kif26aa, scube3, pcdh7b, si:dkey-21e5.1, fxyd6, PLEKHH3, kcnma1a, tac1 
	   oprl1, lrrc4ca, si:dkeyp-120h9.1, unc5da, cntn3b, atp2b3b, klhl5, CR855860.1, col8a1b, arhgef1a 
Negative:  grid1b, nmu, ptprt.1, pitpnm3, tph1b, myo16, ntrk1, thsd7ba, nrxn2a, ntm 
	   gfra2a, bnc2, ddc, asic2, slc18a2, cadpsa, nav3, cacna1da, sdk1b, chata 
	   cpne7, dlg2, grid1a, calcrla, si:ch211-207i1.2, khdrbs2, nkain2, CR407584.1, myo3b, KCNB2 
PC_ 4 
Positive:  pbx3b, nr5a2, cftr, arhgap42b, cdh1, clcn1b, zgc:193726, arhgap29a, BX855618.1, FP236822.1 
	   epcam, cldn15a, slc4a4b, aqp8a.1, shank3a, nectin1b, dab2ipb, BX537310.1, CR396595.1, rassf7b 
	   tanc1b, BX005154.1, ANPEP, spns2, prox1a, igsf5b, c5, si:dkey-96g2.1, cxadr, si:ch73-22o12.1 
Negative:  scn4ab, ntm, ank2b, prex2, qkib, ncam1b, gabbr2, mid2, cdh4, sorcs2 
	   hsp90aa1.2, ppp2r3a, col15a1b, itgb4, nfatc2a, celf2, ablim1b, col14a1a, gulp1a, chl1b 
	   nlgn3a, afap1l1a, cadm1a, crip1, adgrg6, grm8a, limch1b, anxa2a, foxo1a, sorbs3 
PC_ 5 
Positive:  cftr, pbx3b, f3b, arhgap42b, clcn1b, zgc:193726, fosb, BX855618.1, shank3a, epcam 
	   BX005154.1, cldn15a, ebf3a, cdh1, slc4a4b, dab2ipb, foxp4, rims3, pvrl2l, aqp8a.1 
	   CR392045.1, fosl1a, arhgap29a, nectin1b, hsp70.1, tanc1b, c5, si:dkey-96g2.1, spns2, ntrk1 
Negative:  prss1, cela1.6, ctrb1, ctrl, ela3l, cpb1, prss59.2, cpa5, prss59.1, cel.1 
	   cel.2, zgc:112160, ela2l, si:ch211-240l19.8, si:ch211-240l19.6, zgc:136461, ela2, cela1.5.1, c6ast3, sycn.1 
	   sycn.2, zgc:92590, bhmt, cpa1, si:ch211-240l19.5, pla2g1b, c6ast4, amy2a, CT027638.1, cpa2 
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

/camp/apps/misc/stp/babs/conda/envs/R_deps/bin/pandoc +RTS -K512m -RTS sc_PartA_QC.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output sc_PartA_QC.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 5 --variable toc_float=1 --variable toc_selectors=h1,h2,h3,h4,h5 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_19073176/Rtmp8NVoLY/rmarkdown-str66e646d8d1c.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: sc_PartA_QC.html
There were 50 or more warnings (use warnings() to see the first 50)
