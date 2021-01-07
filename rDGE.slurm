

processing file: sc_DGE_module.Rmd
  |                                                                              |                                                                      |   0%  |                                                                              |..                                                                    |   3%
  ordinary text without R code

  |                                                                              |.....                                                                 |   7%
label: setup (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |.......                                                               |  10%
  ordinary text without R code

  |                                                                              |..........                                                            |  14%
label: hpc_notes (with options) 
List of 1
 $ include: logi FALSE

  |                                                                              |............                                                          |  17%
  ordinary text without R code

  |                                                                              |..............                                                        |  21%
label: populate_meta_data_database (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol F
 $ results: symbol F

── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
✔ tibble  3.0.1     ✔ dplyr   1.0.0
✔ tidyr   1.1.0     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.5.0
✔ purrr   0.3.4     
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

Finished averaging RNA for cluster 1
Finished averaging SCT for cluster 1
Finished averaging integrated for cluster 1
Performing log-normalization
0%   10   20   30   40   50   60   70   80   90   100%
[----|----|----|----|----|----|----|----|----|----|
**************************************************|
Centering and scaling data matrix
  |                                                                              |                                                                      |   0%  |                                                                              |====                                                                  |   5%  |                                                                              |=======                                                               |  11%  |                                                                              |===========                                                           |  16%  |                                                                              |===============                                                       |  21%  |                                                                              |==================                                                    |  26%  |                                                                              |======================                                                |  32%  |                                                                              |==========================                                            |  37%  |                                                                              |=============================                                         |  42%  |                                                                              |=================================                                     |  47%  |                                                                              |=====================================                                 |  53%  |                                                                              |=========================================                             |  58%  |                                                                              |============================================                          |  63%  |                                                                              |================================================                      |  68%  |                                                                              |====================================================                  |  74%  |                                                                              |=======================================================               |  79%  |                                                                              |===========================================================           |  84%  |                                                                              |===============================================================       |  89%  |                                                                              |==================================================================    |  95%  |                                                                              |======================================================================| 100%
  |                                                                              |.................                                                     |  24%
   inline R code fragments

  |                                                                              |...................                                                   |  28%
label: CellTypePlot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |......................                                                |  31%
  ordinary text without R code

  |                                                                              |........................                                              |  34%
label: data_DGE_summary (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : symbol T
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |...........................                                           |  38%
  ordinary text without R code

  |                                                                              |.............................                                         |  41%
label: data_MA_plots (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : symbol T
 $ warning: logi FALSE
 $ results: chr "asis"

Scale for 'y' is already present. Adding another scale for 'y', which will
replace the existing scale.
  |                                                                              |...............................                                       |  45%
   inline R code fragments

  |                                                                              |..................................                                    |  48%
label: DGE_MA_plot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |....................................                                  |  52%
  ordinary text without R code

  |                                                                              |.......................................                               |  55%
label: data_Volcano_plots (with options) 
List of 4
 $ echo   : symbol F
 $ eval   : symbol T
 $ warning: logi FALSE
 $ results: chr "asis"

Scale for 'y' is already present. Adding another scale for 'y', which will
replace the existing scale.
  |                                                                              |.........................................                             |  59%
   inline R code fragments

  |                                                                              |...........................................                           |  62%
label: DGE_volcano_plot (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |..............................................                        |  66%
  ordinary text without R code

  |                                                                              |................................................                      |  69%
label: create-pca-enrichment-data (with options) 
List of 4
 $ echo   : symbol T
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

Loading required package: DBI
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


Attaching package: 'scales'

The following object is masked from 'package:purrr':

    discard

The following object is masked from 'package:readr':

    col_factor

  |                                                                              |...................................................                   |  72%
   inline R code fragments

  |                                                                              |.....................................................                 |  76%
label: create-cat-enrichment-plot (with options) 
List of 4
 $ echo   : symbol T
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |........................................................              |  79%
  ordinary text without R code

  |                                                                              |..........................................................            |  83%
label: documentation_saving (with options) 
List of 4
 $ echo   : logi TRUE
 $ eval   : logi TRUE
 $ warning: logi FALSE
 $ results: chr "asis"

  |                                                                              |............................................................          |  86%
  ordinary text without R code

  |                                                                              |...............................................................       |  90%
label: create_report_params (with options) 
List of 2
 $ eval   : symbol T
 $ results: chr "asis"

  |                                                                              |.................................................................     |  93%
  ordinary text without R code

  |                                                                              |....................................................................  |  97%
label: documentation (with options) 
List of 3
 $ eval   : logi TRUE
 $ echo   : symbol T
 $ results: symbol T

  |                                                                              |......................................................................| 100%
   inline R code fragments


output file: sc_DGE_module.knit.md

/camp/apps/eb/dev/software/Anaconda2/2019.10/bin/pandoc +RTS -K512m -RTS sc_DGE_module.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_DGE_module.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 3 --variable toc_float=1 --variable toc_selectors=h1,h2,h3 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --css /camp/stp/babs/working/boeings/Stefan/protocol_files/github/boeings/templates/style/style.css --variable 'theme:bootstrap' --include-in-header /tmp/slurm_20126376/RtmpZD0msi/rmarkdown-str658e25002bc8.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /camp/apps/misc/stp/babs/manual/software/r/r-site-library/bioc-3.9/rmarkdown/rmd/lua/latex-div.lua --variable code_folding=hide --variable code_menu=1 

Output created: /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/html_local/sc_DGE_module.html
Warning messages:
1: In gsub("X1", nameTag, names(dfAvgExpr)) :
  argument 'replacement' has length > 1 and only the first element will be used
2: In block_exec(params) :
  Failed to tidy R code in chunk 'create-pca-enrichment-data'. Reason:
Error in base::parse(text = code, keep.source = FALSE) : 
  <text>:93:10: unexpected SPECIAL
92: dfTemp <- unique ( dbcat2gmt (
93: dfTemp , %InLiNe_IdEnTiFiEr%
             ^

3: In getGmt(con = gmtfile) :
  928 record(s) contain duplicate ids: GO_14_3_3_PROTEIN_BINDING, GO_1_PHOSPHATIDYLINOSITOL_3_KINASE_ACTIVITY, ..., GO_ZINC_ION_BINDING, GO_ZINC_ION_TRANSMEMBRANE_TRANSPORTER_ACTIVITY
4: In getGmt(con = gmtfile) :
  1328 record(s) contain duplicate ids: BIOCARTA_41BB_PATHWAY, BIOCARTA_ACE2_PATHWAY, ..., ST_WNT_CA2_CYCLIC_GMP_PATHWAY, WNT_SIGNALING
5: In getGmt(con = gmtfile) :
  49 record(s) contain duplicate ids: HALLMARK_ADIPOGENESIS, HALLMARK_ANDROGEN_RESPONSE, ..., HALLMARK_WNT_BETA_CATENIN_SIGNALING, HALLMARK_XENOBIOTIC_METABOLISM
6: In getGmt(con = gmtfile) :
  4383 record(s) contain duplicate ids: A4_noradrenergic_cell_group_down, A4_noradrenergic_cell_group_up, ..., zonal_layer_of_SC_down, zonal_layer_of_SC_up
7: In block_exec(params) :
  Failed to tidy R code in chunk 'documentation_saving'. Reason:
Error in base::parse(text = code, keep.source = FALSE) : 
  <text>:125:34: unexpected SPECIAL
124: dbTableName = Obio @ parameterList $ rnaseqdbTableName ,
125: df.data = Obio @ databaseTable , %InLiNe_IdEnTiFiEr%
                                      ^

8: In in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE,  :
  You changed the working directory to /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir (probably via setwd()). It will be restored to /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/sc_dev. See the Note section in ?knitr::knit
9: In block_exec(params) :
  Failed to tidy R code in chunk 'create_report_params'. Reason:
Error in base::parse(text = code, keep.source = FALSE) : 
  <text>:41:1: unexpected symbol
40: invisible(".BeGiN_TiDy_IdEnTiFiEr_HaHaHa# gsub('([.|()\\\\^{}+$*?]|\\\\[|\\\\])', '\\\\\\\\\\1', x).HaHaHa_EnD_TiDy_IdEnTiFiEr")
41: gsub
    ^

