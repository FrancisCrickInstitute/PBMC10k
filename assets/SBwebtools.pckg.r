

library("methods")
library(DESeq2)

setClass(
    "bioLOGIC", 
    representation(
        clusterSigEnrichmentList = "list",
        documentationParams = "list",
        sampleDetailList = "list",
        dbDetailList = "list",
        projectDetailList = "list",
        scDetailList = "list",
        referenceTableList = "list",
        parameterList = "list",
        dfGeneAnnotation = "data.frame",
        dfPCA = "data.frame",
        dfPCAgenes = "data.frame",
        PCApercentVar = "numeric",
        dfTPM = "data.frame",
        dfFPKM = "data.frame",
        RSEMcountMatrix = "matrix",
        dfDesign = "data.frame",
        dfSummary = "data.frame",
        databaseTable = "data.frame",
        reportVec = "character",
        scriptVec = "character",
        documentationVector = "character",
        GSEAtableList = "list",
        categoryViewTableList = "list",
        plotCollection = "list",
        ObjDds = "DESeqDataSet",
        DESeqNormReadCountsTable = "data.frame",
        DEseq2contrastTable = "data.frame",
        DEseq2LRTtable = "data.frame",
        enrichmentList = "list",
        dataTableList = "list"
    )
)


setClass(
    "bioLOGIC_proteomics",
    contains = "bioLOGIC",
    slots = c(
        extra = "character"
    )
)

setClass(
    "bioLOGIC_singleCell",
    contains = "bioLOGIC"
)

setClass(
    "bioLOGIC_ATACseq",
    contains = "bioLOGIC"
)

setClass(
    "bioLOGIC_bulkRNAseq",
    contains = "bioLOGIC"
)




###############################################################################
## Add to Seurat metadata                                                    ##
setGeneric(
    name="addDf2seuratMetaData",
    def=function(obj, dfAdd) {
        print(paste0("Dims before addition: ", dim(obj@meta.data)))
        
        for (i in 1:ncol(dfAdd)){
            addVec <- as.vector(dfAdd[,i])
            names(addVec) <- row.names(dfAdd)
            colName <- as.vector(names(dfAdd)[i])
            obj <- AddMetaData(
                object = obj, 
                metadata = addVec, 
                colName
            )
        }
        
        print(paste0("Dims after addition: ", dim(obj@meta.data)))
        print(paste0("Meta data column names: ", paste(names(obj@meta.data), collapse = ", ")))
        return(obj)
    }
)

## Done adding to Seurat metadata                                            ##
###############################################################################

###############################################################################
## Add to script vector                                                      ##

setGeneric(
    name="add2vec",
    def=function(obj, slot_name, value) {
        `slot<-`(obj,slot_name,value=c(slot(obj,slot_name),value))
    }
)

setGeneric(
    name="setMountingPoint",
    def=function(obj) {
        if (dir.exists("/Volumes/babs/working/boeings/")){
            hpcMount <- "/Volumes/babs/working/boeings/"
        } else if (dir.exists("Y:/working/boeings/")){
            hpcMount <- "Y:/working/boeings/"
        } else if (dir.exists("/camp/stp/babs/working/boeings/")){
            hpcMount <- "/camp/stp/babs/working/boeings/"
        } else {
            hpcMount <- ""
        }
        
        obj@parameterList$hpcMount <- hpcMount
        
        
        
        return(obj)
    }
)


setGeneric(
    name="setAnalysisPaths",
    def=function(obj) {
        obj@parameterList$AlignSampleDir <- paste0(obj@parameterList$workdir, "RSEM/Ensembl")
        obj@parameterList$AlignOutputEnsDir <- paste0(obj@parameterList$workdir, "RSEM/Ensembl/")
        obj@parameterList$FASTQCdir <- paste0(obj@parameterList$workdir, "FASTQC/")
        obj@parameterList$logDir <- paste0(obj@parameterList$workdir, "logs/")
        obj@parameterList$DEseq2Dir <- paste0(obj@parameterList$localWorkDir, "DESeq2/")
        return(obj)
    }
)


setGeneric(
    name="setDataBaseParameters",
    def=function(obj){
        ## Primary data table
        #obj@dbDetailList$primDataDB <- paste0(
        #    substr(obj@parameterList$project_id, 1,3),
        #    "_data"
        #)
        
        obj@parameterList$rnaseqdbTableName <- paste0(
            obj@parameterList$project_id,
            "_",
            obj@parameterList$experiment.type,
            "_table"
        )
        
        ##Lab table ##
        #obj@parameterList$lab.categories.table <- paste0(
        #    substr(obj@parameterList$project_id,1,2),
        #    "_lab_categories"
        #)
        
        ##PCA table ##
        obj@parameterList$PCAdbTableName <- paste0(
            obj@parameterList$project_id, 
            "_PCA"
        )
        
        ## Cat reference tables ##
        obj@parameterList$cat.ref.db.table = paste0(
            obj@parameterList$project_id, 
            "_cat_reference_db_table"
        )
        
        obj@parameterList$cat.ref.db <- obj@dbDetailList$primDataDB
        
        obj@parameterList$enriched.categories.dbTableName <- paste0(
            obj@parameterList$project_id,
            "_enriched_categories_table"
        )
        return(obj)
        
    }
)

setGeneric(
    name="setCrickGenomeAndGeneNameTable",
    def=function(obj, genomeDir="/camp/svc/reference/Genomics/babs"){
        
        releaseID <- gsub("release-", "", obj@parameterList$release)
        ## Set referemce file, gtf file ##
        if (obj@parameterList$species == "mus_musculus"){
            obj@parameterList$genome  <- "GRCm38" 
            obj@parameterList$primaryAlignmentGeneID <- "ENSMUSG"
            
            if (obj@parameterList$release == "release-89"){
                obj@parameterList$path2GeneIDtable <-  paste0(
                    obj@parameterList$hpcMount,
                    "Projects/reference_data/gene_id_annotation_files/",
                    "20171206.release-89.mm.ENSMUSG.mgi.entrez.uniprot.description.hgnc.table.txt"
                )
            } else {
                stop("No valid gene reference file specified")
            }
            
            
            obj@parameterList$GTFfile <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",
                releaseID,
                ".rnaseqc.gtf"
            )
            
            obj@parameterList$genomeFa <-  paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/genome/Mus_musculus.GRCm38.dna_sm.toplevel.fa"
            )
            
            obj@parameterList$genomeFai<- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/genome/Mus_musculus.GRCm38.dna_sm.toplevel.fai"
            )
            
            obj@parameterList$rRNAfile  <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",releaseID,".rRNA.list"
            )
            
            obj@parameterList$geneIDcolumn <- "mgi_symbol"
            
            obj@parameterList$bedFile <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",releaseID,".bed"
            )
            
            obj@parameterList$refFlatFile <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",releaseID,".rRNA.refflat"
            )
            
            obj@parameterList$ribosomalIntervalList <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "/gtf/Mus_musculus.GRCm38.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$bowtieGenomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/mus_musculus/ensembl/GRCm38/",
                obj@parameterList$release,
                "genome_idx/bowtie2/Mus_musculus.GRCm38.dna_sm.toplevel"
            )
            
            
        } else if (obj@parameterList$species == "homo_sapiens"){
            obj@parameterList$genome  <- "GRCh38"
            obj@parameterList$primaryAlignmentGeneID <- "ENSG"
            
            obj@parameterList$path2GeneIDtable <- paste0(
                obj@parameterList$hpcMount,
                "Projects/reference_data/gene_id_annotation_files/",
                "20171206.release-89.hs.ENSG.mgi.entrez.uniprot.description.mgi.table.txt"
            )
            
            
            obj@parameterList$GTFfile <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rnaseqc.gtf"
            )
            
            obj@parameterList$genomeFa <-  paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa"
            )
            
            obj@parameterList$genomeFai<- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.fai"
            )
            
            obj@parameterList$rRNAfile  <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.list"
            )
            
            obj@parameterList$geneIDcolumn <- "hgnc_symbol"
            
            obj@parameterList$bedFile = paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".bed"
            )
            
            obj@parameterList$refFlatFile = paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.refflat"
            )
            
            obj@parameterList$ribosomalIntervalList <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.interval_list"
            )
            
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome_idx/bowtie2/Homo_sapiens.GRCh38.dna_sm.primary_assembly"
            )
            
            
        } else if (obj@parameterList$species == "danio_rerio"){
            obj@parameterList$genome  <- "GRCz10"
            obj@parameterList$primaryAlignmentGeneID <- "ENSDARG"
            obj@parameterList$path2GeneIDtable <- paste0(
                obj@parameterList$hpcMount,
                "Projects/reference_data/gene_id_annotation_files/",
                "20180724.release-89.dr.ENSDARG.hgnc.description.table.txt"
            )
            
            
            obj@parameterList$GTFfile <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".rnaseqc.gtf"
            )
            
            
            obj@parameterList$genomeFa <-  paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/genome/Danio_rerio.GRCz10.dna_sm.toplevel.fa"
            )
            
            obj@parameterList$genomeFai<- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/genome/Danio_rerio.GRCz10.dna_sm.toplevel.fa.fai"
            )
            
            obj@parameterList$rRNAfile  <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".rRNA.list"
            )
            
            obj@parameterList$geneIDcolumn <- "dr_symbol"
            
            obj@parameterList$bedFile <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".bed"
            )
            
            obj@parameterList$refFlatFile <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".rRNA.refflat"
            )
            
            obj@parameterList$ribosomalIntervalList <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "/gtf/Danio_rerio.GRCz10.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/danio_rerio/ensembl/GRCz10/",
                obj@parameterList$release,
                "genome_idx/bowtie2/Danio_rerio.GRCz10.dna_sm.toplevel."
            )
            
        } else if (obj@parameterList$species == "homo_sapiens"){
            obj@parameterList$genome  <- "GRCh38"
            obj@parameterList$primaryAlignmentGeneID <- "ENSG"
            
            obj@parameterList$path2GeneIDtable <- paste0(
                obj@parameterList$hpcMount,
                "Projects/reference_data/gene_id_annotation_files/",
                "20171206.release-89.hs.ENSG.mgi.entrez.uniprot.description.mgi.table.txt"
            )
            
            
            obj@parameterList$GTFfile <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rnaseqc.gtf"
            )
            
            obj@parameterList$genomeFa <-  paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa"
            )
            
            obj@parameterList$genomeFai<- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.fai"
            )
            
            obj@parameterList$rRNAfile  <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.list"
            )
            
            obj@parameterList$geneIDcolumn <- "hgnc_symbol"
            
            obj@parameterList$bedFile = paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".bed"
            )
            
            obj@parameterList$refFlatFile = paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.refflat"
            )
            
            obj@parameterList$ribosomalIntervalList <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/gtf/Homo_sapiens.GRCh38.",releaseID,".rRNA.interval_list"
            )
            
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/homo_sapiens/ensembl/GRCh38/",
                obj@parameterList$release,
                "/genome_idx/bowtie2/Homo_sapiens.GRCh38.dna_sm.primary_assembly"
            )
            
            
        } else if (obj@parameterList$species == "drosophila_melanogaster"){
            obj@parameterList$genome  <- "BDGP6"
            obj@parameterList$primaryAlignmentGeneID <- "ENSVDME"
            ## To be changed
            obj@parameterList$path2GeneIDtable <- paste0(
                obj@parameterList$hpcMount,
                "Projects/reference_data/gene_id_annotation_files/",
                "20190611.release-89.mm.ENSDMELG.hgnc.uniprot.description.table.txt"
            )
            
            
            obj@parameterList$GTFfile <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".rnaseqc.gtf"
            )
            
            
            obj@parameterList$genomeFa <-  paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/genome/Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa"
            )
            
            obj@parameterList$genomeFai<- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/genome/Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa.fai"
            )
            
            obj@parameterList$rRNAfile  <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".rRNA.list"
            )
            
            obj@parameterList$geneIDcolumn <- "Dmel_symbol"
            
            obj@parameterList$bedFile <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".bed"
            )
            
            obj@parameterList$refFlatFile <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".rRNA.refflat"
            )
            
            obj@parameterList$ribosomalIntervalList <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "/gtf/Drosophila_melanogaster.BDGP6.",releaseID,".rRNA.interval_list"
            )
            
            obj@parameterList$genomeidx <- paste0(
                "/camp/svc/reference/Genomics/babs/drosophila_melanogaster/ensembl/BDGP6/",
                obj@parameterList$release,
                "genome_idx/bowtie2/Drosophila_melanogaster.BDGP6.dna_sm.toplevel."
            )
            
        } else {
            stop(" No valid species specified in the parameterList.")
        } 
        
        
        ## Set genome index ##    
        obj@parameterList$genomeIndex <- paste0(
            genomeDir,
            "/",
            obj@parameterList$species
            ,"/ensembl/",
            obj@parameterList$genome,
            "/", 
            obj@parameterList$release,
            "/genome_idx/rsem/star/",
            obj@parameterList$read.length,
            "/genome"
        )
        
        return(obj)
    }
)


###############################################################################
## Create required folders                                                   ##

setGeneric(
    name="createAnalysisFolders",
    def=function(
        obj, 
        baseDir="/camp/stp/babs/working/boeings/Projects/", 
        localBaseDir = "Y:/working/boeings/Projects/"
        ){
        obj@parameterList$datadir <- paste0(
            baseDir,
            obj@parameterList$folder, 
            "basedata/"
        )
        
        ## Create basedata folder ##
        obj@parameterList$localDataDir <- paste0(
            localBaseDir,
            obj@parameterList$folder, 
            "basedata/"
        )
        
        if (!dir.exists(obj@parameterList$localDataDir)){
            dir.create(obj@parameterList$localDataDir)
        }
        
        ## Create workdir ##
        obj@parameterList$workdir <- paste0(
            baseDir,
            obj@parameterList$folder, 
            "workdir/"
        )
        
        obj@parameterList$localWorkDir <- paste0(
            localBaseDir,
            obj@parameterList$folder, 
            "workdir/"
        )
        
        if (!dir.exists(obj@parameterList$localWorkDir)){
            dir.create(obj@parameterList$localWorkDir)
        }
        
        ## Create fastq dir ##
        obj@parameterList$fastqDir <- paste0(
            baseDir,
            obj@parameterList$folder, 
            "FASTQ_files/"
        )
        
        obj@parameterList$localFastqDir <- paste0(
            localBaseDir,
            obj@parameterList$folder, 
            "FASTQ_files/"
        )
        
        if (!dir.exists(obj@parameterList$localFastqDir)){
            dir.create(obj@parameterList$localFastqDir)
        }
        
        ## Create outputdir ##
        obj@parameterList$outputDir <- paste0(
            localBaseDir,
            obj@parameterList$folder, 
            "outputs/"
        )
        
        if (!dir.exists(obj@parameterList$outputDir)){
            dir.create(obj@parameterList$outputDir)
        }
        
        ## Create design file name ##
        obj@parameterList$designFN <- paste0(
            obj@parameterList$project_id,
            ".design.file.txt"
        )
        
        return(obj)
    }
)

##                                                                           ##
###############################################################################

###############################################################################
## Add annotation                                                            ##

setGeneric(
    name="addGeneAnnotation",
    def=function(
        obj,
        addUniprotColumn = FALSE
    ){
        dfAnno <- read.delim(
            obj@parameterList$path2GeneIDtable,
            header = TRUE,
            sep = "\t",
            stringsAsFactors = FALSE
        )
        
        dfAnno$for_GSEA_gene_chip <- NULL
        dfAnno$Gene.name <- NULL
        dfAnno$Gene.type <- NULL
        dfAnno$Gene_description <- NULL
        
        
        obj@dfGeneAnnotation <- dfAnno
        
        return(obj)
    }
)


## Done adding annotation                                                    ##
###############################################################################

###############################################################################
## Add FPKM/TPM                                                              ##
setGeneric(
    name="addTPMorFPKMtable",
    def=function(
        obj = "biologic objec",
        addTPM = TRUE,
        addFPKM = FALSE
    ){
        count.data.file <- paste0(
            obj@parameterList$localWorkDir,
            "RSEM/",
            obj@parameterList$RSEMcountDataFile
        )
        
        count.data.file <- paste0(
            obj@parameterList$localWorkDir,
            "RSEM/",
            obj@parameterList$RSEMcountDataFile
        )
        
        ###############################################################################
        # Prepare TPM and FPKM tables                                                 #
        ###############################################################################
        ## Make sure dfDesign is ordered properly ##
        samples <- as.vector(
            unique(
                obj@dfDesign$sample.id
            )
        )
        
        files <- paste(
            obj@parameterList$localWorkDir, 
            "RSEM/Ensembl/", 
            samples, 
            ".genes.results", 
            sep=""
        )
        
        
        #library(SBwebtools)
        list.tpm.fpkm <- create.tpm.and.fpkm.tables(
            workdir = obj@parameterList$localWorkDir, 
            samples = samples,
            files = files
        )
        
        if (addFPKM){
            obj@dfFPKM <- list.tpm.fpkm$df.fpkm
            names(obj@dfFPKM) <- gsub("gene_id", obj@parameterList$primaryAlignmentGeneID, names(obj@dfFPKM))
            names(obj@dfFPKM) <- gsub(".fpkm", "", names(obj@dfFPKM))
            rSums <- rowSums(obj@dfFPKM[,2:ncol(obj@dfFPKM)])
            obj@dfFPKM <- obj@dfFPKM[rSums > 0, ]
        } else if (addTPM) {
            obj@dfTPM <- list.tpm.fpkm$df.tpm
            names(obj@dfTPM) <- gsub("gene_id", obj@parameterList$primaryAlignmentGeneID, names(obj@dfTPM))
            names(obj@dfTPM) <- gsub(".tpm", "", names(obj@dfTPM))
            rSums <- rowSums(obj@dfTPM[,2:ncol(obj@dfTPM)])
            obj@dfTPM <- obj@dfTPM[rSums > 0, ]
        } else {
            print("Nothing added.")
        }
        rm(list.tpm.fpkm)
        return(obj)
    }
)

## Add FPKM/TPM                                                              ##
###############################################################################


###############################################################################
## Add FPKM/TPM                                                              ##
setGeneric(
    name="prepareRSEMcountMatrix",
    def=function(
        obj = "biologic objec",
        string.to.be.deleted.in.raw.counts.columns = paste0("X", gsub("/", ".",paste0(obj@parameterList$workdir, "RSEM/Ensembl/")))
    ){
        
        obj@RSEMcountMatrix <- readAndPrepareCountMatrix(
            count.data.fn = paste0(
                obj@parameterList$localWorkDir,
                "RSEM/",
                obj@parameterList$RSEMcountDataFile
            ),
            string.to.be.deleted.in.raw.counts.columns = string.to.be.deleted.in.raw.counts.columns,
            df.design = obj@dfDesign
        )
        
        return(obj)
    }
)

## Done preparing RSEM matrix                                                ##
###############################################################################


setGeneric(
    name="createRNAseqQCscript",
    def=function(
        obj = "biologic objec",
        scriptVecSlot = "scriptVec",
        bamSuffix = "STAR.genome.bam"
    ){
        
        obj@parameterList$RnaSQCbaseDataDir <- paste0(
            obj@parameterList$workdir, "RSEM/Ensembl"
        )
        
        obj@parameterList$RnaSQCBamSuffix <- bamSuffix
        
        tempShellScriptVector <- as.vector(NULL, mode = "character")
        
        if (obj@parameterList$stranded){
            strandedness<- "SECOND_READ_TRANSCRIPTION_STRAND"
        } else {
            strandedness<- "NONE"
        }
        ## Order samples so that sortin is > condition > sample.group > sample.id
        #df.design <- df.design[order(df.design$dataseries, df.design$sample.group, df.design$sample.id),]
        
        samples = as.vector(
            unique(
                obj@dfDesign[,"sample.id"]
            )
        )
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '#!/bin/sh',
            '\n',
            '#Copy this shell script into the project directory and run it from there.', 
            '\n',
            '#################################################################################', 
            '\n',
            '##Create log directory ##########################################################', 
            '\n',
            'if [ ! -d logs ]; then',
            '\n',
            '  mkdir logs',
            '\n',
            'fi',
            '\n',
            '\n',
            '#################################################################################', 
            '\n',
            '###VARIABLES#####################################################################', 
            '\n',
            '#################################################################################', 
            '\n',
            paste0('project="', obj@parameterList$project_id, '"'), 
            '\n',
            'projectID=""', 
            '\n',
            '#Path to the directory with the BAM files', '\n',
            '#FASTQ files have to be named [sample_name_as_given_in_samples_below]_R1.fastq.gz or [sample_name_as_given_in_samples_below]_R2.fastq.gz', '\n',
            paste0('alignDir="', obj@parameterList$RnaSQCbaseDataDir, '"'), '\n', 
            paste0('GTFfile="', obj@parameterList$GTFfile, '"'), '\n',
            #paste0('GTFfile_RNASeQC="', GTFfile.RNASeQC, '"'), '\n',
            paste0('rRNAfile="', obj@parameterList$rRNAfile, '"'), 
            '\n',
            '\n',
            paste0('samplesuffix="',bamSuffix,'"'),
            '\n',
            '\n',
            paste0('genome_fa="',obj@parameterList$genomeFa,'"'),  '\n'
        )
        
        for (i in 1:length(samples)){
            if (i ==1){
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    paste0('samples="',  samples[i]) 
                )
            } else {
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    '\n', samples[i] 
                )
            }
        }
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '"',  '\n',           
            '\n',                                
            '\n',                              
            '#################################################################################',  '\n',
            '##FUNCTIONS######################################################################',  '\n',
            '#################################################################################',  '\n', 
            '\n',                                
            'wait_on_lsf() { ## wait on jobs{',  '\n',
            'sleep 300',  '\n',
            'n=`squeue --name=$project  | wc -l`',  '\n',
            #'n=n-1',  
            '\n',
            'while [ $n -ne 1 ]',  '\n',
            'do',  '\n',
            'n=`squeue --name=$project  | wc -l`',  '\n',
            #'n=n-1',  
            '\n',
            '((z=$n-1))',  '\n',
            '#number of running',  '\n',
            'echo "$project jobs ($projectID) running: $z"',  
            '\n',
            '#number of pending',  '\n',
            'sleep 300',  '\n', 
            'done',  '\n',
            '}', '\n',
            '\n',
            '\n',                             
            '\n',                                
            '## End of function                                                             ##', '\n',
            '#################################################################################', '\n',
            '\n', '\n',                                
            
            '#################################################################################', '\n',
            '# Prere bam files for RNASeQC                                                   #', '\n',
            '#################################################################################', '\n',
            '#################################################################################', '\n',
            '# AddOrReplaceReadGroups                                                        #', '\n',
            '#################################################################################', '\n','\n',
            'projectID="AddOrReplaceReadGroups"', '\n',
            'module load R/3.3.1-foss-2016b-bioc-3.3-libX11-1.6.3', '\n','\n',
            'echo "module load R/3.3.1-foss-2016b-bioc-3.3-libX11-1.6.3" >> commands.txt', '\n',
            'module load picard/2.1.1-Java-1.8.0_112', '\n','\n',
            'echo "module load picard/2.1.1-Java-1.8.0_112" >> commands.txt', '\n',
            'echo "redo headers on Tophat bam output"', '\n',
            'echo "#Submitted jobs" >> commands.txt ', '\n',
            '#projectID="headers"', '\n',
            'for sample in $samples', '\n',
            '   do ', '\n',
            '      echo "java -jar ${EBROOTPICARD}/picard.jar AddOrReplaceReadGroups \\', '\n',
            '      I=${alignDir}/${sample}.${samplesuffix} \\', '\n',
            '      O=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
            '      RGID=$sample \\', '\n',
            '      RGCN=CCCB \\', '\n',
            '      RGLB=lib1 \\', '\n',
            '      RGPL=ILLUMINA \\', '\n',
            '      RGPU=NA \\', '\n',
            '      RGSM=accepted_hits.bam" >> commands.txt', '\n',
            '      sbatch --time=12:00:00 --wrap "java -jar ${EBROOTPICARD}/picard.jar AddOrReplaceReadGroups \\', '\n',
            '      I=${alignDir}/${sample}.${samplesuffix} \\', '\n',
            '      O=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
            '      RGID=$sample \\', '\n',
            '      RGCN=TheFrancisCrickInstitute \\', '\n',
            '      RGLB=lib1 \\', '\n',
            '      RGPL=ILLUMINA \\', '\n',
            '      RGPU=NA \\', '\n',
            '      RGSM=accepted_hits.bam" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.addorreplacereadgroups.slurm >> commands.txt ', '\n',
            '   done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n', '\n',                                
            '#################################################################################', '\n',
            '# SortSam                                                                       #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="SortSam"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'echo "SortSam co-ordinate sort" >>  commands.txt', '\n',
            'echo "SortSam output"', '\n',
            '#projectID="coordinate_sort"', '\n',
            'for sample in $samples', '\n',
            '   do', '\n',
            '      echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar SortSam \\', '\n',
            '      I=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
            '      O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
            '      SO=coordinate \\', '\n',
            '      TMP_DIR=\'pwd\'/tmp" >> commands.txt ', '\n',
            
            '      sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar SortSam \\', '\n',
            '      I=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
            '      O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
            '      SO=coordinate \\', '\n',
            '      TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.sortsam.slurm >> commands.txt ', '\n',
            '   done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            'for sample in $samples', '\n',
            'do', '\n',
            'echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.bam" >> commands.txt  ', '\n',
            'rm ${alignDir}/${sample}.accepted_hits.readgroups.bam  ', '\n',
            'done', '\n',
            '\n',                                
            
            '#################################################################################', '\n',
            '# Reorder SAM                                                                   #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="ReorderSam"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'echo "reorder reads to match contigs in the reference" >> commands.txt', '\n',
            'echo "Reorder reads to match contigs in the reference"', '\n',
            'for sample in $samples', '\n',
            'do	', '\n',
            'echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar ReorderSam \\', '\n',
            'I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
            'O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
            'REFERENCE=${genome_fa} \\', '\n',
            'TMP_DIR=\'pwd\'/tmp" >> commands.txt ', '\n',
            '\n',                                  
            'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar ReorderSam \\', '\n',
            'I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
            'O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
            'REFERENCE=${genome_fa} \\', '\n',
            'TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.reordersam.slurm >> commands.txt ', '\n',
            '\n',                                
            'done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            'for sample in $samples', '\n',
            '   do', '\n',
            '      echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam" >> commands.txt', '\n',
            '      rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam', '\n',
            '   done', '\n',
            '\n',                              
            '#################################################################################', '\n',
            '# MarkDuplicates                                                                #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="MarkDuplicates"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'projectID="markdups"', '\n',
            'echo "mark duplicates" >> commands.txt', '\n',
            'echo "mark duplicates"', '\n',
            '   for sample in $samples', '\n',
            '      do', '\n',	
            '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar MarkDuplicates \\', '\n',
            '         I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
            '         O=${alignDir}/${sample}.d.bam \\', '\n',
            '         METRICS_FILE=${alignDir}/${sample}/dup_metrics.txt \\', '\n',
            '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
            '\n',                                
            '         sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar MarkDuplicates \\', '\n',
            '         I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
            '         O=${alignDir}/${sample}.d.bam \\', '\n',
            '         METRICS_FILE=${alignDir}/${sample}/dup_metrics.txt \\', '\n',
            '         TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.markduplicates.slurm >> commands.txt ', '\n',
            '      done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            '##############################', '\n',
            'for sample in $samples', '\n',
            '   do', '\n',
            '      echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam" >> commands.txt', '\n',
            '      rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam', '\n',
            '   done', '\n',
            '#################################################################################', '\n',
            '# Samtool indexing                                                              #', '\n',
            '#################################################################################', '\n','\n',
            'projectID="Samtool indexing"', '\n',
            'module load SAMtools/1.3.1-foss-2016b', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'echo "module load SAMtools/1.3.1-foss-2016b" >> commands.txt', '\n',
            'echo "Samtool Indexing "', '\n',
            'for sample in $samples', '\n',
            '   do', '\n',	
            '      echo "samtools index ${alignDir}/${sample}.d.bam" >> commands.txt', '\n',
            '      sbatch --time=12:00:00 --wrap "samtools index ${alignDir}/${sample}.d.bam" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.samtools.index.slurm >> commands.txt ', '\n',
            '   done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n'
        )       
        
        ###########################################################################
        ## Estimate library complexity                                           ##
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '#################################################################################', '\n',
            '# Run Estimate Library Complexity                                               #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="EstimateLibraryComplexity"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'projectID="EstimateLibraryComplexity"', '\n',
            'echo "EstimateLibraryComplexity" >> commands.txt', '\n',
            'echo "EstimateLibraryComplexity"', '\n',
            '   for sample in $samples', '\n',
            '      do', '\n',	
            '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar EstimateLibraryComplexity \\', '\n',
            '           I=${alignDir}/${sample}.d.bam \\', '\n',
            '           O=${alignDir}/${sample}.est_lib_complex_metrics.txt \\', '\n',
            '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
            '\n',
            '\n',
            'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar EstimateLibraryComplexity \\', '\n',
            '           I=${alignDir}/${sample}.d.bam \\', '\n',
            '           O=${alignDir}/${sample}.est_lib_complex_metrics.txt \\', '\n',
            '           TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.estimatelibrarycomplexity.slurm >> commands.txt ', '\n',
            '\n',
            '\n',
            '      done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            '\n'
            
        )
        
        
        ## Done estimating library complexity                                    ##
        ###########################################################################
        
        ###########################################################################
        ## Add rnaseq metrics                                                    ##
        
        ## Add on - do existence check ##
        refFlatFile <- obj@parameterList$refFlatFile
        if (length(refFlatFile) == 0){
            refFlatFile <- ""
        }
        
        ribosomalIntervalList <- obj@parameterList$ribosomalIntervalList
        if (length(ribosomalIntervalList) == 0){
            ribosomalIntervalList <- ""
        }
        
        if (refFlatFile != "" &  ribosomalIntervalList != ""){
            
            
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '#################################################################################', '\n',
                '# Run CollectRnaSeqMetrics                                                      #', '\n',
                '#################################################################################', '\n', '\n',
                'projectID="CollectRnaSeqMetrics"', '\n',
                'echo "###########################################################################################" >>  commands.txt', '\n',
                'projectID="CollectRnaSeqMetrics"', '\n',
                'echo "CollectRnaSeqMetrics" >> commands.txt', '\n',
                'echo "CollectRnaSeqMetrics"', '\n',
                '   for sample in $samples', '\n',
                '      do', '\n',	
                '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar CollectRnaSeqMetrics \\', '\n',
                '           I=${alignDir}/${sample}.d.bam \\', '\n',
                '           O=${alignDir}/${sample}.output.RNA_Metrics \\', '\n',
                paste0('           REF_FLAT=',refFlatFile,' \\'), '\n',
                paste0('           STRAND=',strandedness,' \\'), '\n',
                paste0('           RIBOSOMAL_INTERVALS=',ribosomalIntervalList,' \\'), '\n', 
                '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
                '\n',
                '\n',
                'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar CollectRnaSeqMetrics \\', '\n',
                '           I=${alignDir}/${sample}.d.bam \\', '\n',
                '           O=${alignDir}/${sample}.output.RNA_Metrics \\', '\n',
                paste0('           REF_FLAT=',refFlatFile,' \\'), '\n',
                paste0('           STRAND=',strandedness,' \\'), '\n',
                paste0('           RIBOSOMAL_INTERVALS=',ribosomalIntervalList,' \\'), '\n', 
                '           TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.rnaseqmetrics.slurm >> commands.txt ', '\n',
                '\n',
                '\n',
                '      done', '\n',
                '##wait on jobs', '\n',
                'wait_on_lsf', '\n',
                '\n',                                
                '\n'
                
            )
            
        }
        ## End rnaseq metrics                                                    ##
        ###########################################################################
        
        ###########################################################################
        ## Add infer experiment                                                  ##
        bedFile <- obj@parameterList$bedFile
        if (length(bedFile) == 0){
            bedFile <- ""
        }
        
        if (bedFile != ""){
            
            
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '#################################################################################', '\n',
                '# Run RNASeQC Infer_experiment                                                  #', '\n',
                '#################################################################################', '\n', '\n',
                'projectID="Infer_experiment"', '\n',
                'echo "###########################################################################################" >>  commands.txt', '\n',
                'projectID="Infer_experiment"', '\n',
                'echo "Infer_experiment" >> commands.txt', '\n',
                'echo "Infer_experiment"', '\n',
                'module purge;','\n',
                'module load RSeQC/2.6.4-foss-2016b-Python-2.7.12-R-3.3.1;', '\n',
                '   for sample in $samples', '\n',
                '      do', '\n',	
                paste0(
                    'echo "infer_experiment.py -r ',
                    bedFile,
                    ' -i ${alignDir}/${sample}.d.bam > ${alignDir}/${sample}.infer_experiment.txt"  >> commands.txt \\'
                ), 
                '\n',
                '\n',
                paste0('sbatch --time=12:00:00 --wrap "infer_experiment.py -r ',
                       bedFile,
                       ' -i ${alignDir}/${sample}.d.bam > ${alignDir}/${sample}.infer_experiment.txt" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.infer_experiment.slurm >> commands.txt '
                ), 
                '\n', 
                '      done', '\n',
                '##wait on jobs', '\n',
                'wait_on_lsf', '\n',
                '\n',                                
                '\n'
                
            )
            
        }
        ## End rnaseq metrics                                                    ##
        ###########################################################################
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '#################################################################################', '\n',
            '# Run RNASeqC                                                                   #', '\n',
            '#################################################################################', '\n','\n',
            'projectID="RNAseQC"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'module load RNA-SeQC/1.1.8-Java-1.7.0_80', '\n', '\n',
            'echo "module load RNA-SeQC/1.1.8-Java-1.7.0_80" >> commands.txt', '\n',
            'echo "make RNASeqC sample list"', '\n',
            'cd ${alignDir}', '\n',
            '\n',                                
            'if [ ! -d ${projectID} ]; then', '\n',
            '  mkdir ${projectID}', '\n',
            'fi', '\n',
            '\n',                                
            '\n',                              
            'echo "sample list" > ${alignDir}/${projectID}/sample.list', '\n',
            'for sample in $samples', '\n',
            'do', '\n',
            'echo -e "$sample\t${alignDir}/${sample}.d.bam\tNA" >>${alignDir}/${projectID}/sample.list', '\n',
            'done', '\n',
            '#wait', '\n', 
            '\n',                                
            'echo "run RNA-seqQC"', '\n',
            '\n',                                
            '#RNASeqQC requires Java version 1.7 and does not run on the most recent version. ', '\n',
            '\n',                               
            'echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTRNAMINSEQC}/RNA-SeQC_v1.1.8.jar \\', '\n'
        )
        
        if (!obj@parameterList$paired.end){
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '-singleEnd \\', '\n'
            )
        }
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            
            '-o ${alignDir}/${projectID}/ \\', '\n',
            '-r ${genome_fa} \\', '\n',
            '-s ${alignDir}/${projectID}/sample.list \\', '\n',
            '-t $GTFfile \\', '\n',
            '-gatkFlags \'-S SILENT -U ALLOW_SEQ_DICT_INCOMPATIBILITY\' \\', '\n',
            '-rRNA $rRNAfile " >> commands.txt', '\n',
            '\n',                                
            'sbatch --time=48:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTRNAMINSEQC}/RNA-SeQC_v1.1.8.jar \\', '\n'
        )
        
        if (!obj@parameterList$paired.end){
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '-singleEnd \\', '\n'
            )
        }
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '-o ${alignDir}/${projectID}/ \\', '\n',
            '-r ${genome_fa} \\', '\n',
            '-s ${alignDir}/${projectID}/sample.list \\', '\n',
            '-t $GTFfile \\', '\n',
            '-gatkFlags \'-S SILENT -U ALLOW_SEQ_DICT_INCOMPATIBILITY\' \\', '\n',
            '-rRNA $rRNAfile " --job-name=$project -c 1 --mem-per-cpu=7000 -o ${alignDir}/rnaseqc.slurm >> ${alignDir}/commands.txt ', '\n',
            '\n',
            '\n',
            'wait_on_lsf',
            '\n',
            'module purge; module use /camp/stp/babs/working/software/modules/all; module load multiqc/1.3-2016b-Python-2.7.12',
            '\n',
            paste0("multiqc ", obj@parameterList$workdir),
            '\n',
            '#end of file', '\n'
        )
        
        obj <- add2vec(
            obj = obj, 
            slot_name = scriptVecSlot,
            value = tempShellScriptVector
        )
        
       return(obj)
    }
)    


###############################################################################
## Create dds base object                                                    ##

setGeneric(
    name="createDdsObject",
    def=function(obj) {
        
        library(DESeq2)
        
        if (length(obj@parameterList$batchMode) == 0){
            obj@parameterList$batchMode <- FALSE
        }
        
        if (obj@parameterList$batchMode){
            colData = unique(obj@dfDesign[, c("sample.id", "sample.group","replicate")])
            rownames(colData) = as.vector(colData$sample.id)
            colData$sample.id <- NULL
            colnames(colData)[1] = "condition"
            colData$condition <- as.factor(colData$condition)
            colData$replicate <- as.factor(colData$replicate)
            
            
            obj@ObjDds <- DESeqDataSetFromMatrix(
                countData = obj@RSEMcountMatrix,
                colData   = colData,
                design    = ~ replicate
            )
        } else {
            colData = unique(obj@dfDesign[, c("sample.id", "sample.group")])
            rownames(colData) = as.vector(colData$sample.id)
            colData$sample.id <- NULL
            colnames(colData)[1] = "condition"
            colData$condition <- as.factor(colData$condition)
            
            obj@ObjDds <- DESeqDataSetFromMatrix(
                countData = obj@RSEMcountMatrix,
                colData   = colData,
                design    = ~ condition
            )
        }
        
        obj <- add2vec(
            obj = obj,
            slot_name = "documentationVector",
            value = 'DESeq2 Paramteters: test="Wald"; betaPrior=FALSE.'
        )
        
        obj@ObjDds <- DESeq(
            obj@ObjDds,
            test = "Wald",
            betaPrior = FALSE,
            parallel = obj@parameterList$parallelProcessing
        )
        
        ## Extract norm counts ##
        ## RSEM-generate-matrix produces a raw-count matrix
        if (length(obj@parameterList$DESeq2ToBeNormalized) == 0){
            obj@parameterList$DESeq2ToBeNormalized <- TRUE
        }
        
        obj@DESeqNormReadCountsTable <- data.frame(
            round(
                counts(
                    obj@ObjDds, normalized=obj@parameterList$DESeq2ToBeNormalize
                )
            )
        )
        
        #Remove all rows 0 counts for all samples from df.normCounts
        obj@DESeqNormReadCountsTable <- obj@DESeqNormReadCountsTable[rowSums(obj@DESeqNormReadCountsTable)!=0,]
        return(obj)
    }
)

## Done creating dds base object and norm counts table                       ##
###############################################################################


setGeneric(
    name="createPCAloadingPlots",
    def=function(
        obj
    ) {
        library(ggplot2)
        contrast_P_lg10p_PCA <- names(obj@dfPCAgenes)[grep("contrast_P_lg10p_PCA",names(obj@dfPCAgenes))]
        plotTask <- gsub("contrast_P_lg10p_", "", contrast_P_lg10p_PCA )
        
        dfAnno <- unique(obj@dfGeneAnnotation[,c(obj@parameterList$primaryAlignmentGeneID, obj@parameterList$geneIDcolumn)])
        dfAnno <- dfAnno[dfAnno[,obj@parameterList$primaryAlignmentGeneID] %in% obj@dfPCAgenes[,obj@parameterList$primaryAlignmentGeneID],]
        
        dfPlot <- merge(
            obj@dfPCAgenes, 
            dfAnno,
            by.x = obj@parameterList$primaryAlignmentGeneID,
            by.y = obj@parameterList$primaryAlignmentGeneID,
            all = TRUE
        )
        dfPlot[is.na(dfPlot)] <- ""
        dfPlot[dfPlot[,obj@parameterList$geneIDcolumn] == "", obj@parameterList$geneIDcolumn] <- dfPlot[dfPlot[,obj@parameterList$geneIDcolumn] == "", obj@parameterList$primaryAlignmentGeneID] 
        
        for (i in 1:length(plotTask)){
            plotName <- paste0(plotTask[i], "_PCA_fitting")
            cols <- c(obj@parameterList$geneIDcolumn, names(dfPlot)[grep(paste0(plotTask[i],"$"), names(dfPlot))])
            dfPlotSel <- unique(dfPlot[,cols])
            names(dfPlotSel) <- gsub(plotTask[i], "PCA", names(dfPlotSel))
            dfPlotSel <- dfPlotSel[order(dfPlotSel$r2_PCA, decreasing = TRUE),]
            
            
            tryCatch({   
                obj@plotCollection[[plotName]] <- ggplot(
                    data=dfPlotSel,
                    aes(
                        x=contrast_P_PCA_estimatePCA, 
                        y=contrast_P_lg10p_PCA,
                        size = r2_PCA,
                        alpha = I(r2_PCA)
                    )) + geom_point(
                    )  + labs(title = plotTask[i] ,x = "Estimate", y = "-log10(padjust)"
                ) +  theme(
                    axis.text.y   = element_text(size=8),
                    axis.text.x   = element_text(size=8),
                    axis.title.y  = element_text(size=8),
                    axis.title.x  = element_text(size=8),
                    axis.line = element_line(colour = "black"),
                    panel.border = element_rect(colour = "black", fill=NA, size=1),
                    plot.title = element_text(hjust = 0.5, size = 12)
                ) 
            }, 
            error = function(c) "Plot error",
            warning = function(c) "warning",
            message = function(c) "message" 
            )
        }
        return(obj)
        
    }
)


###############################################################################
## Method Determine row variability                                          ##

setGeneric(
    name="addCoVar",
    def=function(
        obj, 
        avgCountCutOffperSample = 0,
        selectionColName = "aboveCutOff",
        dfBaseData = "Obio@DESeqNormReadCountsTable",
        rowNameID = "obj@parameterList$primaryAlignmentGeneID"
        #options: "DEseq2RV" or "CoVar"
    ) {
        
        ###########################################################################    
        ## Calculate average row value per sample                                ##
        avgCountsPerGenePerSample <- round(
            rowSums(dfBaseData)/ncol(dfBaseData),3
        )
        
        dfCountCutOff <- data.frame(avgCountsPerGenePerSample, names(avgCountsPerGenePerSample))
        
        names(dfCountCutOff) <- c("avgCountsPerGenePerSample", rowNameID)
        
        #########################################################################
        ## Calculate coefficient of variation                                  ##
        dfCoVar <- dfBaseData
        
        ## Remove all zero rows ##
        
        
        dfCoVar["CoVar"]<- apply(
            dfCoVar,
            1,
            function(x) sd(x)/mean(x)
        )
        
        dfCoVar[dfCoVar$CoVar == Inf, "CoVar"] <- max(dfCoVar[dfCoVar$CoVar < Inf ,"CoVar"])
        dfCoVar[[rowNameID]] <- row.names(dfCoVar)
        dfCoVar <- dfCoVar[,c(rowNameID, "CoVar")]
        dfRv <- merge(
            dfCountCutOff,
            dfCoVar,
            by.x = rowNameID,
            by.y = rowNameID
        )
        dfRv[is.na(dfRv)] <- 0    
        
        dfRv <- dfRv[order(dfRv$CoVar, decreasing = T),]
        
        ## Done calculating coefficietn of variation                           ##
        #########################################################################
        
        #########################################################################
        ## Selection column                                                    ##
        dfRv[[selectionColName]] <- ""
        dfRv[dfRv$avgCountsPerGenePerSample >= avgCountCutOffperSample, selectionColName] <- "+"
        ## Done adding selection Column                                        ##
        #########################################################################
        
        #########################################################################
        ## Determine DESEQ2 variation estimate                                 ##
        if(!is.null(obj@ObjDds)){
            library(DESeq2)
            if (length(unique(obj@dfDesign$sample.id)) > 42) {
                rld <- vst(obj@ObjDds)    
            } else {
                rld <- rlog(obj@ObjDds)    
            }
            
            #########################################################################
            ## Create row variance df                                              ##
            
            # Rowvars definition https://www.rdocumentation.org/packages/metaMA/versions/3.1.2/topics/rowVars
            
            DEseq2RV <- rowVars(assay(rld))
            assign(rowNameID, names(rld))
            
            dfRvAdd <- data.frame(
                DEseq2RV, 
                get(obj@parameterList$primaryAlignmentGeneID)
            )
            names(dfRvAdd) <- c("DEseq2RV", rowNameID)
            
            dfRv <- merge(
                dfRv,
                dfRvAdd,
                by.x = rowNameID,
                by.y = rowNameID
            )
            
        } #End deseq2 object
        
        
        
        ## Done with DESEQ2                                                    ##
        #########################################################################
        
        #########################################################################
        ## Add results to object                                               ##
        obj@dataTableList[["dfRowVar"]] <- dfRv
        ## Done                                                                ##
        #########################################################################
        return(obj)
    })

## Done Method determine row variability                                   ##
#############################################################################


###############################################################################
## PCA Method                                                                ##
setGeneric(
    name="doPCA",
    def=function(
        obj, 
        Ntop4pca = 500,
        avgCountCutOffperSample = 0,
        pcaSelectionVec = NULL,
        pcaDimensionsToInvestigate = c(1:5)
    ) {
        if (!dir.exists(obj@parameterList$DEseq2Dir)){
            dir.create(obj@parameterList$DEseq2Dir)
        }
        
        setwd(obj@parameterList$DEseq2Dir)     
        
        if (obj@parameterList$batchMode){
            library(limma)
            
            if (length(unique(obj@dfDesign$sample.id)) > 42) {
                mPCA <- removeBatchEffect(assay(vst(obj@ObjDds)), obj@ObjDds$replicate)
            } else {
                mPCA <- removeBatchEffect(assay(rlog(obj@ObjDds)), obj@ObjDds$replicate)
            }
            
            
            pca <- prcomp(t(mPCA))
            
            #rld <- rlog(ddsPCA, blind=FALSE)
        } else {
            if (length(unique(obj@dfDesign$sample.id)) > 42) {
                rld <- vst(obj@ObjDds)    
            } else {
                rld <- rlog(obj@ObjDds)    
            }
            
            rv <- rowVars(assay(rld))
            
            ## Added variable genes table  
            if (is.null(pcaSelectionVec)){
                select <- order(rv, decreasing = TRUE)[seq_len(Ntop4pca)]
                obj@dataTableList[["Ntop4pcaGeneSelection"]] <- row.names(assay(rld)[select, ])
                pcaSelectionVec <- row.names(assay(rld)[select, ])
            } 
            
            pca = prcomp(t(assay(rld)[pcaSelectionVec, ]))
            
            obj@PCApercentVar <- pca$sdev^2/sum(pca$sdev^2)
            
            ## Add percent variation plot ##
            PercentVariation <- round(100*obj@PCApercentVar,1)
            PCdimension <- paste0("PC", 1:length(PercentVariation))
            df <- data.frame(
                PercentVariation,
                PCdimension
            )
            df <- df[df$PercentVariation > 0,]
            
            library(ggplot2)
            obj@plotCollection[["PCAvariationPerDimensionO"]] <- ggplot(df, aes(PCdimension, PercentVariation)) + geom_col() + scale_x_discrete(limits=PCdimension) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            )
            
            #pcaFN <- "pca.table.txt"
            #fn = paste("PCA_plot.sample.groups.normalized.counts.png", sep="")
            #png(fn, type="cairo")
            #dev.off()
            
            ## Adding gene annotations ##
            dfBase <- assay(rld)[pcaSelectionVec, ]
            
            dfBase <- t(dfBase)
            pcaGenes = prcomp(scale(dfBase))
            
        }
        
        df.design.pca <- unique(obj@dfDesign[,c("sample.id", "sample.group")])
        df.pca = data.frame(pca$x)
        df.pca[["sample.id"]] <- row.names(df.pca)
        
        df.pca <- merge(
            df.design.pca, 
            df.pca, 
            by.x = "sample.id", 
            by.y = "sample.id"
        )
        
        df.pca <- df.pca[order(df.pca$sample.id),]
        names(df.pca) <- gsub("[.]", "_", names(df.pca))
        
        obj@dfPCA <- df.pca
        
        ## Add plot ##
        tryCatch({   
            obj@plotCollection[["PCAd1d2plot"]] <- plotPCA(
                rld,
                ntop = Ntop4pca
            )
        }, 
        error = function(c) "Plot error",
        warning = function(c) "warning",
        message = function(c) "message" 
        
        )
        
        ###########################################################################
        ## Get loadings ##                                                       ##
        ## Loadings for the first principal component##
        dfPcaGenes = data.frame(pcaGenes$x)
        dfPcaGenes[[obj@parameterList$primaryAlignmentGeneID]] <- row.names(dfPcaGenes)
        
        dfLoad <- pcaGenes$rotation
        dfLoad <- t(dfLoad)
        
        dfBase <- data.frame(dfBase)
        
        #######################################################################
        ## helper function                                                   ##
        
        determinePCAloadings <- function(
            lmFitDim = 'lmFitDim',
            dfBase = 'dfBase',
            primary.alignment.gene.id = 'primary.alignment.gene.id'
        ){
            for (i in 1:ncol(dfBase)){
                corVar <- names(dfBase)[i]
                regression_formula <- as.formula(paste0("pcaGenes$x[,",lmFitDim,"]~", corVar))
                fit <- lm(regression_formula, data=dfBase)
                #summary(fit)
                p.value <- summary(fit)$coefficients[corVar,"Pr(>|t|)"]
                estimate <- summary(fit)$coefficients[corVar,"Estimate"]
                intercept <- summary(fit)$coefficients[grep("Intercept", row.names(summary(fit)$coefficients)),"Estimate"]
                rsquared <- summary(fit)$r.squared
                
                new.row <- data.frame(p.value, estimate, intercept, rsquared)
                
                row.names(new.row) <- corVar
                if (i!=1){
                    dfRes <- rbind(dfRes, new.row)
                } else {
                    dfRes <- new.row
                }
            }
            
            dfRes <- dfRes[order(dfRes$p.value, decreasing = FALSE),]
            dfRes[["padj"]] <- p.adjust(dfRes$p.value, method = "BH")
            names(dfRes) <- paste0(names(dfRes), ".PCA", lmFitDim)
            dfRes[[primary.alignment.gene.id]] <- row.names(dfRes)
            
            
            ## Add log10p column ##
            padj  <- names(dfRes)[grep("padj", names(dfRes))]
            lg10p <- gsub("padj", "lg10p", padj) 
            
            for (z in 1:length(padj)){
                preprocess <- as.numeric(dfRes[,padj[z]])
                
                if (length(grep("padj", padj[i])) > 0){
                    preprocess <- as.numeric(res[,padj[z]])
                    minNum <- min(preprocess[preprocess != 0])
                    preprocess[preprocess == 0] <- minNum
                } else {
                    preprocess <- as.numeric(dfRes[,padj[z]])
                }
                
                temp <- -1*log10(preprocess)
                #temp[temp >= 50] = 50
                dfRes[,lg10p[z]] <- temp
            }
            ## Done adding log10p ##
            
            return(dfRes)
        }
        
        ## helper function                                                   ##
        #######################################################################
        
        for (l in 1:length(pcaDimensionsToInvestigate)){
            dfTemp <- determinePCAloadings(
                lmFitDim = pcaDimensionsToInvestigate[l],
                dfBase = dfBase,
                primary.alignment.gene.id = obj@parameterList$primaryAlignmentGeneID
            )
            
            if (l ==1){
                dfAll <- dfTemp
            } else {
                dfAll <- merge(
                    dfAll, 
                    dfTemp,
                    by.x = obj@parameterList$primaryAlignmentGeneID,
                    by.y = obj@parameterList$primaryAlignmentGeneID
                )
            }
            print(paste0(l, " dimensions out of ", length(pcaDimensionsToInvestigate), " processed."))
        }
        
        names(dfAll) <- gsub("intercept.PCA", "intercept_PCA", names(dfAll))
        names(dfAll) <- gsub("estimate.PCA", "contrast_P_PCA_estimatePCA", names(dfAll))
        names(dfAll) <- gsub("padj.PCA", "contrast_P_padj_PCA", names(dfAll))
        names(dfAll) <- gsub("lg10p.PCA", "contrast_P_lg10p_PCA", names(dfAll))
        names(dfAll) <- gsub("rsquared.PCA", "r2_PCA", names(dfAll))
        
        obj@dfPCAgenes <- dfAll
        
        ## Adding plots ##
        obj <- createPCAloadingPlots(obj)
        
        return(obj)
    }
    
)  

## Done with pca method                                                      ##
###############################################################################
    

###############################################################################
## PCA Method                                                                ##
setGeneric(
    name="doLinearFittings",
    def=function(
        obj, 
        designColSelector = "",  
        mode = "independentVariation", ## "independentVariation" or "dependentVariation"
        Ntop4pca = 500,
        plotname = "plotname"
    ) {
                                                         ##
    ###########################################################################            
    ## Create PCA table for database                                         ##
    library(gplots)
    library(RColorBrewer)
    library(lattice)
    library(genefilter)
    
                
    ###########################################################################
    ## Create variation estimation                                           ##
            
    library(tidyr)
    library(ggplot2)
    
    designColSelector = unique(c(designColSelector, "sample.id"))    

    if (length(unique(obj@dfDesign$sample.id)) > 42) {
        rld <- vst(obj@ObjDds)    
    } else {
        rld <- rlog(obj@ObjDds)    
    }
    rv = rowVars(assay(rld))
            
    ## Select most variable genes
    select = order(rv, decreasing = TRUE)[seq_len(Ntop4pca)]
    dfTemp = t(assay(rld)[select, ])
            
    pc <- prcomp(dfTemp, center=TRUE, scale=FALSE)
            
    colDatMin = unique(obj@dfDesign[, designColSelector])
    rownames(colDatMin) = as.vector(colDatMin$sample.id)
    
    colDatMin$sample.id <- NULL
    #colnames(colData)[1] = "condition"
    
    
            
    covar_PC_frame <- rbind(
        data.frame(
            Component=1:(nrow(pc$x)-1),
            spread(
                data.frame(
                v=names(colDatMin),
                val=NA_real_
                ),
                key=v, 
                value=val
            )
        )
    )
    
    if (mode == "independentVariation"){        
        covar_PC_frame <- covar_PC_frame[c("Component", names(colDatMin))]
        for (i in 1:nrow(covar_PC_frame)) {
            ## old code from gavin below ##
            fit <- lm(pc$x[,i]~., data=colDatMin)
            covar_PC_frame[i,-1] <- drop1(fit, test="F")[names(covar_PC_frame)[-1],"Pr(>F)"]
                
                ## replaced 25032019 ##
                # Fit each variable individually @
        }
    } else {
        mode <- "dependentVariation"
    ## Do fitting individually ##
    ## Check that all selVec entries exist
        fitVars <- names(covar_PC_frame)
        fitVars <- fitVars[fitVars != "Component"]
        covar_PC_frame <- covar_PC_frame[c("Component", names(colDatMin))]
            
            
        for (i in 1:nrow(covar_PC_frame)) {
            ## old code from gavin below ##
            for (j in 1:length(fitVars)){
                corVar <- fitVars[j]
                    
                if (length(unique(obj@dfDesign[, corVar])) > 1) {
                    pcDim <- paste0("pc$x[,",i,"]")
                    regressionFormula <- as.formula(paste(pcDim, corVar, sep="~"))
                    fit <- lm(regressionFormula, data=colDatMin)
                    pVal <- as.vector(summary(fit)$coefficients[,4][2])
                    covar_PC_frame[i, corVar] <- pVal
                }
            }
        }
    }
            
        ## Create plot ##
            
    plotFrame <- gather(covar_PC_frame, key=Covariate, value=p, -Component)
    plotFrame <- plotFrame[order(plotFrame$Component, decreasing = FALSE),]
            
    if (nrow(plotFrame) > 20) {
        plotFrame <- plotFrame[1:(length(names(colDatMin)) * 20), ]
    }
            
    ## Cut to 10 dimensions ##
        
    obj@plotCollection[[plotname]] <- ggplot(
        plotFrame, 
        aes(x=Component, y=Covariate, fill=-log10(p))) +
        geom_raster() +
        scale_fill_gradient(low="grey90", high="red") +
        theme_classic() + 
        coord_fixed() +
        scale_x_continuous( labels = unique(plotFrame$Component), breaks = unique(plotFrame$Component)
    )
    
    return(obj)
    
    }
    
)
    
    
    
## Done creating estimation variation                                    ##
###########################################################################
            
###########################################################################
## Create sample dendrogram                                              ##

setGeneric(
    name="createSampleDendrogram",
    def=function(
        obj, 
        Ntop4pca = 500,
        plotname = "dendrogram"
    ) {            
        library(ggdendro)   
        ###########################################################################
        ## Create dendrogram                                                     ##
        
        if (length(unique(obj@dfDesign$sample.id)) > 42) {
            rld <- vst(obj@ObjDds)    
        } else {
            rld <- rlog(obj@ObjDds)    
        }
        
        rv <- rowVars(assay(rld))
        select <- order(rv, decreasing = TRUE)[seq_len(Ntop4pca)]
            
        normCounts <- (assay(rld)[select, ])
        
        c <- cor(as.matrix(normCounts), method="pearson")
        d <- as.dist(1-c)
        hr <- hclust(d, method = "ward.D", members=NULL)
        
        tryCatch({   
        obj@plotCollection[[plotname]] <- ggdendrogram(
            hr, 
            rotate = TRUE, 
            size = 4, 
            theme_dendro = FALSE, 
            color = "tomato"
            ) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            )
        }, 
        error = function(c) "Plot error",
        warning = function(c) "warning",
        message = function(c) "message" 
        
        )
            
            
        return(obj)    
            
        }
    
)


## Done with dendrogram functionality                                        ##
###############################################################################

###############################################################################
## Do differential gene expression                                           ##

setGeneric(
    name="doDGEanalysis",
    def=function(
        obj,
        DGEdesignCols = 'names(Obio@dfDesign)[grep("comp_", names(Obio@dfDesign)) ]',
        createNewResultTable = TRUE,
        normaliseAllSamplesTogether = FALSE
        
    ) {
        #######################################################################
        ## Ensure result table slot is reset                                 ##
        if (createNewResultTable){
            obj@DEseq2contrastTable <- data.frame(NULL)
        }
        ## Done emptying past results                                        ##
        #######################################################################
        
        #######################################################################
        ## DGE Analysis                                                      ##
        if (length(DGEdesignCols) > 0){
            for (i in 1:length(DGEdesignCols)){
                if (obj@parameterList$batchMode){
                    selCols <- c("sample.id", "sample.group","replicate", DGEdesignCols[i])
                    designFormula <- as.formula("~ replicate + condition")
                } else {
                    selCols <- c("sample.id", "sample.group", DGEdesignCols[i])
                    designFormula <- as.formula("~ condition")
                }
                
                colData = unique(obj@dfDesign[, selCols])
                rownames(colData) = as.vector(colData$sample.id)
                colnames(colData)[1] = "condition"
                colData[,1] <- colData[,DGEdesignCols[i]]
                
                
                if (obj@parameterList$batchMode){
                    colData$replicate <- as.factor(colData$replicate)
                }
                
                
                if (!normaliseAllSamplesTogether) {
                    colData = droplevels(data.frame(colData[colData$condition != "",]))
                    colData <- colData[order(colData$condition),]
                } else {
                    colData[colData$condition == "", "condition"] <- "rest"
                }
                
                
                colData[,"condition"] = as.factor(colData[,"condition"])
                colData$sample.group <- as.factor(colData$sample.group)
                #colData$sample.group <- as.factor(colData$sample.group)
                
                #Remove superflous rows from colData
                ## Extract order for col names ##
                contrasts = sort(unique(obj@dfDesign[,DGEdesignCols[i]]), decreasing = FALSE)  
                contrasts = contrasts[contrasts != ""]
                
                ## Remove order suffix
                colData$condition <- gsub("^1_", "", colData$condition)
                colData$condition <- gsub("^2_", "", colData$condition)
                contrasts <- gsub("^1_", "", contrasts)
                contrasts <- gsub("^2_", "", contrasts)
                
                #Create contrast vector
                #contrast.vector = c([condition],[1_diff.gene set, e.g. mt],[2_baseline, e.g. wt])
                #if (contrasts[2] != "scr"){
                #  contrasts = rev(contrasts)
                #}
                sel.col = contrasts
                
                contrast.vector = append("condition", contrasts)
                colName = paste(contrasts, collapse = "_vs_")
                
                if (normaliseAllSamplesTogether) {
                    raw.counts.temp = obj@RSEMcountMatrix
                } else {
                    raw.counts.temp = obj@RSEMcountMatrix[,rownames(colData)]    
                }
                
                
                ## Make factor ##
                colData$condition <- as.factor(colData$condition)
                #colData$sample.group <- as.factor(colData$sample.group)
                
                
                
                dds <- DESeqDataSetFromMatrix(
                    countData = raw.counts.temp,
                    colData   = colData,
                    design    = designFormula
                )
                
                #dds$condition <- factor(dds$condition, levels=contrasts)
                dds <- DESeq(
                    dds,
                    test = "Wald",
                    parallel = obj@parameterList$parallelProcessing,
                    betaPrior = obj@parameterList$DEseq2betaPrior
                )
                
                res <- results(dds, contrast = contrast.vector)
                #https://support.bioconductor.org/p/83773/
                #res <- results(dds, contrast=list("conditioncell_type_A","conditioncell_type_B"))
                
                
                #Create MA plot
                library(ggpubr)
                library(ggplot2)
                plotname <- paste0("MAplot_", colName)
                
                tryCatch({
                    obj@plotCollection[[plotname]] <- ggmaplot(
                        res, main = plotname,
                        fdr = 0.05, fc = 4, size = 1,
                        palette = c("#B31B21", "#1465AC", "darkgray"),
                        genenames = as.vector(row.names(res)),
                        legend = "top", top = 5,
                        font.label = c("bold", 5),
                        font.legend = "bold",
                        font.main = "bold",
                        ggtheme = ggplot2::theme_minimal())+
                        theme(plot.title = element_text(hjust = 0.5),
                              panel.border = element_rect(colour = "black", fill=NA, size=1)
                        ) + ylim(-10, 10)
                    
                    
                    #    obj@plotCollection[[plotname]] = print(plotMA(res, main=colName))
                }, 
                error = function(c) "MA plot not produced due to X11 error",
                warning = function(c) "warning",
                message = function(c) "message" 
                )
                
                #Identify most variable genes in the dataset
                #Use sd(row)/mean(row)
                
                #Create PCA plot based on the most variable genes in the dataset
                
                
                
                #######################################################################
                
                #Continue with the differential gene expression analysis
                ## reference https://support.bioconductor.org/p/95695/    
                if (obj@parameterList$DEseq2betaPrior == FALSE) {
                    res <- lfcShrink(dds, coef="log2FoldChange", type="apeglm")
                }    
                
                res = data.frame(res)
                names(res) = paste(names(res), colName, sep="_")
                res[[obj@parameterList$primaryAlignmentGeneID]] = rownames(res)
                
                
                names(res) = gsub("log2FoldChange", "logFC", names(res))
                names(res) = gsub(
                    "logFC", 
                    paste("contrast_", i, "_logFC", sep=""), 
                    names(res)
                )
                
                names(res) = gsub(
                    "padj", 
                    paste("contrast_", i, "_padj", sep=""), 
                    names(res)
                )
                
                names(res) = gsub(
                    "stat", 
                    paste("contrast_", i, "_stat", sep=""), 
                    names(res)
                )
                
                res$baseMean <- log2(res$baseMean)
                names(res) = gsub(
                    "baseMean", 
                    paste("contrast_", i, "_lg2BaseMean", sep=""), 
                    names(res)
                )
                
                #Remove all rows without a padj
                padj.col = grep("padj", names(res))[1]
                res[,padj.col][is.na(res[,padj.col])] = ""
                res = res[res[,padj.col] != "", ]
                res[,padj.col] <- as.numeric(res[,padj.col])
                
                ## Add log10p column ##
                padj  <- names(res)[grep("_padj_", names(res))]
                lg10p <- gsub("padj", "lg10p", padj) 
                
                for (z in 1:length(padj)){
                    preprocess <- as.numeric(res[,padj[z]])
                    minNum <- min(preprocess[preprocess != 0])
                    preprocess[preprocess == 0] <- minNum
                    
                    # if (length(grep("padj_LRT", padj[i])) > 0){
                    #     preprocess <- as.numeric(res[,padj[z]])
                    #     minNum <- min(preprocess[preprocess != 0])
                    #     preprocess[preprocess == 0] <- minNum
                    # } else {
                    #     preprocess <- as.numeric(res[,padj[z]])
                    # }
                    
                    temp <- -1*log10(preprocess)
                    #temp[temp >= 50] = 50
                    res[,lg10p[z]] <- temp
                }
                
                col.vector = c(
                    obj@parameterList$primaryAlignmentGeneID,
                    names(res)[grep("contrast", names(res))]
                )
                
                res = res[,col.vector]
                
                ## Make all numeric columns numeric ##
                res[,grep("contrast_", names(res))] <- apply(res[,grep("contrast_", names(res))], 2, as.numeric)
                
                ###############################################################
                ## lg10p 0.00 > 0.001                                        ##
                # lg10pCol <- names(res)[grep("lg10p", names(res))]
                # logFCcol <- names(res)[grep("logFC", names(res))]
                # 
                # res[,lg10pCol] <- res[,lg10pCol] + 0.001
                # res[res[,logFCcol] == 0, lg10pCol] <- 0
                
                ## Done                                                      ##
                ###############################################################
                
                ###############################################################
                ## Make diagnostic Volcano plot                              ##
                dfVplot <- res
                dfVplot[["Significance"]] <- "NS"
                dfVplot[dfVplot[,grep("padj", names(dfVplot))] < 0.05 & dfVplot[,grep("logFC", names(dfVplot))] > 2, "Significance"] <- "Up"
                dfVplot[dfVplot[,grep("padj", names(dfVplot))] < 0.05 & dfVplot[,grep("logFC", names(dfVplot))] < -2, "Significance"] <- "Down"
                nrow(dfVplot[dfVplot$Significance == "Up",])
                nrow(dfVplot[dfVplot$Significance == "Down",])
                
                dsize <- 1
                alpha <- I(0.5)
                shape <- 21
                
                tryCatch({
                    library(ggplot2)
                    plotname <- paste0("Volcano_Plot_", colName)
                    obj@plotCollection[[plotname]] <- ggplot(
                        data=dfVplot,
                        aes_string(
                            x=names(res)[grep("logFC", names(res))], 
                            y=names(res)[grep("lg10p", names(res))],
                            fill = "Significance", alpha = alpha
                        )
                    ) + geom_vline(xintercept = 0, color = "black", size=0.5
                    ) + geom_hline(yintercept = 0, color = "black", size=0.5
                    ) + geom_vline(xintercept = c(-2,2), color = "red", size=0.5,linetype = 2
                    ) + geom_hline(yintercept = c(1.3), color = "red", size=0.5,linetype = 2
                    ) + geom_point(shape=shape
                    ) + labs(title = plotname, y = "-log10(padjust)"
                    ) +  theme(
                        axis.text.y   = element_text(size=8),
                        axis.text.x   = element_text(size=8),
                        axis.title.y  = element_text(size=8),
                        axis.title.x  = element_text(size=8),
                        axis.line = element_line(colour = "black"),
                        panel.border = element_rect(colour = "black", fill=NA, size=1),
                        plot.title = element_text(hjust = 0.5, size = 12),
                        panel.grid.minor = element_blank()
                    ) + scale_x_continuous(breaks=c(-2,2,seq(-30,30,5))
                    ) + scale_y_continuous(breaks=c(seq(0,400,5))
                    ) + scale_color_manual(values=c("black", "black", "black")
                    ) + scale_fill_manual(values=c("blue", "grey", "red")                       
                    ) + guides(color = FALSE
                    )
                    
                    
                    #obj@plotCollection[[plotname]] = print(plotMA(res, main=colName))
                }, 
                error = function(c) "MA plot not produced due to X11 error",
                warning = function(c) "warning",
                message = function(c) "message" 
                
                )
                ## Done diagnostic Volcano plot                              ##
                ###############################################################
                
                ## Add to result array ##
                if (nrow(obj@DEseq2contrastTable) == 0){
                    obj@DEseq2contrastTable <- res
                } else {
                    obj@DEseq2contrastTable <- merge(
                        obj@DEseq2contrastTable,
                        res, 
                        by.x = obj@parameterList$primaryAlignmentGeneID,
                        by.y = obj@parameterList$primaryAlignmentGeneID,
                        all = TRUE
                    )
                    obj@DEseq2contrastTable[is.na(obj@DEseq2contrastTable)] <- 0
                }
            }
            ####################################
            ## End for loop for DGE         ####
            ####################################
        } ## Ed DGE
        
        
        
        return(obj)  
        
    }
)

## Done LRT/DGE method                                                       ##
###############################################################################


###############################################################################
## Do LRT analysis                                                           ##

setGeneric(
    name="doLRTanalysis",
    def=function(
        obj,
        LRTdesignCols = 'names(Obio@dfDesign)[grep("LRT_", names(Obio@dfDesign)) ]',
        createNewResultTable = TRUE
    ) {
        
        #######################################################################
        ## Ensure result table slot is reset                                 ##
        if (createNewResultTable){
            obj@DEseq2LRTtable <- data.frame(NULL)
        }
        ## Done emptying past results                                        ##
        #######################################################################
        
        
        
        if (length(LRTdesignCols) > 0){
            for (i in 1:length(LRTdesignCols)){
                if (obj@parameterList$batchMode){
                    selCols <- c("sample.id", "sample.group","replicate", LRTdesignCols[i])
                    designFormula <- as.formula("~ replicate + condition")
                } else {
                    selCols <- c("sample.id", "sample.group", LRTdesignCols[i])
                    designFormula <- as.formula("~ condition")
                }
                
                colData = unique(obj@dfDesign[, selCols])
                rownames(colData) = as.vector(colData$sample.id)
                colnames(colData)[1] = "condition"
                colData[,1] = as.factor(colData[,LRTdesignCols[i]])
                colData$sample.group <- as.factor(colData$sample.group)
                
                #Remove superflous rows from colData
                colData = droplevels(data.frame(colData[colData$condition != "",]))
                
                
                colData <- colData[order(colData$condition),]
                
                ## Extract order for col names ##
                contrasts = sort(unique(obj@dfDesign[,LRTdesignCols[i]]), decreasing = FALSE)  
                contrasts = contrasts[contrasts != ""]
                
                ## Remove order suffix
                colData$condition <- gsub("^1_", "", colData$condition)
                colData$condition <- gsub("^2_", "", colData$condition)
                contrasts <- gsub("^1_", "", contrasts)
                contrasts <- gsub("^2_", "", contrasts)
                
                #Create contrast vector
                #contrast.vector = c([condition],[1_diff.gene set, e.g. mt],[2_baseline, e.g. wt])
                #if (contrasts[2] != "scr"){
                #  contrasts = rev(contrasts)
                #}
                sel.col = contrasts
                
                contrast.vector = append("condition", contrasts)
                colName = paste(contrasts, collapse = "_vs_")
                
                raw.counts.temp = obj@RSEMcountMatrix[,rownames(colData)]
                
                ## Make factor ##
                colData$condition <- as.factor(colData$condition)
                colData$sample.group <- as.factor(colData$sample.group)
                
                if (obj@parameterList$batchMode){
                    colData$replicate <- as.factor(colData$replicate)
                }
                
                dds <- DESeqDataSetFromMatrix(
                    countData = raw.counts.temp,
                    colData   = colData,
                    design    = designFormula
                )
                
                
                ## Perform LRT ##
                if (obj@parameterList$batchMode){
                    reducedFormula <- as.formula("~ replicate")
                } else {
                    reducedFormula <- as.formula("~ 1")
                }
                
                dds <- DESeq(
                    dds,
                    test = "LRT",
                    parallel = obj@parameterList$parallelProcessing,
                    reduced = reducedFormula
                )
                
                res <- results(dds)
                
                ###############################################################
                ## Add result to result collection                           ##
                
                #Continue with the differential gene expression analysis
                res = data.frame(res)
                res[[obj@parameterList$primaryAlignmentGeneID]] = rownames(res)
                
                res$stat <- NULL
                
                res$baseMean <- log2(res$baseMean)
                names(res) = gsub(
                    "baseMean", 
                    paste0("contrast_L_lg2BaseMean_", LRTdesignCols[i]),
                    names(res)
                )
                
                names(res) = gsub(
                    "padj", 
                    paste0("contrast_L_padj_", LRTdesignCols[i]), 
                    names(res)
                )
                
                
                
                #Remove all rows without a padj
                padj.col = grep("padj", names(res))[1]
                res[,padj.col][is.na(res[,padj.col])] = ""
                res = res[res[,padj.col] != "", ]
                res[,padj.col] <- as.numeric(res[,padj.col])
                
                ## Add log10p column ##
                padj  <- names(res)[grep("_padj_", names(res))]
                lg10p <- gsub("padj", "lg10p", padj) 
                
                for (z in 1:length(padj)){
                    preprocess <- as.numeric(res[,padj[z]])
                    minNum <- min(preprocess[preprocess != 0])
                    preprocess[preprocess == 0] <- minNum
                    
                    # if (length(grep("padj_LRT", padj[i])) > 0){
                    #     preprocess <- as.numeric(res[,padj[z]])
                    #     minNum <- min(preprocess[preprocess != 0])
                    #     preprocess[preprocess == 0] <- minNum
                    # } else {
                    #     preprocess <- as.numeric(res[,padj[z]])
                    # }
                    
                    temp <- -1*log10(preprocess)
                    #temp[temp >= 50] = 50
                    res[,lg10p[z]] <- temp
                }
                
                col.vector = c(
                    obj@parameterList$primaryAlignmentGeneID,
                    names(res)[grep("contrast", names(res))]
                )
                
                res = res[,col.vector]
                
                ## Make all numeric columns numierc ##
                ## Make all numeric columns numierc ##
                res[,grep("contrast_", names(res))] <- apply(res[,grep("contrast_", names(res))], 2, as.numeric)
                
                ###############################################################
                ## lg10p 0.00 > 0.001                                        ##
                # lg10pCol <- names(res)[grep("lg10p", names(res))]
                # logFCcol <- names(res)[grep("logFC", names(res))]
                # 
                # res[,lg10pCol] <- res[,lg10pCol] + 0.001
                # res[res[,logFCcol] == 0, lg10pCol] <- 0
                
                ## Done                                                      ##
                ###############################################################    
                
                ## Add to result array ##
                if (nrow(obj@DEseq2LRTtable) == 0){
                    obj@DEseq2LRTtable <- res
                } else {
                    obj@DEseq2LRTtable <- merge(
                        obj@DEseq2LRTtable,
                        res, 
                        by.x = obj@parameterList$primaryAlignmentGeneID,
                        by.y = obj@parameterList$primaryAlignmentGeneID,
                        all = TRUE
                    )
                    obj@DEseq2LRTtable[is.na(obj@DEseq2LRTtable)] <- 0
                }
                
                
                ## Done adding to result collection                          ##
                ###############################################################
            } 
            
            
            ####################################
            ## End for loop for LRT         ####
            ####################################
        } 
        
        
        
        ## Done with LRT Analysis                                            ##
        #######################################################################
        
        return(obj)
        
        
    }
)

## Done LRT method                                                       ##
###############################################################################



###############################################################################
# (8c) do.differential.expresion.analysis                                     #
###############################################################################

do.differential.expression.analyis <- function(
    raw.counts.filt = raw.counts.filt,           #count data filename
    DEseq2Dir = paste0(localWorkDir, "DESeq2"), #directory for results
    df.design = df.design,                      #df.design
    gene.id = "ENSMUSG",                        #primary gene id after alignment 
    batch.mode = FALSE, 
    #if true, df.design needs to contain a 'replicate' column 
    parallel = FALSE,
    toBeNormalized = TRUE, # TRUE if the dataset is to be normalized # False if a normalized matrix is provided
    plotOutputDir = "",
    doPCA = TRUE,
    writePlotsToFile = TRUE,
    timeseries = FALSE,
    tempShellScriptVector = as.vector(NULL, mode = "character")
) {
    #######################################
    #Differential gene expresion in DESEQ2#
    #######################################
    library(DESeq2)
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        paste0(capture.output(sessionInfo()), " \n")
    )
    
    #Reduce df.design to one row per sample; getting rid of separate R1/R2 rows
    sel.vec <- names(df.design)[grep("comp_", names(df.design))]
    
    if (length(grep("^FASTQ$", names(df.design))) == 0){
        df.design[["FASTQ"]] <- df.design$sample.id
    }
    
    sel.vec <- c(
        sel.vec,
        "FASTQ", 
        "sample.id", 
        "sample.group",
        "dataseries",
        "replicate",
        names(df.design)[grep("^LRT_", names(df.design))]
    )
    
    # if (batch.mode){
    #     sel.vec <- c(
    #         sel.vec,
    #         "replicate"
    #     )
    #     
    # } 
    
    ## Add timeseries parameter ##
    if (timeseries){
        sel.vec <- c(
            sel.vec,
            "timepoint"
        )
    }
    
    
    rmVec <- grep("LRT_", sel.vec)
    
    if (length(rmVec) > 0){
        sel.vec <- sel.vec[-rmVec]
    } 
    
    df.design <- unique(
        df.design[,sel.vec]
    )
    
    
    comparisons = names(df.design)[grep("comp_", names(df.design))]
    if (length(grep("DESeq2", list.dirs())) == 0){
        dir.create(DEseq2Dir)
    }
    
    setwd(DEseq2Dir)
    
    ## Ensure that replicate is set ##
    if (!batch.mode) {
        df.design[["replicate"]] = paste0("B", df.design$sample.id)
    }
    
    
    ###########################################################################
    ## Perform sample group LRT                                              ##
    
    
    if (length())
    
    
    
    
    #Evaluate results
    res <- results(dds)
    
    #Continue with the differential gene expression analysis
    res = data.frame(res)
    res[[gene.id]] = rownames(res)
    
    names(res) = gsub("log2FoldChange", "LRT_logFC", names(res))
    
    res$LRT_logFC <- NULL
    res$stat <- NULL
    
    names(res) = gsub(
        "padj", 
        "contrast_G_padj_LRTsampleGroup", 
        names(res)
    )
    
    
    #Remove all rows without a padj
    padj.col = grep("padj", names(res))[1]
    res[,padj.col][is.na(res[,padj.col])] = ""
    res = res[res[,padj.col] != "", ]
    
    
    fn = paste("DESeq2.results.LRTsampleGroup.txt", sep="")
    
    #Select columns to carry forward
    col.vector = gene.id
    col.vector = append(
        col.vector, 
        names(res)[grep("LRT", names(res))]
    )
    
    res = res[,col.vector]
    
    write.table(res, fn, row.names=FALSE, sep="\t")
    
    ## Done with sample LRT                                                  ##
    ###########################################################################
    
    ###########################################################################
    ## Perform replicate LRT                                                 ##
    
    ## Done with replicate LRT                                               ##
    ###########################################################################
    
    ###########################################################################
    ## Perform data-series LRT                                               ##
    if (length(unique(df.design$dataseries)) > 1){
        if (batch.mode){
            colData = df.design[, c("sample.id", "dataseries","replicate")]
            rownames(colData) = as.vector(df.design$sample.id)
            colData$sample.id <- NULL
            colnames(colData)[1] = "condition"
            colData$condition <- as.factor(colData$condition)
            
            
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.filt,
                colData   = colData,
                design    = ~ replicate + condition
            )
            
            ## This will only take the condition parameter into account      ##
            ## This will answer to the question if any samples are different ##
            dds <- DESeq(
                dds,
                test = "LRT",
                parallel = parallel,
                reduced = ~ replicate
            )
            
        } else {
            colData = df.design[, c("sample.id", "dataseries")]
            rownames(colData) = as.vector(df.design$sample.id)
            colData$sample.id <- NULL
            colnames(colData)[1] = "condition"
            colData$condition <- as.factor(colData$condition)
            
            ## This will now determine if the difference is explained by 
            ## condition
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.filt,
                colData   = colData,
                design    = ~ condition
            )
            
            ## This will only take the condition parameter into account      ##
            ## This will answer to the question if any samples are different ##
            dds <- DESeq(
                dds,
                test = "LRT",
                parallel = parallel,
                reduced = ~1
            )
        }
        
        
        
        #Evaluate results
        res <- results(dds)
        
        #Continue with the differential gene expression analysis
        res = data.frame(res)
        res[[gene.id]] = rownames(res)
        
        names(res) = gsub("log2FoldChange", "LRT_logFC", names(res))
        res$LRT_logFC <- NULL
        
        names(res) = gsub(
            "padj", 
            "contrast_D_padj_LRTdataseries", 
            names(res)
        )
        
        
        #Remove all rows without a padj
        padj.col = grep("padj", names(res))[1]
        res[,padj.col][is.na(res[,padj.col])] = ""
        res = res[res[,padj.col] != "", ]
        
        
        fn = paste("DESeq2.results.LRTdataseries.txt", sep="")
        
        #Select columns to carry forward
        col.vector = gene.id
        col.vector = append(
            col.vector, 
            names(res)[grep("LRT", names(res))]
        )
        
        res = res[,col.vector]
        
        write.table(res, fn, row.names=FALSE, sep="\t")
    }
    ## Done performing data-series_LRT
    ###########################################################################
    
    ###########################################################################
    ## Perform custon LRT (dfDesign "LRT_columns")                           ##
    LRTcols <- names(df.design)[grep("^LRT_", names(df.design))]
    
    if (length(LRTcols) > 0){
        for (k in 1:length(LRTcols)){
            if (batch.mode){
                colData = df.design[, c("sample.id", LRTcols[k],"replicate")]
                rownames(colData) = as.vector(df.design$sample.id)
                colData$sample.id <- NULL
                colnames(colData)[1] = "condition"
                colData$condition <- as.factor(colData$condition)
                
                
                dds <- DESeqDataSetFromMatrix(
                    countData = raw.counts.filt,
                    colData   = colData,
                    design    = ~ replicate + condition
                )
                
                ## This will only take the condition parameter into account      ##
                ## This will answer to the question if any samples are different ##
                dds <- DESeq(
                    dds,
                    test = "LRT",
                    parallel = parallel,
                    reduced = ~ replicate
                )
                
            } else {
                colData = df.design[, c("sample.id", LRTcols[k])]
                rownames(colData) = as.vector(df.design$sample.id)
                colData$sample.id <- NULL
                colnames(colData)[1] = "condition"
                colData$condition <- as.factor(colData$condition)
                
                ## This will now determine if the difference is explained by 
                ## condition
                dds <- DESeqDataSetFromMatrix(
                    countData = raw.counts.filt,
                    colData   = colData,
                    design    = ~ condition
                )
                
                ## This will only take the condition parameter into account      ##
                ## This will answer to the question if any samples are different ##
                dds <- DESeq(
                    dds,
                    test = "LRT",
                    parallel = parallel,
                    reduced = ~1
                )
            }
            
            
            
            #Evaluate results
            res <- results(dds)
            
            #Continue with the differential gene expression analysis
            res = data.frame(res)
            res[[gene.id]] = rownames(res)
            
            names(res) = gsub("log2FoldChange", "LRT_logFC", names(res))
            
            res$LRT_logFC <- NULL
            res$stat <- NULL
            
            names(res) = gsub(
                "padj", 
                paste0("contrast_L_padj_", LRTcols[k]), 
                names(res)
            )
            
            
            #Remove all rows without a padj
            padj.col = grep("padj", names(res))[1]
            res[,padj.col][is.na(res[,padj.col])] = ""
            res = res[res[,padj.col] != "", ]
            
            
            fn = paste("DESeq2.results.", LRTcols[k],".txt", sep="")
            
            #Select columns to carry forward
            col.vector = gene.id
            col.vector = append(
                col.vector, 
                names(res)[grep("LRT", names(res))]
            )
            
            res = res[,col.vector]
            
            write.table(res, fn, row.names=FALSE, sep="\t")
        }
    }
    
    ## Done with sample LRT                                                  ##
    ###########################################################################
    
    ###########################################################################
    ## Perform timecourse LRT                                                ##
    if (timeseries){
        if (batch.mode){
            colData = df.design[, c("data.series","sample.id", "sample.group","replicate", "timepoint")]
            rownames(colData) = as.vector(df.design$sample.id)
            colData$sample.id <- NULL
            colnames(colData)[1] = "condition"
            colData$condition <- as.factor(colData$condition)
            
            
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.filt,
                colData   = colData,
                design    = ~ replicate + condition
            )
            
        } else {
            colData = df.design[, c("sample.id", "sample.group", "dataseries","timepoint")]
            rownames(colData) = as.vector(df.design$sample.id)
            colData$sample.id <- NULL
            
            colData$dataseries <- as.factor(colData$dataseries)
            colData$timepoint <- as.factor(colData$timepoint)
            
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.filt,
                colData   = colData,
                design = ~ dataseries + timepoint +dataseries:timepoint
            )
        }
        
        ## This will only take the condition parameter into account ##
        dds <- DESeq(
            dds,
            test = "LRT",
            parallel = parallel,
            reduced = ~ dataseries + timepoint
        )
        
        #Evaluate results
        res <- results(dds)
        
        #Continue with the differential gene expression analysis
        res = data.frame(res)
        res[[gene.id]] = rownames(res)
        
        names(res) = gsub("log2FoldChange", "contrast_0_logFC_timecourseLRT", names(res))
        
        
        names(res) = gsub(
            "padj", 
            "contrast_0_padj_timecourseLRT", 
            names(res)
        )
        
        
        #Remove all rows without a padj
        padj.col = grep("padj", names(res))[1]
        res[,padj.col][is.na(res[,padj.col])] = ""
        res = res[res[,padj.col] != "", ]
        
        
        fn = paste("DESeq2.results.timecourseLRT.txt", sep="")
        
        #Select columns to carry forward
        col.vector = gene.id
        col.vector = append(
            col.vector, 
            names(res)[grep("LRT", names(res))]
        )
        
        res = res[,col.vector]
        
        write.table(res, fn, row.names=FALSE, sep="\t")
    }
    
    
    ## Done timecourse LRT                                                   ##
    ###########################################################################
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '\n',
        '################################################################################',
        '\n',
        '## R-commands used for differential gene expression analysis:                 ##',
        '\n'
    )
    
    
    
    
    #Create individual comparisons after subsetting the raw counts table
    ######################
    ## Begin for loop   ##
    for (i in 1:length(comparisons)){
        #Create col data data frame
        if (batch.mode){
            colData = df.design[, c("sample.id", "sample.group","replicate")]
            rownames(colData) = as.vector(df.design$sample.id)
            colnames(colData)[1] = "condition"
            #colnames(colData)[2] = "replicate"
            colData[,1] = as.factor(df.design[,comparisons[i]])
        } else {
            colData = df.design[, c("sample.id", "sample.group")]
            rownames(colData) = as.vector(df.design$sample.id)
            colnames(colData)[1] = "condition"
            colData[,1] = as.factor(df.design[,comparisons[i]])
            colData$sample.group <- as.factor(colData$sample.group)
        }
        
        #Remove superflous rows from colData
        colData = droplevels(data.frame(colData[colData$condition != "",]))
        #colData$sample.group = NULL
        #Bring coldata rows in the same order as raw.counts.temp columns
        #colData = data.frame(colData[colnames(raw.counts.temp),])
        #colnames(colData)[1] = "condition"
        
        ## Order colData according to conditon 
        ## e.g. 1_, 2_ if 1_ and 2_ prefix is set in condx column##
        colData <- colData[order(colData$condition),]
        
        ## Extract order for col names ##
        contrasts = sort(unique(df.design[,comparisons[i]]), decreasing = FALSE)  
        contrasts = contrasts[contrasts != ""]
        
        ## Remove order suffix
        colData$condition <- gsub("^1_", "", colData$condition)
        colData$condition <- gsub("^2_", "", colData$condition)
        contrasts <- gsub("^1_", "", contrasts)
        contrasts <- gsub("^2_", "", contrasts)
        
        #Create contrast vector
        #contrast.vector = c([condition],[1_diff.gene set, e.g. mt],[2_baseline, e.g. wt])
        
        
        
        
        #if (contrasts[2] != "scr"){
        #  contrasts = rev(contrasts)
        #}
        sel.col = contrasts
        
        contrast.vector = append("condition", contrasts)
        colName = paste(contrasts, collapse = "_vs_")
        
        raw.counts.temp = raw.counts.filt[,rownames(colData)]
        
        ## Make factor ##
        colData$condition <- as.factor(colData$condition)
        colData$sample.group <- as.factor(colData$sample.group)
        
        if (batch.mode){
            colData$replicate <- as.factor(colData$replicate)
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.temp,
                colData   = colData,
                design    = ~ replicate + condition
            )
            
            ## Documentation ##
            colDataVec <- as.vector(NULL, mode = "character")
            colDataVec <- c(
                colDataVec,
                '\n',
                paste0(c("sample.id",colnames(colData), collapse = "\t")),
                '\n'
            )
            
            for (m in 1:nrow(colData)){
                colDataVec <- c(
                    colDataVec,
                    '\n',
                    paste0(c(row.names(colData)[m],as.vector(t(colData[m,]))), collapse = "\t"),
                    '\n'
                )
            }
            
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '\n',
                '################################################################################',
                '\n',
                paste0("## DGE comparison ", colName, "                                            ##"),
                '\n',
                "dds <- DESeqDataSetFromMatrix(",
                '\n',
                "    countData = raw.counts.temp",
                '\n',
                "    colData   = colData",
                '\n',
                "    design    = ~ replicate + condition",
                '\n',
                ")",
                '\n',
                '\n',
                "DGE Input Matrix",
                colDataVec,
                '\n',
                'dds <- DESeq(dds)',
                '\n',
                'res <- results(dds, contrast = contrast.vector)',
                '\n'
            )
            
            
        } else {
            dds <- DESeqDataSetFromMatrix(
                countData = raw.counts.temp,
                colData   = colData,
                design    = ~ condition
            )
            
            ## Documentation ##
            colDataVec <- as.vector(NULL, mode = "character")
            colDataVec <- c(
                colDataVec,
                '\n',
                paste0(c("sample.id",colnames(colData), collapse = "\t")),
                '\n'
            )
            
            for (m in 1:nrow(colData)){
                colDataVec <- c(
                    colDataVec,
                    paste0(c(row.names(colData)[m],as.vector(t(colData[m,]))), collapse = "\t"),
                    '\n'
                )
            }
            
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '\n',
                paste0("DGE comparison ", comparisons[i]),
                '\n',
                "dds <- DESeqDataSetFromMatrix(",
                '\n',
                "    countData = raw.counts.temp",
                '\n',
                "    colData   = colData",
                '\n',
                "    design    = ~ replicate + condition",
                '\n',
                ")",
                '\n',
                '\n',
                "DGE Input Matrix:",
                '\n',
                colDataVec,
                '\n',
                'dds <- DESeq(dds)',
                '\n',
                'res <- results(dds, contrast = contrast.vector)',
                '\n'
            )
        }
        
        #dds$condition <- factor(dds$condition, levels=contrasts)
        dds <- DESeq(dds)
        res <- results(dds, contrast = contrast.vector)
        #Create MA plot
        fn = paste(plotOutputDir, "MA.plot.", comparisons[i], ".png", sep="")
        
        if (writePlotsToFile){
            png(fn, type="cairo")
            print(plotMA(res, main="DESeq2", ylim=c(-2,2)))
        } else {
            plotMA(res, main="DESeq2", ylim=c(-2,2))
        }
        
        if (writePlotsToFile){
            dev.off()
        }
        
        #Identify most variable genes in the dataset
        #Use sd(row)/mean(row)
        
        #Create PCA plot based on the most variable genes in the dataset
        if (doPCA){
            
            if (length(unique(obj@dfDesign$sample.id)) > 42) {
                rld <- vst(obj@ObjDds)    
            } else {
                rld <- rlog(obj@ObjDds)    
            }
            
            fn = paste(plotOutputDir,"PCA_plot.", comparisons[i], ".png", sep="")
            
            png(fn, type="cairo")
            print(plotPCA(rld, intgroup=c("condition")))
            dev.off()
        }
        #######################################################################
        
        #Continue with the differential gene expression analysis
        res = data.frame(res)
        names(res) = paste(names(res), colName, sep="_")
        res[[gene.id]] = rownames(res)
        
        names(res) = gsub("log2FoldChange", "logFC", names(res))
        names(res) = gsub(
            "logFC", 
            paste("contrast_", i, "_logFC", sep=""), 
            names(res)
        )
        
        names(res) = gsub(
            "padj", 
            paste("contrast_", i, "_padj", sep=""), 
            names(res)
        )
        
        names(res) = gsub(
            "stat", 
            paste("contrast_", i, "_stat", sep=""), 
            names(res)
        )
        
        #Remove all rows without a padj
        padj.col = grep("padj", names(res))[1]
        res[,padj.col][is.na(res[,padj.col])] = ""
        res = res[res[,padj.col] != "", ]
        
        fn = paste("DESeq2.results.", comparisons[i], ".txt", sep="")
        
        #Select columns to carry forward
        col.vector = gene.id
        col.vector = append(
            col.vector, 
            names(res)[grep("contrast", names(res))]
        )
        
        res = res[,col.vector]
        
        write.table(res, fn, row.names=FALSE, sep="\t")
    }
    #########################
    ## End for loop      ####
    #########################
    
    ###############################################################################
    #Preparing a single result table for all comparisons                          #
    ###############################################################################
    setwd(DEseq2Dir)
    
    ## Add LRT ##
    if (length(unique(df.design$dataseries)) > 1){
        comparisons <- c(
            comparisons,
            "LRTsampleGroup",
            "LRTdataseries",
            names(df.design)[grep("LRT_", names(df.design))]
        )
    } else {
        comparisons <- c(
            comparisons,
            "LRTsampleGroup",
            names(df.design)[grep("LRT_", names(df.design))]
        )
    }
    
    ## Add timecourse LRT ##
    if (timeseries){
        comparisons <- c(
            comparisons,
            "timecourseLRT"
        )
        
    }
    
    for (i in 1:length(comparisons)){
        fn = paste("DESeq2.results.", comparisons[i], ".txt", sep="")
        df.temp = read.delim(fn, header=TRUE, sep="\t")
        
        if (i > 1){
            df.summary = merge(
                df.summary, 
                df.temp, 
                by.x = gene.id, 
                by.y = gene.id, 
                all=TRUE
            )
        } else {
            df.summary = df.temp
        }
    }
    
    
    # Set all na p values in df.summary to 1
    p.val <- names(df.summary)[grep("padj", names(df.summary))]
    for (k in 1:length(p.val)){
        df.summary[is.na(df.summary[,p.val[k]]),p.val[k]] = 1
    }
    
    # Set all others to "
    df.summary[is.na(df.summary)] = ""
    #Prepare norm counts section
    names(df.normCounts) = ifelse(
        substr(
            names(df.normCounts), 
            1, 
            1
        ) == "X", 
        substr(names(df.normCounts), 2, 1000), 
        names(df.normCounts)
    )
    
    names(df.normCounts) <- gsub("[.]", "_", names(df.normCounts))
    names(df.normCounts) <- paste("norm_counts", names(df.normCounts), sep="_")
    df.normCounts[[gene.id]] = row.names(df.normCounts)
    
    #Remove all rows with 0 counts ##
    df.summary = merge(
        df.summary, 
        df.normCounts, 
        by.x=gene.id, 
        by.y=gene.id
    )
    
    df.summary[is.na(df.summary)] = ""
    
    
    ## Cleaning up unloading package and namespace to not interfere with
    # Rmysql
    detach("package:DESeq2", unload = TRUE)
    unloadNamespace("DESeq2")
    
    ## Remove RSQLite DDI drivers ##
    unloadNamespace("genefilter")
    unloadNamespace("biomaRt")
    unloadNamespace("geneplotter")
    unloadNamespace("annotate")
    unloadNamespace("AnnotationDbi")
    unloadNamespace("RSQLite")
    
    returnList <- list(
        "df.summary" = df.summary,
        "docuVector" = tempShellScriptVector
    )
    
    return(returnList)
}

## End of function                                                           ##
###############################################################################



## Done differential gene expression                                         ##
###############################################################################

###############################################################################
## Calculate Coefficient of variation                                        ##

## Assemble database table ##
# counts matrix
# DGE table
# LRT table
# RSEM counts
# Annotation

## Done calculating the coefficient of variation                             ##
###############################################################################




## Done initializing S4 object                                               ##
###############################################################################

###############################################################################
## (0a) createConcatenateFASTQfilesShellScript                               ##

createConcatenateFASTQfilesShellScript <- function(
    dfConCat = "dataframe with SRR inut and SRX output file names"
){
    ## Determine need to concatenate ##
    srxVec <- as.vector(unique(dfConCat$srxFASTQname))
    srrVec <- as.vector(unique(dfConCat$srrFASTQname))
    
    SRXvec <- as.vector(
        unique(
            dfConCat$srxFASTQname
        )
    )
    
    ## Create shell script ##
    
    
    scriptVec <- as.vector(NULL, mode = "character")
    scriptVec <- c(
        scriptVec,
        "#!/bin/sh",
        "\n"
    )
    
    
    for (i in 1:length(SRXvec)){
        catFiles <- as.vector(
            dfConCat[dfConCat$srxFASTQname == SRXvec[i], "srrFASTQname"]
        )
        
        
        
        if (length(catFiles) > 1){
            catCMD <- paste0(
                "cat ",
                paste(catFiles, collapse = " "),
                " > ",
                SRXvec[i]
            )
        } else {
            catCMD <- paste0(
                "mv ",
                catFiles[1],
                " ",
                SRXvec[i]
            )
        }
        
        scriptVec <- c(
            scriptVec,
            catCMD,
            "\n"
        )
        
        
    }
    
    sink("concatFASTQfiles.sh")
    for (i in 1:length(scriptVec)){
        cat(scriptVec[i])
    }
    
    sink()
    
    return(scriptVec)
}

## End: createConcatenateFASTQfilesShellScript                               ##
###############################################################################

###############################################################################
## (0b) organizeFastqFiles                                                   ##

## Function parameters ##
organizeFastqFiles <- function(
    baseMount = 'gsub("boeings/", "", hpc.mount)',
    pathToSeqStorageFolder = 'pathToSeqStorageFolder',
    fastqOutputDir = 'fastqDir',
    localWorkDir = 'localworkdir'
){
    SRR <- unlist(sapply(
        pathToSeqStorageFolder,
        function(x) paste0(
            x, list.files(x)
        )
    ))
    
    SRR <- unique(SRR[file.exists(SRR)])
    original.NGS <- SRR
    
    for (i in 1:length(pathToSeqStorageFolder)){
        original.NGS <- gsub(pathToSeqStorageFolder[i], "", original.NGS)
    }
    
    original.NGS <- as.vector(
        unique(
            original.NGS
        )
    )
    
    dfConCat <- data.frame(
        SRR,
        original.NGS,
        stringsAsFactors = FALSE
    )
    
    dfConCat[["R"]] <- ""
    dfConCat[grep("_R1_", as.vector(dfConCat$SRR)), "R"] <- "R1"
    dfConCat[grep("_R2_", as.vector(dfConCat$SRR)), "R"] <- "R2"
    
    dfConCat[["SRX"]] <- ""
    dfConCat$SRX <- sapply(
        as.vector(dfConCat$original.NGS),
        function(x)
            unlist(
                strsplit(x, "_")
            )[1]
    )
    
    dfConCat$SRX <- paste0(
        fastqOutputDir,
        dfConCat$SRX,
        "_",
        dfConCat$R,
        ".fastq.gz"
    )
    
    
    srrFASTQname <- dfConCat$SRR
    srxFASTQname <- dfConCat$SRX
    
    dfConCat <- unique(data.frame(srrFASTQname, srxFASTQname))
    
    ## If necessary, create concatenation script ##
    shellScriptVector <- as.vector(NULL, mode = "character")
    
    if (length(unique(dfConCat$srrFASTQname)) > length(unique(dfConCat$srxFASTQname))){
        setwd(localWorkDir)
        tempShellScriptVector <- createConcatenateFASTQfilesShellScript(
            dfConCat = dfConCat
            #paired.end = FALSE
        )
        shellScriptVector <- c(
            shellScriptVector,
            tempShellScriptVector
        )
        
        print("Remove end of line characters: tr -d '\r' <concatFASTQfiles.sh> conv.concatFASTQfiles.sh")
        concatenationRequired <- TRUE
        
    } else {
        print("One file per sample - no cocatenation required.")
        concatenationRequired <- FALSE
    }
    
    if (concatenationRequired){
        print("Concatenation is required")
        
    } else {
        shellScriptVector <- "No concatenation required"
    }
    
    return(shellScriptVector)
}

## (0b) organizeFastqFiles                                                   ##
###############################################################################


###############################################################################
## (40) completeDesignBasedOnSampleID()                                      ##

## helper function ##
completeDesignBasedOnSampleID <- function(
    dfBasedesign,
    fastqDir = ""
){
    ## Create sample group ##
    dfBasedesign[["sample.group"]] <- as.vector(
        sapply(
            as.vector(dfBasedesign$sample.id),
            function(x) paste(
                unlist(
                    strsplit(x, "_")
                )[c(1:2)],
                collapse = "_"
            )
        )
    )
    
    ## Create dataseries ##
    dfBasedesign[["dataseries"]] <- as.vector(sapply(
        dfBasedesign$sample.group,
        function(x) unlist(
            strsplit(x, "_") 
        )[1]
    ))
    
    ## Create dataseries color ##
    library(RColorBrewer)
    
    nCol <- length(unique(dfBasedesign$dataseries))
    
    selcol <- colorRampPalette(brewer.pal(9,"YlOrBr"))
    groupCols <- selcol(nCol)
    
    dfColor <- data.frame(unique(dfBasedesign$dataseries), groupCols)
    names(dfColor) <- c("dataseries", "dataseries_color")
    
    dfDesign <- merge(dfBasedesign, dfColor, by.x = "dataseries", by.y = "dataseries")
    
    ## Set original.NGS ##
    names(dfDesign) <- gsub("srxFASTQname", "original.NGS", names(dfDesign))
    
    ## Set NGS ##
    dfDesign[["NGS"]] <- paste0(
        fastqDir,
        dfDesign$sample.id,
        "_R1.fastq.gz"
    )
    
    ## Ensure R1/R2 consistency ##
    if (length(grep("original.NGS", names(dfDesign))) > 0){
        pos1 <- grep("R2.fastq.gz",dfDesign$original.NGS)
        if (length(pos1) > 0){
            dfDesign[pos1, "NGS"] <- gsub(
                "R1.fastq.gz",
                "R2.fastq.gz",
                dfDesign[pos1, "NGS"]
            )
        }
    }
    
    return(dfDesign)
    
}

## End completeDesignBasedOnSampleID()                                       ##
###############################################################################

###############################################################################
## (0c) createDesignFileCrickASFsamples                                      ##

createDesignFileCrickASFsamples <- function(
    pathToSeqStorageFolder = 'pathToSeqStorageFolder',
    FNsampleAnnotation = 'paste0(
    S4LvariableListing$localWorkDir,
    "sample.ids.txt")',
    paired.end = 'paired.end',
    fastqDir = 'fastqDir',
    baseMount = ''
    ){
    
    fastqBasefolders = gsub(
        "/camp/stp/babs/working/",
        baseMount,
        unlist(pathToSeqStorageFolder)
    )
    
    original.NGS <- as.vector(NULL, mode = "character")
    original.NGS.FN <- as.vector(NULL, mode = "character")
    for (i in 1:length(fastqBasefolders)){
        original.NGS <- c(
            original.NGS,
            paste0(
                fastqBasefolders[i],
                list.files(
                    fastqBasefolders[i]
                )
            )
        )
        
        original.NGS.FN <- c(
            original.NGS.FN,
            paste0(
                list.files(
                    fastqBasefolders[i]
                )
            )
        )
    }
    
    
    df.fastq <- data.frame(
        original.NGS,
        original.NGS.FN,
        stringsAsFactors = FALSE
    )
    
    df.fastq[["sampleID"]] <- sapply(
        df.fastq$original.NGS.FN,
        function(x)
            unlist(
                strsplit(
                    x, "_"
                )
            )[1]
    )
    
    df.sample.ids <- read.delim(
        file = FNsampleAnnotation,
        header = TRUE,
        stringsAsFactors = FALSE
    )
    
    df.sample.ids <- unique(
        merge(
            df.sample.ids,
            df.fastq,
            by.x = "sampleID", 
            by.y = "sampleID"
        )
    )
    
    dfDesign <- df.sample.ids
    
    ## sample ids ##
    dfDesign <- completeDesignBasedOnSampleID(
        dfBasedesign = dfDesign,
        fastqDir = fastqDir
    )
    
    ## Set NGS ##
    dfDesign[["NGS"]] <- ""
    
    
    dfDesign[grep("_R1.", dfDesign$original.NGS),"NGS"] <- 
        paste0(
            fastqDir,
            dfDesign[grep("_R1.", dfDesign$original.NGS),"sample.id"],
            "_R1.fastq.gz"
        )
    
    if (paired.end){
        dfDesign[grep("_R2.", dfDesign$original.NGS),"NGS"] <- 
            paste0(
                fastqDir,
                dfDesign[grep("_R2.", dfDesign$original.NGS),"sample.id"],
                "_R2.fastq.gz"
            )
    }
    
    ## Set default dataseries colors ##
    library(RColorBrewer)
    selcol <- colorRampPalette(brewer.pal(9,"Set1"))
    sample.groups <- unique(dfDesign$sample.group)
    group.cols <- selcol(length(sample.groups))
    
    
    dfDesign$dataseries_color <- "green"
    for (i in 1:length(sample.groups)){
        dfDesign[dfDesign$sample.group == sample.groups[i], "dataseries_color"] = group.cols[i]
    }
    
    return(dfDesign)
    
    
}

## End: 0c createDesignFileCrickASFsamples                                   ##
###############################################################################

###############################################################################
## (0d) addDGEcomparisons2DesignFile                                         ##

addDGEcomparisons2DesignFile <- function(
    dfDesign = 'dfDesign',
    comparisonList = 'list(
    "WT_vs_MT" = c("MT_YapTaz", "WT_WT")
)'
){
    for (i in 1:length(comparisonList)){
        comparison <- paste0("comp_", i)
        dfDesign[[comparison]] <- ""
        
        dfDesign[grep(comparisonList[[i]][1], dfDesign$sample.group), comparison] <-
            paste0("1_",comparisonList[[i]][1])
        
        dfDesign[grep(comparisonList[[i]][2], dfDesign$sample.group), comparison] <-
            paste0("2_",comparisonList[[i]][2])
    }    
    
    dfDesign <- dfDesign[order(
        dfDesign$dataseries, 
        dfDesign$sample.group, 
        dfDesign$sample.id),
        ]
    
    return(dfDesign)
    }

## End (0d)                                                                  ##
###############################################################################


###############################################################################
## (00) hpcClusterSubmisison                                                 ##

hpcClusterSubmisison <- function(
    CMDstring = "ls", 
    jobname = "SBhpcRun",
    cores = 1,
    memPerCpu = 7000,
    logFN = "report.file.slurm",
    commands.text.file = "commands.txt"
    
){
    hpcString <- c(
        'sbatch --time=12:00:00 --wrap "',
        CMDstring,
        '" --job-name=',
        jobname,
        ' -c ',
        cores,
        ' --mem-per-cpu=',
        memPerCpu,
        ' -o ',
        logFN, 
        ' >> ',
        commands.text.file
    )
    
    hpcString <- paste(hpcString, collapse = "")
    return(hpcString)
}

## Done cluster submission                                                   ##
###############################################################################

setGeneric(
    name="hpcClusterSubmission",
    def=function(obj){
           
    }
)


###############################################################################
# (4) create.trim.galore.shell.script                                         #
###############################################################################
setGeneric(
    name="createTrimGaloreShellScript",
    def=function(
        obj,
        scriptVecSlot = "scriptVec"
    ){
        tempShellScriptVector <- as.vector(NULL, mode = "character")
        ## Parameters ##
        FASTQ = unique(obj@dfDesign$sample.id)  
        obj@dfDesign$FASTQ <- obj@dfDesign$sample.id
        
        logdir = gsub("workdir", "logs", obj@parameterList$workdir)
    
        ## Create core script ##
        tempShellScriptVector <- c(
            tempShellScriptVector,
            "#!/bin/sh",
            "\n",
            "###############################################################################",
            "\n",
            "## Adapter- and Quality triming using trimgalore                             ##",
            "\n",
            "## Parameters:                                                               ##",
            "\n",
            paste0("## Minimum read length: ", obj@parameterList$TrimGaloreMinLength, "bp"),
            "\n",
            paste0("## Quality score cut-off: ", obj@parameterList$TrimGaloreMinQuality),
            "\n",
            "\n",
            paste0("if [ ! -d ",logdir," ]; then"),
            "\n",
            paste0("  mkdir ", logdir),
            "\n", 
            "fi",
            "\n",
            "\n",
            paste0(
                "project=", 
                obj@parameterList$project_id
            ),
            "\n",
            "\n",
            "#################################################################################",
            "\n",
            "##FUNCTIONS######################################################################",
            "\n",
            "#################################################################################",
            "\n",
            "\n",                                
            "wait_on_lsf() { ## wait on jobs{",
            "\n",
            "sleep 300",
            "\n",
            "n=`squeue --name=$project  | wc -l`",
            "\n",
            #cat('n=n-1');  cat('\n');
            "while [ $n -ne 1 ]",
            "\n", 
            "do",
            "\n",
            "n=`squeue --name=$project  | wc -l`",
            "\n",
            #cat('n=n-1');  cat('\n');
            "((z=$n-1))",
            "\n",
            "#number of running",
            "\n", 
            "echo \"$project jobs running: $z\"",
            "\n",
            "#number of pending",
            "\n", 
            "sleep 300",
            "\n",
            "done",
            "\n", 
            "}",
            "\n",
            "\n",
            "\n",                                
            "\n",  
            paste0("module load ",obj@parameterList$ModuleTrimGalore),
            "\n",
            "\n"
        )
        
        ## Removing this -a AGATCGGAAGAGC  should enable outodetection of adaptor
        
        if (obj@parameterList$paired.end){
            cmd.part1 = paste0("trim_galore -q ",obj@parameterList$TrimGaloreMinQuality," --paired --length ",obj@parameterList$TrimGaloreMinLength," -o ", obj@parameterList$fastqDir, " ")
            for (i in 1:length(FASTQ)){
                r1 = paste0(obj@parameterList$fastqDir, FASTQ[i], "_R1.fastq.gz")
                r2 = paste0(obj@parameterList$fastqDir, FASTQ[i], "_R2.fastq.gz")
                
                cmd = paste0(cmd.part1, r1, " ", r2)
                cmd1 = paste0(
                    "sbatch --time=12:00:00 --wrap '", 
                    cmd, 
                    "' --job-name=", 
                    obj@parameterList$project_id ,
                    " -c 1 --mem-per-cpu=7000 -o ", 
                    logdir, 
                    FASTQ[i], 
                    ".cutadapt.slurm >> commands.txt" 
                )
                
                cmd2 = paste0(
                    "echo '", 
                    cmd, 
                    "' >> commands.txt" 
                )
                
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    "## Running in paired-end mode",
                    "\n",
                    cmd1,
                    "\n",
                    cmd2,
                    "\n",
                    "echo '###################################################' >> commands.txt",
                    "\n",
                    "\n"
                )
                
                
            }
        } else {
            cmd.part1 = paste0("trim_galore -q ",obj@parameterList$TrimGaloreMinQuality," --length ",obj@parameterList$TrimGaloreMinLength," -o ", obj@parameterList$fastqDir, " ")
            for (i in 1:length(FASTQ)){
                r1 = paste0(
                    obj@parameterList$fastqDir, 
                    FASTQ[i], 
                    "_R1.fastq.gz"
                )
                
                cmd = paste0(
                    cmd.part1, 
                    r1
                )
                
                cmd1 = paste0(
                    "sbatch --time=12:00:00 --wrap '", 
                    cmd, 
                    "' --job-name=",
                    obj@parameterList$project_id ,
                    " -c 1 --mem-per-cpu=7000 -o ", 
                    logdir, 
                    FASTQ[i], 
                    ".cutadapt.slurm >> commands.txt" 
                )
                
                cmd2 = paste0(
                    "echo '", 
                    cmd, 
                    "' >> commands.txt" 
                )
                
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    "## Running in single-end mode",
                    "\n",
                    cmd1,
                    "\n",
                    cmd2,
                    "\n",
                    "\n",
                    "echo '###################################################' >> commands.txt",
                    "\n",
                    "\n"
                )
                
            }
            
        }
        
        
        ## Wait until all files are done ##
        tempShellScriptVector <- c(
            tempShellScriptVector,
            'wait_on_lsf',
            '\n',
            '\n'
        )
        
        ## Rename output files ##
        for (i in 1:length(FASTQ)){
            if (obj@parameterList$paired.end){
                r1 = paste0(obj@parameterList$fastqDir, FASTQ[i], "_trimgalore_R1.fastq.gz")
                r2 = paste0(obj@parameterList$fastqDir, FASTQ[i], "_trimgalore_R2.fastq.gz")
                tg.r1 = gsub(
                    "_R1.fastq.gz", 
                    "_R1_val_1.fq.gz", 
                    paste0(
                        obj@parameterList$fastqDir, 
                        FASTQ[i], 
                        "_R1.fastq.gz"
                    )
                )
                
                tg.r2 = gsub(
                    "_R2.fastq.gz", 
                    "_R2_val_2.fq.gz", 
                    paste0(
                        obj@parameterList$fastqDir, 
                        FASTQ[i], 
                        "_R2.fastq.gz"
                    )
                )
                
                cmd1 = paste0(
                    "mv ", 
                    tg.r1, 
                    " ", 
                    r1
                )
                
                cmd2 = paste0(
                    "mv ", 
                    tg.r2, 
                    " ", 
                    r2
                )
                
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    cmd1,
                    '\n',
                    cmd2,
                    '\n'
                )
            } else {
                r1 = paste0(
                    obj@parameterList$fastqDir, 
                    FASTQ[i], 
                    "_trimgalore_R1.fastq.gz"
                )
                
                tg.r1 = gsub(
                    "_R1.fastq.gz", 
                    "_R1_trimmed.fq.gz", 
                    paste0(
                        obj@parameterList$fastqDir, 
                        FASTQ[i], 
                        "_R1.fastq.gz"
                    )
                )
                
                cmd1 = paste0(
                    "mv ", 
                    tg.r1, 
                    " ", 
                    r1
                )
                tempShellScriptVector <- c(
                    tempShellScriptVector,
                    cmd1,
                    "\n"
                )
                
            }
            
            tempShellScriptVector <- c(
                tempShellScriptVector,
                "echo '###################################################' >> commands.txt",
                "\n",
                "###############################################################################",
                "\n"
            )
        }
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            "\n",
            "\n",
            "wait_on_lsf",
            "\n",
            "\n",
            "## End of adaptor- and quality triming script                                ##",
            "\n",
            "###############################################################################",
            "\n",
            "\n",
            "\n",
            "\n"
        )
        
        ## Write shell script to file ##
        #setwd(localWorkDir)
        
        # sink(paste0(project.code, ".trimgalore.script.sh"))
        
        #for (i in 1:length(tempShellScriptVector)){
        #    cat(tempShellScriptVector[i])
        #}
        
        #sink()
        #If created on a windows machine, don't forget to 
        #tr -d '\r' <X.cutadapt.script.sh> conv.x.cutadapt.script.sh
        
        ## Edit 20180305 ##
        #df.design[["FASTQ_trimgalore"]] = paste0(df.design$FASTQ, "_trimgalore")
        obj@dfDesign[["FASTQ_trimgalore"]] = paste0(obj@dfDesign$sample.id, "_trimgalore")
        
        result.list <- list(
            "obj" = obj,
            "ShellScriptVector" = tempShellScriptVector
        )
        #return(result.list)    
        obj <- add2vec(
            obj = obj,
            slot_name = scriptVecSlot,
            value = tempShellScriptVector
        )
            
    return(obj)
    }
)


## End of function                                                           ##
###############################################################################            



###############################################################################
# (6)create.alignment.shell.script                                            #
###############################################################################

setGeneric(
    name="createAlignmentShellScript",
    def=function(
        obj,
        scriptVecSlot = "scriptVec"){
    ###############################################################################
    #Create shell script for FASTQC and RSEM                                      #
    ###############################################################################
    #FASTCQ commands and parameters
    #load.fastqc.module   <- "module load FastQC/0.11.5-Java-1.8.0_92"
    fastqc.exe      <- "fastqc"
    FASTQC_option1  <- "--threads 8 " 
    
    if (obj@parameterList$stranded) {
        obj@parameterList$forward_prob = "--forward-prob 0.0"
    } else {
        obj@parameterList$forward_prob = "--forward-prob 0.5"
    }
    
    tempShellScriptVector <- as.vector(NULL, mode = "character")
    
    RSEMdir <- paste(
        obj@parameterList$workdir, 
        "RSEM", 
        sep=""
    )
    
    
    #Alignment to ensemble to pick up non-coding RNAs
    #refSeq.index = "/farm/home/patel35/GENOME/hg19/index/RSEM/refseq/19-02-15/hg19"
    FASTQ <- unique(obj@dfDesign[,obj@parameterList$AlignFASTQcolumn])
    sample.id <- unique(obj@dfDesign$sample.id)
    
    
    
    #Create design file
    #Start making a shell script that dispatches all samples for FASTQC and RSEM alignment
    setwd(obj@parameterList$localWorkDir)
    
    ## Begin creation of shell script vector ##
    tempShellScriptVector <-c(
        '#!/bin/sh',
        
        '\n',
        '\n',
        '###############################################################################',
        '\n',
        '## STAR Alignment to reference transcriptome                                 ##',
        '\n',
        '\n',
        '###############################################################################',
        '\n',
        '# Create required folders                                                     #',
        '\n',
        '###############################################################################',
        '\n',
        '\n',
        paste0("if [ ! -d ", RSEMdir," ]; then"), 
        '\n',
        paste0("    mkdir -p ", RSEMdir),
        '\n',
        'fi',
        '\n',
        '\n',
        
        paste0("if [ ! -d ", obj@parameterList$logDir," ]; then"), 
        '\n',
        paste0("    mkdir -p ", obj@parameterList$logDir),
        '\n',
        'fi',
        '\n',
        '\n',
        paste0("if [ ! -d ", obj@parameterList$FASTQCdir," ]; then"), 
        '\n',
        paste0("    mkdir -p ", obj@parameterList$FASTQCdir),
        '\n',
        'fi',
        '\n',
        '\n',
        paste0("if [ ! -d ", obj@parameterList$AlignOutputEnsDir," ]; then"), 
        '\n',
        paste0("    mkdir -p ", obj@parameterList$AlignOutputEnsDir),
        '\n',
        'fi',
        '\n',
        '\n',
        '\n'
    )
    
    if (obj@parameterList$paired.end){
        tempShellScriptVector <-c(
            tempShellScriptVector,
            "## Mode: Paired-end",
            '\n',
            '\n'
        )
    } else {
        tempShellScriptVector <-c(
            tempShellScriptVector,
            "## Mode: Single-end",
            '\n',
            '\n'
        )
    }
    
    for (i in 1:length(FASTQ)){
        sample.label  <- sample.id[i]
        ## QC using FASTQC
        if (obj@parameterList$paired.end){
            FQ.R1  = paste(FASTQ[i], "_R1.fastq.gz", sep="")
            FQ.R2  = paste(FASTQ[i], "_R2.fastq.gz", sep="")
            FASTQC.CMD.R1 <- paste(
                fastqc.exe, 
                " --outdir ",
                obj@parameterList$FASTQCdir," ", 
                FASTQC_option1, 
                obj@parameterList$fastqDir, 
                FQ.R1, 
                sep=''
            )
            
            FASTQC.CMD.R2 <- paste(
                fastqc.exe, 
                " --outdir ",
                obj@parameterList$FASTQCdir," ", 
                FASTQC_option1, 
                obj@parameterList$fastqDir, 
                FQ.R2, 
                sep=''
            )
            
            FASTQC.CMD.R1 <- paste(
                'sbatch --time=12:00:00 --wrap "', 
                FASTQC.CMD.R1, 
                '" --job-name=', 
                obj@parameterList$project_id,
                ' -c 1 --mem-per-cpu=7000 -o ',
                obj@parameterList$logDir, 
                "/", 
                FASTQ[i], 
                '_R1.fastqc.slurm >> commands.txt', 
                sep=''
            )
            
            FASTQC.CMD.R2 = paste(
                'sbatch --time=12:00:00 --wrap "', 
                FASTQC.CMD.R2, 
                '" --job-name=', 
                obj@parameterList$project_id,
                ' -c 1 --mem-per-cpu=7000 -o ',
                obj@parameterList$logDir,  "/", FASTQ[i], '_R2.fastqc.slurm >> commands.txt', 
                sep=''
            )
            
            
        } else {
            FQ.R = paste(FASTQ[i], "_R1.fastq.gz", sep="")  
            FASTQC.CMD.R <- paste(
                fastqc.exe, 
                " --outdir ",
                obj@parameterList$FASTQCdir,
                " ", 
                FASTQC_option1, 
                obj@parameterList$fastqDir, 
                FQ.R, 
                sep=''
            )
            
            FASTQC.CMD.R = paste(
                'sbatch --time=12:00:00 --wrap "', 
                FASTQC.CMD.R, 
                '" --job-name=', 
                obj@parameterList$project_id,
                ' -c 1 --mem-per-cpu=7000 -o ',
                obj@parameterList$logDir,
                sample.id[i], 
                '.fastqc.slurm >> commands.txt', 
                sep=''
            )
        }
        
        
        ## Prepare RSEM command ##
        ## Build RSEM base command ##
        temp     <- paste(
            "--temporary-folder ", 
            obj@parameterList$workdir, 
            "RSEM/Ensembl/", 
            sep=""
        )
        
        temp.folder	<- paste(
            temp, 
            sample.label, 
            "/temp/", 
            sep=""
        )
        
        RSEM.exe <- paste0(
            "rsem-calculate-expression ",
            temp.folder, " ",
            "--star ",
            "--num-threads 6 ",
            "--calc-ci", " ",
            "--ci-memory 10240 ",
            "--estimate-rspd ",
            "--seed 1 ",
            "--star-output-genome-bam ",
            "--star-gzipped-read-file ",
            obj@parameterList$forward_prob
        )
        
        mkdir     <- paste(
            obj@parameterList$AlignSampleDir,
            "/", sample.label, 
            sep=""
        )
        
        
        
        if (obj@parameterList$paired.end){
            input.fastq.files = paste0(
                obj@parameterList$AlignForwardProb," ",
                "--paired-end ", obj@parameterList$fastqDir, FQ.R1, " ", obj@parameterList$fastqDir, FQ.R2, " "
            )
        } else {
            input.fastq.files = paste0(
                obj@parameterList$AlignForwardProb," ",
                obj@parameterList$fastqDir, FQ.R, " ")  
        }
        
        
        RSEM.CMD <- paste(
            RSEM.exe, 
            input.fastq.files, 
            obj@parameterList$genomeIndex ," ",  
            obj@parameterList$AlignOutputEnsDir, sample.label, " > ", obj@parameterList$logDir, 
            sample.label, ".log", " ", "2>&1", sep=""
        )
        
        
        
        RSEM.CMD = paste(
            'sbatch --time=12:00:00 --wrap "',
            RSEM.CMD, 
            '" --job-name=', 
            obj@parameterList$project_id, 
            ' -c 12 --mem-per-cpu=7000 -o ',
            obj@parameterList$logDir,
            sample.id[i], 
            '.RSEM.slurm >> commands.txt', 
            sep=''
        )
        
        tempShellScriptVector <-c(
            tempShellScriptVector,
            '###############################################################################',
            '\n',
            paste(
                "# Start", 
                sample.id[i], 
                "-submission                                                  #", 
                sep=""
            ),
            '\n',
            '###############################################################################',
            '\n',
            '\n',
            paste0("if [ ! -d ", mkdir," ]; then"), 
            '\n',
            paste0("    mkdir -p ", mkdir),
            '\n',
            'fi',
            '\n',
            '\n',
            '\n',
            '## FASTQC ##',
            '\n',
            obj@parameterList$ModuleFASTQC,
            '\n',
            '\n'
        )
        
        
        if (obj@parameterList$paired.end){
            tempShellScriptVector <-c(
                tempShellScriptVector,
                FASTQC.CMD.R1,
                '\n'
            )
            
            
        } else {
            tempShellScriptVector <-c(
                tempShellScriptVector,
                FASTQC.CMD.R,
                '\n'
            )
        }
        
        tempShellScriptVector <-c(
            tempShellScriptVector,
            '\n',
            '## RSEM-STAR ##',
            '\n',
            'module load Perl/5.24.0-foss-2016b',
            '\n',
            'module load RSEM/1.3.0-foss-2016b',
            '\n',
            'module load STAR/2.5.2a-foss-2016b',
            '\n',
            '\n',
            #cat('module load Bowtie2/2.2.9-foss-2016b'); cat('\n');cat('\n');
            RSEM.CMD,
            '\n',
            '\n'
        )
    } #End of shell script loop for one sample
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        "## End of FASTQC and alignment script                                        ##",
        "\n",
        "###############################################################################",
        "\n",
        "\n",
        "\n",
        "\n",
        "##wait on jobs",
        "\n",
        "wait_on_lsf",
        "\n",
        "# Feature to be activated",
        "\n",
        "module load RSEM/1.2.31-foss-2016b",
        "\n"
    )
    
    ## Create RSEM part ##
    obj@parameterList$RSEMcountDataFile <- paste0(
        obj@parameterList$project_id, 
        ".count.data.txt"
    )
    
    samples = as.vector(
        unique(
            obj@dfDesign$sample.id
        )
    )
    
    files <- paste(
        obj@parameterList$workdir, 
        "RSEM/Ensembl/", 
        samples, 
        ".genes.results", 
        sep=""
    )
    
    files = paste(
        files, 
        collapse = " "
    )
    
    RSEM.CMD = paste(
        "rsem-generate-data-matrix ", 
        files, 
        " > ./RSEM/", 
        obj@parameterList$RSEMcountDataFile, 
        sep=""
    )
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        "## RSEM Create data matrix ##",
        "\n",
        RSEM.CMD,
        "\n"
    )
    
    ## Done creating shell script line vector ##
    
    #sink(
    #    paste0(
    #        project.code,
    #        ".create.fastq.and.rsem.cmds.for.all.samples.sh"
    #    )
    #)
    
    #for (i in 1:length(tempShellScriptVector)){
    #    cat(tempShellScriptVector[i])
    #}
    
    
    #sink();
    #returnList <- list(
    #    "obj" = obj,
    #    "shellScriptVector" = tempShellScriptVector
    #)
    
    obj <- add2vec(
        obj = obj, 
        slot_name = scriptVecSlot,
        value = tempShellScriptVector
    )
    
    return(obj)
    }
)
## End of function ############################################################
###############################################################################

###############################################################################
# (5) create.rnaseqc.script                                                   #
###############################################################################
create.rnaseqc.script <- function(
    df.design,
    sample.column = "sample.id",
    project.code = "p103",
    project="SB_RNAseqQC",
    basedataDir="/camp/stp/babs/working/boeings/Projects/103_VTL_ES_RNA_seq_BAFF_timecourse_hs/workdir/RSEM/Ensembl",
    bam.suffix = "STAR.genome.bam",
    GTFfile="/camp/stp/babs/working/data/genomes/homo_sapiens/ensembl/GRCh38/release-86/gtf/Homo_sapiens.GRCh38.86.rnaseqc.gtf",
    rRNAfile="/camp/stp/babs/working/data/genomes/homo_sapiens/ensembl/GRCh38/release-86/gtf/Homo_sapiens.GRCh38.86.rRNA.list",
    genome.fa="/camp/stp/babs/working/data/genomes/homo_sapiens/ensembl/GRCh38/release-86/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa",
    refFlatFile="",
    ribosomalIntervalList="",
    bedFile="",
    paired.end = FALSE,
    strandSpecific = TRUE
){
    tempShellScriptVector <- as.vector(NULL, mode = "character")
    
    if (strandSpecific){
        strandedness<- "SECOND_READ_TRANSCRIPTION_STRAND"
    } else {
        strandedness<- "NONE"
    }
    ## Order samples so that sortin is > condition > sample.group > sample.id
    #df.design <- df.design[order(df.design$dataseries, df.design$sample.group, df.design$sample.id),]
    
    samples = as.vector(
        unique(
            df.design[,sample.column]
        )
    )
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '#!/bin/sh',
        '\n',
        '#Copy this shell script into the project directory and run it from there.', 
        '\n',
        '#################################################################################', 
        '\n',
        '##Create log directory ##########################################################', 
        '\n',
        'if [ ! -d logs ]; then',
        '\n',
        '  mkdir logs',
        '\n',
        'fi',
        '\n',
        '\n',
        '#################################################################################', 
        '\n',
        '###VARIABLES#####################################################################', 
        '\n',
        '#################################################################################', 
        '\n',
        paste0('project="', project, '"'), 
        '\n',
        'projectID=""', 
        '\n',
        '#Path to the directory with the BAM files', '\n',
        '#FASTQ files have to be named [sample_name_as_given_in_samples_below]_R1.fastq.gz or [sample_name_as_given_in_samples_below]_R2.fastq.gz', '\n',
        paste0('alignDir="', basedataDir, '"'), '\n', 
        paste0('GTFfile="', GTFfile, '"'), '\n',
        #paste0('GTFfile_RNASeQC="', GTFfile.RNASeQC, '"'), '\n',
        paste0('rRNAfile="', rRNAfile, '"'), 
        '\n',
        '\n',
        paste0('samplesuffix="',bam.suffix,'"'),
        '\n',
        '\n',
        paste0('genome_fa="',genome.fa,'"'),  '\n'
    )
    
    for (i in 1:length(samples)){
        if (i ==1){
            tempShellScriptVector <- c(
                tempShellScriptVector,
                paste0('samples="',  samples[i]) 
            )
        } else {
            tempShellScriptVector <- c(
                tempShellScriptVector,
                '\n', samples[i] 
            )
        }
    }
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '"',  '\n',           
        '\n',                                
        '\n',                              
        '#################################################################################',  '\n',
        '##FUNCTIONS######################################################################',  '\n',
        '#################################################################################',  '\n', 
        '\n',                                
        'wait_on_lsf() { ## wait on jobs{',  '\n',
        'sleep 300',  '\n',
        'n=`squeue --name=$project  | wc -l`',  '\n',
        #'n=n-1',  
        '\n',
        'while [ $n -ne 1 ]',  '\n',
        'do',  '\n',
        'n=`squeue --name=$project  | wc -l`',  '\n',
        #'n=n-1',  
        '\n',
        '((z=$n-1))',  '\n',
        '#number of running',  '\n',
        'echo "$project jobs ($projectID) running: $z"',  
        '\n',
        '#number of pending',  '\n',
        'sleep 300',  '\n', 
        'done',  '\n',
        '}', '\n',
        '\n',
        '\n',                             
        '\n',                                
        '## End of function                                                             ##', '\n',
        '#################################################################################', '\n',
        '\n', '\n',                                
        
        '#################################################################################', '\n',
        '# Prere bam files for RNASeQC                                                   #', '\n',
        '#################################################################################', '\n',
        '#################################################################################', '\n',
        '# AddOrReplaceReadGroups                                                        #', '\n',
        '#################################################################################', '\n','\n',
        'projectID="AddOrReplaceReadGroups"', '\n',
        'module load R/3.3.1-foss-2016b-bioc-3.3-libX11-1.6.3', '\n','\n',
        'echo "module load R/3.3.1-foss-2016b-bioc-3.3-libX11-1.6.3" >> commands.txt', '\n',
        'module load picard/2.1.1-Java-1.8.0_112', '\n','\n',
        'echo "module load picard/2.1.1-Java-1.8.0_112" >> commands.txt', '\n',
        'echo "redo headers on Tophat bam output"', '\n',
        'echo "#Submitted jobs" >> commands.txt ', '\n',
        '#projectID="headers"', '\n',
        'for sample in $samples', '\n',
        '   do ', '\n',
        '      echo "java -jar ${EBROOTPICARD}/picard.jar AddOrReplaceReadGroups \\', '\n',
        '      I=${alignDir}/${sample}.${samplesuffix} \\', '\n',
        '      O=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
        '      RGID=$sample \\', '\n',
        '      RGCN=CCCB \\', '\n',
        '      RGLB=lib1 \\', '\n',
        '      RGPL=ILLUMINA \\', '\n',
        '      RGPU=NA \\', '\n',
        '      RGSM=accepted_hits.bam" >> commands.txt', '\n',
        '      sbatch --time=12:00:00 --wrap "java -jar ${EBROOTPICARD}/picard.jar AddOrReplaceReadGroups \\', '\n',
        '      I=${alignDir}/${sample}.${samplesuffix} \\', '\n',
        '      O=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
        '      RGID=$sample \\', '\n',
        '      RGCN=TheFrancisCrickInstitute \\', '\n',
        '      RGLB=lib1 \\', '\n',
        '      RGPL=ILLUMINA \\', '\n',
        '      RGPU=NA \\', '\n',
        '      RGSM=accepted_hits.bam" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.addorreplacereadgroups.slurm >> commands.txt ', '\n',
        '   done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n', '\n',                                
        '#################################################################################', '\n',
        '# SortSam                                                                       #', '\n',
        '#################################################################################', '\n', '\n',
        'projectID="SortSam"', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'echo "SortSam co-ordinate sort" >>  commands.txt', '\n',
        'echo "SortSam output"', '\n',
        '#projectID="coordinate_sort"', '\n',
        'for sample in $samples', '\n',
        '   do', '\n',
        '      echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar SortSam \\', '\n',
        '      I=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
        '      O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
        '      SO=coordinate \\', '\n',
        '      TMP_DIR=\'pwd\'/tmp" >> commands.txt ', '\n',
        
        '      sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar SortSam \\', '\n',
        '      I=${alignDir}/${sample}.accepted_hits.readgroups.bam \\', '\n',
        '      O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
        '      SO=coordinate \\', '\n',
        '      TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.sortsam.slurm >> commands.txt ', '\n',
        '   done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n',                                
        'for sample in $samples', '\n',
        'do', '\n',
        'echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.bam" >> commands.txt  ', '\n',
        'rm ${alignDir}/${sample}.accepted_hits.readgroups.bam  ', '\n',
        'done', '\n',
        '\n',                                
        
        '#################################################################################', '\n',
        '# Reorder SAM                                                                   #', '\n',
        '#################################################################################', '\n', '\n',
        'projectID="ReorderSam"', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'echo "reorder reads to match contigs in the reference" >> commands.txt', '\n',
        'echo "Reorder reads to match contigs in the reference"', '\n',
        'for sample in $samples', '\n',
        'do	', '\n',
        'echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar ReorderSam \\', '\n',
        'I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
        'O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
        'REFERENCE=${genome_fa} \\', '\n',
        'TMP_DIR=\'pwd\'/tmp" >> commands.txt ', '\n',
        '\n',                                  
        'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar ReorderSam \\', '\n',
        'I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam \\', '\n',
        'O=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
        'REFERENCE=${genome_fa} \\', '\n',
        'TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.reordersam.slurm >> commands.txt ', '\n',
        '\n',                                
        'done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n',                                
        'for sample in $samples', '\n',
        '   do', '\n',
        '      echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam" >> commands.txt', '\n',
        '      rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.bam', '\n',
        '   done', '\n',
        '\n',                              
        '#################################################################################', '\n',
        '# MarkDuplicates                                                                #', '\n',
        '#################################################################################', '\n', '\n',
        'projectID="MarkDuplicates"', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'projectID="markdups"', '\n',
        'echo "mark duplicates" >> commands.txt', '\n',
        'echo "mark duplicates"', '\n',
        '   for sample in $samples', '\n',
        '      do', '\n',	
        '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar MarkDuplicates \\', '\n',
        '         I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
        '         O=${alignDir}/${sample}.d.bam \\', '\n',
        '         METRICS_FILE=${alignDir}/${sample}/dup_metrics.txt \\', '\n',
        '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
        '\n',                                
        '         sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar MarkDuplicates \\', '\n',
        '         I=${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam \\', '\n',
        '         O=${alignDir}/${sample}.d.bam \\', '\n',
        '         METRICS_FILE=${alignDir}/${sample}/dup_metrics.txt \\', '\n',
        '         TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.markduplicates.slurm >> commands.txt ', '\n',
        '      done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n',                                
        '##############################', '\n',
        'for sample in $samples', '\n',
        '   do', '\n',
        '      echo "rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam" >> commands.txt', '\n',
        '      rm ${alignDir}/${sample}.accepted_hits.readgroups.sorted.reordered.bam', '\n',
        '   done', '\n',
        '#################################################################################', '\n',
        '# Samtool indexing                                                              #', '\n',
        '#################################################################################', '\n','\n',
        'projectID="Samtool indexing"', '\n',
        'module load SAMtools/1.3.1-foss-2016b', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'echo "module load SAMtools/1.3.1-foss-2016b" >> commands.txt', '\n',
        'echo "Samtool Indexing "', '\n',
        'for sample in $samples', '\n',
        '   do', '\n',	
        '      echo "samtools index ${alignDir}/${sample}.d.bam" >> commands.txt', '\n',
        '      sbatch --time=12:00:00 --wrap "samtools index ${alignDir}/${sample}.d.bam" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.samtools.index.slurm >> commands.txt ', '\n',
        '   done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n'
    )                     
    
    ###########################################################################
    ## Add rnaseq metrics                                                    ##
    if (refFlatFile != "" & ribosomalIntervalList != ""){
        
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '#################################################################################', '\n',
            '# Run CollectRnaSeqMetrics                                                      #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="CollectRnaSeqMetrics"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'projectID="CollectRnaSeqMetrics"', '\n',
            'echo "CollectRnaSeqMetrics" >> commands.txt', '\n',
            'echo "CollectRnaSeqMetrics"', '\n',
            '   for sample in $samples', '\n',
            '      do', '\n',	
            '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar CollectRnaSeqMetrics \\', '\n',
            '           I=${alignDir}/${sample}.d.bam \\', '\n',
            '           O=${alignDir}/${sample}.output.RNA_Metrics \\', '\n',
            paste0('           REF_FLAT=',refFlatFile,' \\'), '\n',
            paste0('           STRAND=',strandedness,' \\'), '\n',
            paste0('           RIBOSOMAL_INTERVALS=',ribosomalIntervalList,' \\'), '\n', 
            '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
            '\n',
            '\n',
            'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar CollectRnaSeqMetrics \\', '\n',
            '           I=${alignDir}/${sample}.d.bam \\', '\n',
            '           O=${alignDir}/${sample}.output.RNA_Metrics \\', '\n',
            paste0('           REF_FLAT=',refFlatFile,' \\'), '\n',
            paste0('           STRAND=',strandedness,' \\'), '\n',
            paste0('           RIBOSOMAL_INTERVALS=',ribosomalIntervalList,' \\'), '\n', 
            '           TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.rnaseqmetrics.slurm >> commands.txt ', '\n',
            '\n',
            '\n',
            '      done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            '\n'
            
        )
        
    }
    ## End rnaseq metrics                                                    ##
    ###########################################################################
    
    ###########################################################################
    ## Estimate library complexity                                           ##
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '#################################################################################', '\n',
        '# Run Estimate Library Complexity                                               #', '\n',
        '#################################################################################', '\n', '\n',
        'projectID="EstimateLibraryComplexity"', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'projectID="EstimateLibraryComplexity"', '\n',
        'echo "EstimateLibraryComplexity" >> commands.txt', '\n',
        'echo "EstimateLibraryComplexity"', '\n',
        '   for sample in $samples', '\n',
        '      do', '\n',	
        '         echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar EstimateLibraryComplexity \\', '\n',
        '           I=${alignDir}/${sample}.d.bam \\', '\n',
        '           O=${alignDir}/${sample}.est_lib_complex_metrics.txt \\', '\n',
        '         TMP_DIR=\'pwd\'/tmp" >> commands.txt', '\n',
        '\n',
        '\n',
        'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTPICARD}/picard.jar EstimateLibraryComplexity \\', '\n',
        '           I=${alignDir}/${sample}.d.bam \\', '\n',
        '           O=${alignDir}/${sample}.est_lib_complex_metrics.txt \\', '\n',
        '           TMP_DIR=\'pwd\'/tmp" --job-name=$project -c 2 --mem-per-cpu=7000 -o logs/$sample.estimatelibrarycomplexity.slurm >> commands.txt ', '\n',
        '\n',
        '\n',
        '      done', '\n',
        '##wait on jobs', '\n',
        'wait_on_lsf', '\n',
        '\n',                                
        '\n'
        
    )
    
    
    ## Done estimating library complexity                                    ##
    ###########################################################################
    
    ###########################################################################
    ## Add infer experiment                                                  ##
    if (bedFile != ""){
        
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '#################################################################################', '\n',
            '# Run RNASeQC Infer_experiment                                                  #', '\n',
            '#################################################################################', '\n', '\n',
            'projectID="Infer_experiment"', '\n',
            'echo "###########################################################################################" >>  commands.txt', '\n',
            'projectID="Infer_experiment"', '\n',
            'echo "Infer_experiment" >> commands.txt', '\n',
            'echo "Infer_experiment"', '\n',
            'module purge;','\n',
            'module load RSeQC/2.6.4-foss-2016b-Python-2.7.12-R-3.3.1;', '\n',
            '   for sample in $samples', '\n',
            '      do', '\n',	
            paste0(
                'echo "infer_experiment.py -r ',
                bedFile,
                ' -i ${alignDir}/${sample}.d.bam > ${alignDir}/${sample}.infer_experiment.txt"  >> commands.txt \\'
            ), 
            '\n',
            '\n',
            paste0('sbatch --time=12:00:00 --wrap "infer_experiment.py -r ',
                   bedFile,
                   ' -i ${alignDir}/${sample}.d.bam > ${alignDir}/${sample}.infer_experiment.txt" --job-name=$project -c 1 --mem-per-cpu=7000 -o logs/$sample.infer_experiment.slurm >> commands.txt '
            ), 
            '\n', 
            '      done', '\n',
            '##wait on jobs', '\n',
            'wait_on_lsf', '\n',
            '\n',                                
            '\n'
            
        )
        
    }
    ## End rnaseq metrics                                                    ##
    ###########################################################################
    
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '#################################################################################', '\n',
        '# Run RNASeqC                                                                   #', '\n',
        '#################################################################################', '\n','\n',
        'projectID="RNAseQC"', '\n',
        'echo "###########################################################################################" >>  commands.txt', '\n',
        'module load RNA-SeQC/1.1.8-Java-1.7.0_80', '\n', '\n',
        'echo "module load RNA-SeQC/1.1.8-Java-1.7.0_80" >> commands.txt', '\n',
        'echo "make RNASeqC sample list"', '\n',
        'cd ${alignDir}', '\n',
        '\n',                                
        'if [ ! -d ${projectID} ]; then', '\n',
        '  mkdir ${projectID}', '\n',
        'fi', '\n',
        '\n',                                
        '\n',                              
        'echo "sample list" > ${alignDir}/${projectID}/sample.list', '\n',
        'for sample in $samples', '\n',
        'do', '\n',
        'echo -e "$sample\t${alignDir}/${sample}.d.bam\tNA" >>${alignDir}/${projectID}/sample.list', '\n',
        'done', '\n',
        '#wait', '\n', 
        '\n',                                
        'echo "run RNA-seqQC"', '\n',
        '\n',                                
        '#RNASeqQC requires Java version 1.7 and does not run on the most recent version. ', '\n',
        '\n',                               
        'echo "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTRNAMINSEQC}/RNA-SeQC_v1.1.8.jar \\', '\n'
    )
    
    if (!paired.end){
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '-singleEnd \\', '\n'
        )
    }
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        
        '-o ${alignDir}/${projectID}/ \\', '\n',
        '-r ${genome_fa} \\', '\n',
        '-s ${alignDir}/${projectID}/sample.list \\', '\n',
        '-t $GTFfile \\', '\n',
        '-gatkFlags \'-S SILENT -U ALLOW_SEQ_DICT_INCOMPATIBILITY\' \\', '\n',
        '-rRNA $rRNAfile " >> commands.txt', '\n',
        '\n',                                
        'sbatch --time=12:00:00 --wrap "java -Xmx10g -Djava.io.tmpdir=\'pwd\'/tmp -jar ${EBROOTRNAMINSEQC}/RNA-SeQC_v1.1.8.jar \\', '\n'
    )
    
    if (!paired.end){
        tempShellScriptVector <- c(
            tempShellScriptVector,
            '-singleEnd \\', '\n'
        )
    }
    tempShellScriptVector <- c(
        tempShellScriptVector,
        '-o ${alignDir}/${projectID}/ \\', '\n',
        '-r ${genome_fa} \\', '\n',
        '-s ${alignDir}/${projectID}/sample.list \\', '\n',
        '-t $GTFfile \\', '\n',
        '-gatkFlags \'-S SILENT -U ALLOW_SEQ_DICT_INCOMPATIBILITY\' \\', '\n',
        '-rRNA $rRNAfile " --job-name=$project -c 1 --mem-per-cpu=7000 -o ${alignDir}/rnaseqc.slurm >> ${alignDir}/commands.txt ', '\n',
        '\n',
        '\n',
        'wait_on_lsf',
        '\n',
        'module purge; module use /camp/stp/babs/working/software/modules/all; module load multiqc/1.3-2016b-Python-2.7.12',
        '\n',
        paste0("multiqc ", workdir),
        '\n',
        '#end of file', '\n'
    )
    
    sink(paste0(project.code, '.rnaseqc.script.sh'))
    for (i in 1:length(tempShellScriptVector)){
        cat(tempShellScriptVector[i])
    }
    sink()                                  
    
    return(tempShellScriptVector)
}                                  

###############################################################################
#End Create RNASeqQC script                                                   #                                
###############################################################################  


###############################################################################
## (7b) createbulkRNASeqAnalysisBashScripts                                  ##

createbulkRNASeqAnalysisBashScripts <- function(
    obj = "biologic object",
    scriptVecSlot = "scriptVec"
    
){
    ###############################################################################
    ## Create shell script to rename files                                       ##
    tempShellScriptVector <- as.vector(NULL, mode = "character")
    tempShellScriptVector <- c(
        tempShellScriptVector,
        "###############################################################################",
        "\n",
        "## Creating softlinks for fastq files in ASF seq storage                     ##",
        "\n"
    )
    
    for (i in 1:nrow(obj@dfDesign)){
        string <- paste0(
            "ln -s ",
            obj@dfDesign$original.NGS[i],
            " ",
            obj@dfDesign$NGS[i]
        )
        
        tempShellScriptVector <- c(
            tempShellScriptVector,
            string,
            "\n"
        )
    }
    
    tempShellScriptVector <- c(
        tempShellScriptVector,
        "## Done creating softlinks to ASF seq storage                                ##",
        "\n",
        "###############################################################################",
        "\n",
        "\n",
        "\n",
        "\n"
    )
    
    
    ## Write to shell script ##
    # setwd(obj@parameterList$localWorkDir)
    # sink("create.fastq.softlinks.sh")        
    
    #for (i in 1:length(tempShellScriptVector)){
    #    cat(tempShellScriptVector[i])
    #}
    
    #sink()
    
    ## Add to overall shell script documentation
    
    ## Remove end of line characters ##
    #print("Remove end of line characters: tr -d '\r' <create.fastq.softlinks.sh> conv.create.fastq.softlinks.sh")
    ## Run ##
    #print("sh conv.create.fastq.softlinks.sh")
    
    # awk '{ sub("\r$", ""); print }' windows.txt > unix.txt
    #awk 'sub("$", "\r")' unixfile.txt > winfile.txt
    
    ###############################################################################
    ## Create strings for documentation                                          ##
    ## fastq folder                                                              ##
    ## Create documentation module here                                          ##
    value <- c(
        paste0(
            "FASTQ file location:", 
            unlist(obj@parameterList$pathToSeqStorageFolder)
        ),   
        "FASTQ file names:",
        obj@dfDesign$original.NGS,
        "",
        "Project FASTQ file names:", 
        obj@dfDesign$NGS,
        ""
    )
    
    obj <- add2vec(
        obj = obj,
        slot_name = "documentationVector",
        value = value
    )
    
  
    
    
    
    if (obj@parameterList$paired.end){
        value <- c(
            value,
            "Alignment mode: paired-end"
        )
       
    } else {
        value <- c(
            value,
            "Alignment mode: single-end"
        )
    }
    
    if (obj@parameterList$stranded){
        value <- c(
            value,
            "This is a stranded dataset"
        )
        
        
    } else {
        value <- c(
            value,
            "This is not a stranded dataset"
        )
        
    }
    
    value <- c(
        value,
        paste0("Reference genome/transcriptome: ",
               obj@parameterList$genome,
               "-", 
               obj@parameterList$release
        )
    )
    
    
    obj <- add2vec(
        obj,
        slot_name = "documentationVector",
        value = value
    )
    
    ###########################################################################
    ## Temporary adding tempshell script vec                                 ##
    
    obj <- add2vec(
        obj = obj, 
        slot_name = scriptVecSlot,
        value = tempShellScriptVector
    )
    
    tempShellScriptVector <- ""
    
    ## Add here: automated creation of powerpoint slide.
    ## Powerpoint slides to be generated:
    ## Documentation slide
    ## MA plot for each comparison slide
    ## PCA plot slide
    ## Heatmap slide
    ## Sample names/specifications slide
    ## Cluster dendrogram slide
    ## RNASeqQC slide
    
    ## End create strings for documentation                                      ##
    ###############################################################################
    
    ###############################################################################
    # Create trim galore shell script                                             #
    ###############################################################################
    obj <- createTrimGaloreShellScript(
        obj = obj 
    )
    
    # If this shell script is created on a windows machine, don't forget to remove the end of line '\r' characters
    #print(
    #    paste0(
    #        "tr -d '\r' <", 
    #        project.code, 
    #        ".trimgalore.script.sh> conv.", 
    #        project.code, 
    #        ".trimgalore.script.sh"
    #    )
    #)
    
    
    # Write dfDesign to file so it can be re-read once the alignment is done
    # setwd(localWorkDir)
    # write.table(dfDesign, design.file, row.names= FALSE, sep="\t")
    
    
    ###############################################################################
    # Align                                                                       #
    ###############################################################################
    obj <- createAlignmentShellScript(
        obj = obj
    )
    
    # If this shell script is created on a windows machine, don't forget to remove the end of line '\r' characters
    # print(
    #     paste0(
   
    
    ###############################################################################
    # Prepare RNAseQC script                                                      #
    ###############################################################################
    obj <- createRNAseqQCscript(
        obj = obj,
        bamSuffix = "STAR.genome.bam",
        scriptVecSlot = "scriptVec"
    )
    
    
    
    # If this shell script is created on a windows machine, don't forget to remove the end of line '\r' characters
    # print(
    #     paste0(
    #         "tr -d '\r' <", 
    #         project.code, 
    #         ".rnaseqc.script.sh> conv.", 
    #         project.code, 
    #         ".rnaseqc.script.sh"
    #     )
    # )
    
    ## Add to shell script documentation vector ##
    
    ###############################################################################
    ## Produce shell script                                                      ##
    
    fn <- paste0(
        obj@parameterList$localWorkDir,
        obj@parameterList$project_id,
        ".documentationShell.script.sh"
    )
    
    sink(fn)
    
    scriptVec <- slot(obj, "scriptVec")
    for (i in 1:length(scriptVec)){
        cat(scriptVec[i])
    }
    
    sink()
    
    ## use http://hilite.me/ for code conversion and display in script.php
    
    ## Done producing documentatin shell script                                  ##
    ###############################################################################
    
    print("If the script was created on a Windows machine remove end of line characters by running:")
    print(
        paste0(
            "tr -d '\r' <",obj@parameterList$project_id,".documentationShell.script.sh> conv.",obj@parameterList$project_id,".documentationShell.script.sh"
        )
    )
    
    #returnList <- list(
    #    "dfDesign" = dfDesign,
    #    "shellScriptVector" = shellScriptVector,
    #    "documentationVector" = documentationVector
    #)
    
    return(obj)
}

## End (7b) create createbulkRNASeqAnalysisBashScripts                       ##
###############################################################################

###############################################################################
# (7) Create tpm and fpkm value tables                                        #
###############################################################################
create.tpm.and.fpkm.tables <- function(
    workdir, 
    samples,
    files){
    for (i in 1:length(files)) {
        df.temp = read.delim(
            files[i], 
            header=TRUE, 
            sep="\t", 
            stringsAsFactors = FALSE
        )
        df.temp.tpm = df.temp[,c("gene_id", "TPM")]
        df.temp.fpkm = df.temp[,c("gene_id", "FPKM")]
        names(df.temp.tpm)[2] = paste(
            samples[i], 
            names(df.temp.tpm)[2], 
            sep="_"
        )
        
        names(df.temp.fpkm)[2] = paste(
            samples[i], 
            names(df.temp.fpkm)[2], 
            sep="_"
        )
        
        if (i > 1){
            df.tpm = merge(
                df.tpm, 
                df.temp.tpm, 
                by.x = "gene_id", 
                by.y = "gene_id", 
                all=TRUE
            )
            
            df.fpkm = merge(
                df.fpkm, 
                df.temp.fpkm, 
                by.x = "gene_id", 
                by.y = "gene_id", 
                all=TRUE
            )
        } else {
            df.tpm = df.temp.tpm
            df.fpkm = df.temp.fpkm
        }
    }
    
    ## Make numeric ##
    df.tpm[,grep("TPM", names(df.tpm))] <- apply(df.tpm[,grep("TPM", names(df.tpm))],2,as.numeric)
    df.fpkm[,grep("FPKM", names(df.fpkm))] <- apply(df.fpkm[,grep("FPKM", names(df.fpkm))],2,as.numeric)
    
    list.tpm.fpkm = list(df.tpm = df.tpm, df.fpkm=df.fpkm)
    return(list.tpm.fpkm)
}

## End of function                                                           ##
############################################################################### 

###############################################################################
# (8a) readAndPrepareCountMatrix                                              #
###############################################################################
readAndPrepareCountMatrix <- function(
    count.data.fn = 'paste0(raw.count.dir, "/",count.data.file)',
    string.to.be.deleted.in.raw.counts.columns = 'paste0("X", gsub("/", ".",paste0(workdir, "RSEM/Ensembl/")))',
    df.design = "dfDesign"
){
    ## Read raw counts file ##
    raw.counts <- read.delim(
        file=count.data.fn, 
        header=TRUE, 
        stringsAsFactors = FALSE
    )
    
    rownames(raw.counts) <- raw.counts[,1]
    raw.counts <- raw.counts[,2:ncol(raw.counts)]
    raw.counts <- round(raw.counts)
    colnames(raw.counts) <- gsub(
        ".genes.results", 
        "", 
        colnames(raw.counts)
    )
    
    colnames(raw.counts) <-  gsub(
        string.to.be.deleted.in.raw.counts.columns, 
        "", 
        colnames(raw.counts)
    )
    
    ## Reorder raw counts according to df.design ##
    raw.counts <- raw.counts[,unique(df.design$sample.id)]
    
    #reduce raw.counts table 
    #Filtering step was taken out, as DESeq2 does not require it
    raw.counts.filt = data.matrix(raw.counts)
    
    ## Transform raw.counts filt to integer ##
    rn <- row.names(raw.counts.filt)
    raw.counts.filt <- apply(
        raw.counts.filt, 
        2, 
        as.integer
    )
    
    row.names(raw.counts.filt) <- rn
    return(raw.counts.filt)
}


##                                                                           ##
###############################################################################


###############################################################################
## (46) selectHeatmapGenes()                                                 ##

selectHeatmapGenes <- function(
    dfData = "df.summary",
    selCol = "logFC",
    cutOff = 0.75,
    pSelCol = "padj",
    pCutOff = 1,
    zeroOneCol = "logFC_cut_off",
    geneID = "hgnc_symbol"
    
){
    dfData[[zeroOneCol]] <- 0
    cols <- names(dfData)[grep(selCol, names(dfData))]
    pCols <- names(dfData)[grep(pSelCol, names(dfData))]
    
    pos <- grep(zeroOneCol, cols)
    if (length(pos) > 0) {
        cols <- cols[-pos]
    }
    
    for (i in 1:length(cols)){
        
        if (pCutOff ==1){
            dfData[, zeroOneCol] <- ifelse(
                ((dfData[,cols[i]] > cutOff) | (dfData[,cols[i]] < -1*cutOff)),
                dfData[, zeroOneCol]+ 1,
                dfData[, zeroOneCol]+ 0
            )
        } else {
            dfData[, zeroOneCol] <- ifelse(
                ((((dfData[,cols[i]] > cutOff) | (dfData[,cols[i]] < -1*cutOff))) &
                     (dfData[,pCols[i]] < pCutOff)),
                dfData[, zeroOneCol]+ 1,
                dfData[, zeroOneCol]+ 0
            )
        }
    }
    
    dfData[dfData[,zeroOneCol] > 1,zeroOneCol] <- 1
    
    count <- nrow(
            unique(dfData[dfData[, zeroOneCol] > 0, c(zeroOneCol, geneID)])
        )
    
    
    print(paste0(count, " genes selected."))
    
    return(dfData)
    
}

## End of function (46)                                                      ##
###############################################################################

###############################################################################
## Make heatmap                                                              ##
###############################################################################
# Make heatmap function                                                       #
###############################################################################

make.hm <- function(
    m.df1, 
    filename = "heatmap", 
    k.number = 10, 
    n.colors = 1000, 
    hclust.method = "complete", 
    dist.method = "euclidean", 
    main = "",
    Colv = TRUE,
    showRowNames = FALSE,
    showColNames = TRUE,
    plotSeparationLines = FALSE
) {
    library(RColorBrewer)
    library(gplots)
    
    hclustfunc <- function(x) hclust(x, method = hclust.method)
    
    distfunc <- function(x) dist(x, method = dist.method)
    
    d <- distfunc(m.df1)
    
    fit <- hclustfunc(d)
    
    clusters <- cutree(fit, k = k.number)
    
    nofclust.height <- length(unique(as.vector(clusters)))
    
    a = max(abs(m.df1))
    
    breaks = seq((-1 * a), a, length.out = n.colors)
    
    
    ## Retired 20180228 ##
    #hmcols <- colorRampPalette(c("blue", "white", "red"))(n = (length(breaks) - 1))
    ## Start New:
    # blueWhiteRedVec <- rev(
    #    colorRampPalette(brewer.pal(9, "RdBu"))(3)
    # )
    
    blueWhiteRedVec <- c("#3060cf", "#fffbbc","#c4463a")
    
    hmcols <- colorRampPalette(
        blueWhiteRedVec
    )(n = (length(breaks) - 1))
    
    selcol <- colorRampPalette(brewer.pal(12, "Set3"))
    selcol2 <- colorRampPalette(brewer.pal(9, "Set1"))
    clustcol.height = selcol2(nofclust.height)
    
    if (filename != ""){
        pdf(
            paste(
                filename, 
                "pdf", 
                sep = "."
            )
        )
    }
    
    if (showRowNames){
        labRowVec = row.names(m.df1)
    } else {
        labRowVec = rep("", nrow(m.df1))
    }
    
    if (showColNames){
        labColVec = colnames(m.df1)
    } else {
        labColVec = rep("", length(colnames(m.df1)))
    }
    
    if (plotSeparationLines) {
        colsep = c(0: ncol(m.df1)) 
        rowsep = c(0: nrow(m.df1))
    } else {
        colsep = c(0, ncol(m.df1)) 
        rowsep = c(0, nrow(m.df1))
    }    
    
    hm = heatmap.2(
        m.df1, 
        trace = "none", 
        dendrogram = "both", 
        density.info = "none", 
        keysize = 1, 
        key = TRUE, 
        Colv = Colv, 
        hclust = hclustfunc, distfun = distfunc, col = hmcols, 
        symbreak = T, 
        labRow = labRowVec, 
        labCol = labColVec,
        RowSideColors = clustcol.height[clusters], 
        margins = c(10, 10), 
        cexCol = 1, 
        cexRow = 0.5, 
        srtCol = 45, 
        srtRow = 0, 
        main = main, 
        breaks = breaks, 
        sepcolor = "black", 
        sepwidth = c(5e-04, 5e-05), 
        colsep = colsep, 
        rowsep = rowsep
    )
    
    if (filename != ""){
        dev.off()
    }
    sorted = m.df1[
        match(
            rev(
                labels(hm$rowDendrogram)), 
            rownames(m.df1)
        ), 
        ]
    
    sorted = sorted[, hm$colInd]
    if (filename != ""){
        pdf(paste(filename, "colorkey.pdf", sep = "."))
    }
    plot.new()
    par(lend = 1)
    legend("topleft", legend = 1:nofclust.height, col = clustcol.height, 
           lty = 1, lwd = 10)
    if (filename != ""){
        dev.off()
    }
    df.res = list(sorted = sorted, clusters = clusters)
    return(df.res)
    #return(clusters)
}
## End make heatmap                                                          ##
###############################################################################

###############################################################################
## (1) Datatable.to.website.ptm                                              ##
###############################################################################

# df data input
# Requires a logFC mention in the contrast_X_ 
datatable.to.website.ptm <- function (
    df.data, 
    gene.id.column = "ENSMUSG", 
    heatmap.genes = "", #Relevant genes has to be the same id class as in gene.id.column
    n.cluster.genes = 6000, 
    count.data = FALSE, 
    logFC.cut.off = 0, # Either 0 or 1. If 1, then df.data needs to contain 
    # a logFC_cut_off column that is either 0 (exclude row in heatmap)
    # or 1 (include row in heatmap)
    
    selector4heatmap.cols = "logFC",
    heatmap.preprocessing = "lg2.row.avg", # possible: "lg2", "lg2.row.avg", "none"
    hm.cut.off = 4,
    n.hm.cluster = 10,
    count.cut.off.filter = 1
) {
    ###########################################################################
    ## Prepare data table                                                    ##
    
    # Remove all rows not featuring as an entry in the primary.gene.id.column
    df.data <- df.data[!is.na(df.data[, gene.id.column]), ]
    df.data                 <- unique(df.data)
    df.data[is.na(df.data)] <- ""
    
    # Enable filtering of low count rows
    
    if (length(grep("^count_cut_off$", names(df.data))) == 0 ){
        if (count.data){
            df.data[["count_cut_off"]] <- 0
            df.data[,"count_cut_off"]  <- rowSums(df.data[,grep("norm_counts", names(df.data))])
            df.data[,"count_cut_off"]  <- df.data[,"count_cut_off"]/length(grep("norm_counts", names(df.data)))
        } else {
            df.data[["count_cut_off"]] <- 5
        }
    }
    
    
    df.data <- df.data[df.data$count_cut_off > count.cut.off.filter,]
    
    df.data[["row_id"]]     <- paste(
        rep("R", nrow(df.data)), 
        1:nrow(df.data), 
        sep = ""
    )
    
    ## Calculate coeficient of variation based on norm_counts column for each row
    df.data["CoVar"] <- 0
    
    ## Ignore low-intesity rows ##
    df.data[df.data$count_cut_off > 1,"CoVar"] <- apply(
        df.data[df.data$count_cut_off > 1, grep("^norm_counts_", names(df.data))],
        1,
        function(x) sd(x)/mean(x)
    )
    
    df.data[is.na(df.data)] <- 0
    df.data[df.data$CoVar == Inf, "CoVar"] <- max(df.data[df.data$CoVar < Inf ,"CoVar"])
    
    
    # Order from highest to lowest CoVar
    df.data <- df.data[order(df.data$CoVar, decreasing = TRUE),]
    df.data[["CoVarOrder"]] <- 1:nrow(df.data)
    
    # Select columns for heatmaps and plot display
    
    df.lg2.row.avg.table <- df.data[, grep(selector4heatmap.cols, names(df.data))]
    
    row.names(df.lg2.row.avg.table) <- df.data[, "row_id"]
    
    ## Remove column handle from heatmap column ##
    if (length(grep("contrast_", names(df.lg2.row.avg.table))) > 0){
        names(df.lg2.row.avg.table) <- gsub("contrast_", "", names(df.lg2.row.avg.table))
        
        ## Remove contrast number ##
        names(df.lg2.row.avg.table)     <- substr(
            names(df.lg2.row.avg.table), 
            2, 
            100
        )
    } else if (length(grep("norm_counts_", names(df.lg2.row.avg.table))) > 0){
        names(df.lg2.row.avg.table) <- gsub(
            "norm_counts_", 
            "", 
            names(df.lg2.row.avg.table)
        )
    }
    
    ## Take care of double digit contrast numbers ##
    names(df.lg2.row.avg.table)  <- gsub(
        "^_", 
        "", 
        names(df.lg2.row.avg.table)
    )
    
    names(df.lg2.row.avg.table)     <- paste(
        "lg2_avg_", 
        names(df.lg2.row.avg.table), 
        sep = ""
    )
    
    # Ensure numericness
    df.lg2.row.avg.table[, grep("lg2_avg", names(df.lg2.row.avg.table))] <- apply(
        df.lg2.row.avg.table[, grep("lg2_avg", names(df.lg2.row.avg.table))], 
        2, 
        as.numeric
    )
    
    ## End df.lg2.row.avg.table creation for all rows                        ##
    
    ###########################################################################
    ## Create heatmap parameters and default selections                      ##
    
    # Data preprocessing accoring to selection #
    if (heatmap.preprocessing == "lg2"){
        for (i in 1:nrow(df.lg2.row.avg.table)) {
            df.lg2.row.avg.table[i, ] <- log2(df.lg2.row.avg.table[i,])
        }              
    } else if (heatmap.preprocessing == "lg2.row.avg"){
        # Calculate row means
        row_means <- rep(0, nrow(df.lg2.row.avg.table))
        
        for (i in 1:nrow(df.lg2.row.avg.table)){
            temp.row <- df.lg2.row.avg.table[i, grep("lg2_avg", names(df.lg2.row.avg.table))]
            temp.row <- temp.row[temp.row != 0]
            if (length(temp.row) > 0){
                row_means[i] <- mean(temp.row)
            }
        }
        
        ## Retired 20160621 ## Start ##
        #row_means <- apply(
        #    df.lg2.row.avg.table[, grep("lg2_avg", names(df.lg2.row.avg.table))], 1, mean
        #)
        ## Retired 20160621 ## End ##
        
        # Avoid devison by 0
        row_means[row_means == 0] <- 0.001
        for (i in 1:nrow(df.lg2.row.avg.table)) {
            df.lg2.row.avg.table[i, ] <- log2(df.lg2.row.avg.table[i,]/row_means[i])
            
        }
    } 
    
    # If 'none' or anything else is selected for heatmap processing, The values will be used as 'is' for 
    # the heatmap display
    ## Set all Infs to 0 ##
    df.lg2.row.avg.table[df.lg2.row.avg.table == Inf ] <- 0
    df.lg2.row.avg.table[df.lg2.row.avg.table == -Inf ] <- 0
    
    
    # Limit top/bottom values of heatmap display
    df.lg2.row.avg.table[df.lg2.row.avg.table > hm.cut.off] <- hm.cut.off
    df.lg2.row.avg.table[df.lg2.row.avg.table < (-1) * hm.cut.off] <- (-1) * hm.cut.off
    
    df.lg2.row.avg.table[, "row_id"] <- row.names(df.lg2.row.avg.table)
    df.data = merge(df.data, df.lg2.row.avg.table, by.x <- "row_id", by.y = "row_id")
    
    df.data = na.omit(df.data)
    row.names(df.data) = make.names(df.data[, "row_id"])
    
    
    ## Make gene selection for heatmap                                       ##
    # If the selection is provided in the heatmap.genes vector
    # these genes are used
    # Create logFC_cut_off column if not present in dataset
    if (length(grep("logFC_cut_off", names(df.data))) == 0){
        df.data[["logFC_cut_off"]] <- 0   
    }
    
    if (sum(df.data$logFC_cut_off) > 0){
        df.hm.sel <- df.data[df.data$logFC_cut_off == 1,]    
    } else {
        df.hm.sel <- df.data
    }
    
    
    if (heatmap.genes[1] == "" | is.na(heatmap.genes[1])){
        ## Select gene subset for heatmap based on coefficient of variation
        heatmap.genes <- as.vector(
            unique(
                df.hm.sel[,gene.id.column]
            )
        )
    } else {
        # Make sure all listed gene IDs are present in the dataset
        heatmap.genes <- heatmap.genes[heatmap.genes %in% df.hm.sel[,gene.id.column]]
    }
    
    # Done selecting heatmap genes #
    
    # Limiting number of genes for heatmap display accoring to specifications #
    ## Query logFC limitation ##
    
    # Limit based on Coeficient of variation #
    if (length(heatmap.genes) > n.cluster.genes){
        dfSel <- df.hm.sel
        #row.names(dfSel) <- NULL
        dfSel <- unique(dfSel[,c("CoVar", "CoVarOrder", gene.id.column)])
        dfSel <- dfSel[order(dfSel$CoVarOrder),]
        heatmap.genes <- as.vector(dfSel[,gene.id.column])[1:n.cluster.genes]
    }
    
    # Create df.cluster #
    if (sum(df.data$logFC_cut_off) > 0){
        df.cluster <- df.data[
            df.data[,gene.id.column] %in% heatmap.genes &
                df.data$logFC_cut_off == 1, 
            grep("lg2_avg", names(df.data))
            ]
    } else {
        df.cluster <- df.data[
            df.data[,gene.id.column] %in% heatmap.genes, 
            grep("lg2_avg", names(df.data))
            ]
    }
    
    
    ## Done selecting genes for heatmap                                          ##
    ###############################################################################
    
    ###############################################################################
    # Make heatmap function                                                       #
    ###############################################################################
    
    ## Function definition moved to package ##
    
    ## Flatening ##
    df.cluster[df.cluster > hm.cut.off] = hm.cut.off
    df.cluster[df.cluster < (-1) * hm.cut.off] = (-1) * hm.cut.off
    m.cluster = data.matrix(df.cluster)
    m.cluster[is.na(m.cluster)] = 0
    colnames(m.cluster) <- gsub("lg2_avg_", "", colnames(m.cluster))
    #m.cluster[m.cluster == 0] = 0.01
    
    ## Make col.sorted heatmap ##
    hm.res = make.hm(
        m.cluster, 
        filename = "heatmap.col.sorted", 
        k.number = n.hm.cluster, 
        n.colors = 20, 
        hclust.method = "ward.D2", 
        dist.method = "euclidean", 
        main = "",
        Colv = FALSE
    )
    
    ## Make col-clustered heatmap ##
    hm.res = make.hm(
        m.cluster, 
        filename = "heatmap.col.clustered", 
        k.number = n.hm.cluster, 
        n.colors = 20, 
        hclust.method = "ward.D2", 
        dist.method = "euclidean", 
        main = "",
        Colv = TRUE
    )
    
    ## Extract cluster order ##
    df.clust.order <- data.frame(hm.res$sorted)
    cluster.ordered.sample.vector <- names(df.clust.order)
    df.clust.order[["cluster_order"]] <- 1:nrow(df.clust.order)
    df.clust.order[, "row_id"] <- row.names(df.clust.order)
    df.clust.order <- df.clust.order[, c("row_id", "cluster_order")]
    
    ## Extract sample order ##
    df.sample.order <- hm.res$sorted
    sampleColClustOrder <- names(data.frame(df.sample.order))
    ## Re-order lg2_avg and norm_counts accordingly ##
    renameVec <- names(df.data)
    # Remove lg2_avg_entries #
    oldLog2AvgEntries <- names(df.data)[grep("lg2_avg", names(df.data))]
    newLog2AvgEntries <- paste0("lg2_avg_", sampleColClustOrder)
    
    if (sum(!(oldLog2AvgEntries %in% newLog2AvgEntries)) == 0){
        renameVec <- renameVec[!(renameVec %in% newLog2AvgEntries)]
        renameVec <- c(
            renameVec, 
            newLog2AvgEntries
        )
    }
    
    # Remove norm_counts #
    oldNormCountsEntries <- names(df.data)[grep("norm_counts_", names(df.data))]
    newNormCountsEntries <- paste0("norm_counts_", sampleColClustOrder)
    
    if (sum(!(oldNormCountsEntries %in% newNormCountsEntries)) == 0){
        renameVec <- renameVec[!(renameVec %in% newNormCountsEntries)]
        renameVec <- c(
            renameVec, 
            newNormCountsEntries
        )
    }
    
    ## Reorder columns in df.data ##
    if (sum(!(names(df.data) %in% renameVec)) == 0){
        df.data <- df.data[,renameVec]
    }
    
    ## Add to main data table ##
    remove <- as.vector(
        na.omit(
            match(
                df.clust.order[, "row_id"], 
                df.data[, "row_id"]
            )
        )
    )
    
    id.vector = as.vector(df.data[-remove, "row_id"])
    df.rest = data.frame(id.vector, rep(0, length(id.vector)))
    names(df.rest) = names(df.clust.order)
    df.clust.order = rbind(df.clust.order, df.rest)
    df.data = merge(df.data, df.clust.order, by.x = "row_id", 
                    by.y = "row_id")
    df.data = df.data[!is.na(df.data[, gene.id.column]), ]
    df.data = unique(df.data)
    
    # Add cluster id
    df.cluster.id <- data.frame(na.omit(hm.res$clusters))
    df.cluster.id[["row_id"]] <- row.names(df.cluster.id)
    names(df.cluster.id)<- c("cluster_id", "row_id")
    df.cluster.id <- df.cluster.id[grep("R", df.cluster.id$row_id),]
    # Adding all other ids
    row_id <- df.data[!(df.data$row_id %in% df.cluster.id$row_id), "row_id"]
    cluster_id <- rep(0, length(row_id))
    df.add <- rbind(df.cluster.id, data.frame(cluster_id, row_id))
    
    df.data <- merge(df.data, df.add, by.x = "row_id", by.y="row_id", all=TRUE)
    df.data[is.na(df.data)] = ""
    
    # # Add gene descripton
    # if (!exists("df.anno")){
    #     df.anno <- read.delim(
    #         gene.id.table,
    #         header = TRUE,
    #         sep = "\t",
    #         stringsAsFactors = FALSE
    #     )
    # }
    # 
    # # Remove all entries from df.anno that are not present in df.data
    # df.anno <- df.anno[df.anno[,gene.id.column] %in% df.data[,gene.id.column],]
    # if (!add.uniprot.column){
    #     df.anno$uniprot = NULL
    #     df.anno <- unique(df.anno)
    # }
    # 
    # df.anno <- unique(df.anno)
    # 
    # df.data <- merge(
    #     df.data, 
    #     df.anno, 
    #     by.x = gene.id.column, 
    #     by.y = gene.id.column, 
    #     all=TRUE
    # )
    # 
    # df.data[is.na(df.data)] = ""
    # df.data = unique(df.data)
    # 
    # if (gene.id.column == "mgi_symbol" | gene.id.column == "ENSMUSG") {
    #     ENSG <- "ENSMUSG"
    # } else if (gene.id.column == "hgnc_symbol" | gene.id.column == "ENSG") {
    #     ENSG <- "ENSG"
    # }
    # 
    # if (gene.id.column != "mgi_symbol" | gene.id.column != "hgnc_symbol"){
    #     df.data$gene_description <- paste0(
    #         df.data$gene_description,
    #         " (",
    #         df.data[,gene.id.column],
    #         ")"
    #     )
    # }
    
    ###########################################################################
    ## Deal with PTM datasets                                                ##
    if (length(grep("p_site_env", names(df.data))) > 0) {
        #Trim if the sequence window is to big
        length <- nchar(df.data$p_site_env)
        center <- ((length -1)/2)
        df.data$p_site_env <- ifelse(
            (length > 15),
            substr(df.data$p_site_env, center-6,center+8),
            df.data$p_site_env
        )
        
        one = tolower(substr(df.data$p_site_env, 1, 7))
        two = toupper(substr(df.data$p_site_env, 8, 8))
        three = tolower(substr(df.data$p_site_env, 9, 16))
        df.data$p_site_env = paste(one, two, three, sep = "")
        
        ################################################################################
        #Add ppos columns to datatable
        ################################################################################
        ppos.vec = c("ppos_minus_7","ppos_minus_6","ppos_minus_5","ppos_minus_4","ppos_minus_3","ppos_minus_2","ppos_minus_1","ppos",
                     "ppos_plus_1", "ppos_plus_2","ppos_plus_3","ppos_plus_4","ppos_plus_5","ppos_plus_6","ppos_plus_7")
        
        
        #In this dataset not all sequences are associated with an p_site_env
        #df.data[df.data$p_site_env == "", "p_site_env"] = substr(df.data[df.data$p_site_env == "", "sequence_window"], 9,23)
        
        for (i in 1:length(ppos.vec)){
            df.data[[ppos.vec[i]]] = sapply(
                df.data$p_site_env, 
                function(x) substr(x, i,i))
        }
        
        # Done adding ppos columns
    }
    ## Done dealing with PTM datasets                                        ##
    ###########################################################################
    
    df.data[is.na(df.data)] = ""
    df.data = unique(df.data)
    df.data = df.data[!is.na(df.data[, gene.id.column]), ]
    df.data[["row_names"]] = 1:nrow(df.data)
    names(df.data) = gsub("[.]", "_", names(df.data))
    names(df.data) = gsub(" ", "_", names(df.data))
    
    return(df.data)
}
## End of function                                                           ##
###############################################################################  

createAndFormatExcelOutputFiles <- function(
    obj,
    metaCoreCountFilter = 1,
    customOutputCols = NULL,
    addedOutputCols = NULL
){
    ###############################################################################
    ## Create Excel output table                                                 ##
    if (length(customOutputCols) > 0){
        outCols <- customOutputCols
    } else {
        outCols <- c(
            obj@parameterList$geneIDcolumn,
            obj@parameterList$primaryAlignmentGeneID,
            "gene_description",
            "gene_type",
            names(obj@databaseTable)[grep("contrast_", names(obj@databaseTable))],
            names(obj@databaseTable)[grep("norm_counts_", names(obj@databaseTable))],
            names(obj@databaseTable)[grep("raw_counts_", names(obj@databaseTable))],
            "count_cut_off", 
            "CoVar"
        )
    }
    
    if (length(addedOutputCols) > 0){
        outCols <- c(
            outCols, 
            addedOutputCols
        )
    }
    
    outCols <- outCols[outCols %in% names(obj@databaseTable)]
    
    dfOutput <- unique(obj@databaseTable[,outCols])
    
    ## Rename columns ##
    names(dfOutput) <- gsub("norm_counts_", "", names(dfOutput))
    comparisons <- names(obj@dfDesign)[grep("comp_", names(obj@dfDesign))]
    
    for (i in 1:length(comparisons)){
        names(dfOutput) <- gsub(
            paste0("contrast_", i, "_"), 
            "", 
            names(dfOutput)
        )
    }
    
    
    outPutFN <- paste0(obj@parameterList$outputDir, obj@parameterList$project_id,".result.table.txt")
    
    write.table(
        dfOutput, 
        outPutFN, 
        row.names = FALSE, 
        sep="\t"
    )
    
    ## Create Excel file ##
    library(openxlsx)
    
    wb <- createWorkbook()
    addWorksheet(wb, paste0(obj@parameterList$project_id, "_full_DGE_result_list"))
    freezePane(wb, paste0(obj@parameterList$project_id, "_full_DGE_result_list") ,  firstActiveRow = 2)
    
    ## Filter is inactivated, as it does not appear to be compatible with the current version of Excel
    #addFilter(wb, 1, row = 1, cols = 1:ncol(dfOutput))
    
    ## Style headers ##
    hs1 <- createStyle(
        fontColour = "#ffffff",
        fgFill = "#000000", 
        halign = "CENTER", 
        textDecoration = "Bold"
    )
    
    writeData(wb, 1, dfOutput, startRow = 1, startCol = 1, headerStyle = hs1)
    
    saveWorkbook(
        wb, 
        gsub(".txt", ".xlsx", outPutFN) , 
        overwrite = TRUE
    )
    
    ## Done creating Excel output table                                          ##
    ###############################################################################
    
    ###############################################################################
    ## Create metacore table                                                     ##
    
    ## Apply minimal filtering ##
    df.metacore <- obj@databaseTable[obj@databaseTable$count_cut_off >= metaCoreCountFilter,]
    
    ## select padj and logFC columns only ##
    sel.vec <- names(df.metacore)[grep("contrast_", names(df.metacore))]
    sel.vec <- sel.vec[-grep("stat", sel.vec)]
    sel.vec <- sel.vec[-grep("lg10p", sel.vec)]
    ## Remove contrast_x_ prefix > remove front 11 characters
    sel.vec <- append(obj@parameterList$geneIDcolumn, sel.vec)
    df.metacore <- unique(df.metacore[,sel.vec])
    
    ## Remove contrast_x_ tag from column labels ##
    comparisons <- names(obj@dfDesign)[grep("comp_", names(obj@dfDesign))]
    for (i in 1:length(comparisons)){
        names(df.metacore) <- gsub(
            paste0("contrast_", i, "_"), 
            "", 
            names(df.metacore)
        )
    }
    
    outPutFN <- paste0(obj@parameterList$outputDir, obj@parameterList$project_id,".metacore.input.file.txt")
    
    write.table(
        df.metacore, 
        outPutFN, 
        row.names = FALSE, 
        sep="\t"
    )
    
    wb <- createWorkbook()
    addWorksheet(wb, paste0(obj@parameterList$project_id, "_metacore_input_file"))
    
    ## Style headers ##
    hs1 <- createStyle(
        fgFill = "#4F81BD", 
        halign = "CENTER", 
        textDecoration = "Bold",
        border = "Bottom", 
        fontColour = "white"
    )
    
    writeData(wb, 1, dfOutput, startRow = 1, startCol = 1, headerStyle = hs1)
    
    saveWorkbook(
        wb, 
        gsub(".txt", ".xlsx", outPutFN) , 
        overwrite = TRUE
    )
    
    
    ## Done creating Metacore input file                                         ##
    ###############################################################################
    
    ###############################################################################
    ## Metacore analysis                                                         ##
    
    ## Open file in excel and save as metacore.input.file.xls (2003)
    #print("Perform enrichment analysis by subsetting data to logFC cut off: 1, padj 0.05")
    ## Select Workflows & Reports
    ## Select Enrichment analysis
    ## Set threshold: Threshold 1 p-value 0.05 direction both
    ## Run analysis
    ## If necessary, repeat with lower theshold
    ## If successful hit Get report button and safe as 
    #print(paste0(project.code, ".metacore.results.enrichment.analysis.xls"))
    
    ## Next do transcription factor target analysis ##
    ## Select One-click Analysis > Transcription Factors
    ## Set FDR threshold to 0.05
    #print(paste0("Export result table as: ", project.code, ".metacore.TF.analysis.", "logFC_nonAligned_vs_aligned"))
    
    ## Save results as p111.metacore.result.
    
    ## For selected TF targets, export MC results an curate into project category ##
    ## Select transcription factor of interest (Object name)
    ## Limit selection: Direction: Outgoing Effect Activation Mechanism influence on expression and transcription
    ## regulation >> Aplly >> Build Network
    ## Select additional options
    ## Pre filters Interaction types transcription regulation
    ## Additional options Directions: Downstream
    ## Hit build network
    ## Select all >> File >> Export >> safe as [TFname.mc.targets.xls]
    
    
    ## End Module add metacore results                                           ##
    ###############################################################################
    print("Excel output files create and depoisted in project/outputs folder")
}

## End: (7c) Create Excel output tables                                      ##
###############################################################################

###############################################################################
## Kill connections                                                          ##



killDbConnections <- function () {
    library(RMySQL)  
    all_cons <- dbListConnections(MySQL())
    print(all_cons)
    for(con in all_cons)
        res <- dbDisconnect(con)
    #print(paste(length(all_cons), " connections killed."))
}
##                                                                           ##
###############################################################################

###############################################################################
# Function upload pca.table.to.db()                                           #
###############################################################################

upload.pca.table.to.db <- function(
    df.pca,
    host = "www.biologic-db.org",
    prim.data.db = "vtl_data",
    password = "",
    db.user = "boeings", 
    PCAdbTableName = "P79_VTL_ES_PCA"){
    
    # Create color pallets
    if (length(grep("sample.group_colors", names(df.pca))) == 0){
        sample.group.vec <- names(df.pca)[grep("sample_group", names(df.pca))]
        sample.group.color.vec <- gsub("sample_group", "sample_group_colors", sample.group.vec)
        for (i in 1:length(sample.group.vec)){
            group.size <- length(unique(df.pca[,sample.group.vec[i]]))
            #library(RColorBrewer)
            #selcol <- colorRampPalette(brewer.pal(9,"YlOrBr"))
            library(scales)
            group.cols <- hue_pal()(group.size)
            assign(sample.group.color.vec[i], group.cols)
            assign(sample.group.vec[i], unique(df.pca[,sample.group.vec[i]]))
            df.col.pca <- data.frame(get(sample.group.vec[i]), get(sample.group.color.vec[i]))
            names(df.col.pca) <- c(sample.group.vec[i], sample.group.color.vec[i])
            df.pca <- merge(
                df.pca, 
                df.col.pca,
                by.x = sample.group.vec[i],
                by.y = sample.group.vec[i],
                all = TRUE
            )
        }
    }
    # Adjust pca column names if neceessary
    if (length(grep("^pca", names(df.pca))) > 0){
        names(df.pca) <- gsub("^pca", "PC", names(df.pca))
    }
    
    if (length(grep("^PCA", names(df.pca))) > 0){
        gsub("^PCA", "PC", names(df.pca))
    }
    
    library(RMySQL)
    #df.pca should contain three columns: sample_name, sample.group, sample.group_color, pca1, pca2, ..., pcaN
    df.pca[["row_names"]] <- 1:nrow(df.pca)
    
    dbDB <- dbConnect(drv = RMySQL::MySQL(), user = db.user, password = password, host = host) 
    dbGetQuery(dbDB, paste("CREATE DATABASE IF NOT EXISTS ", prim.data.db, sep=""))
    dbDB <- dbConnect(drv = RMySQL::MySQL(), user = db.user, password = db.pwd, dbname=prim.data.db, host = host) 
    dbGetQuery(dbDB, paste("DROP TABLE IF EXISTS ", PCAdbTableName, sep=""))
    dbWriteTable(dbDB, PCAdbTableName, df.pca, row.names= FALSE)
    
    dbDB <- dbConnect(drv = RMySQL::MySQL(), user = db.user, password = password, host = host, dbname=prim.data.db) 
    dbGetQuery(dbDB, paste("ALTER TABLE `",PCAdbTableName,"` ADD UNIQUE(`row_names`)", sep=""))
    dbGetQuery(dbDB, paste("ALTER TABLE `",PCAdbTableName,"` ADD PRIMARY KEY(`row_names`)", sep=""))
    dbGetQuery(dbDB, paste0(
        "ALTER TABLE `",
        PCAdbTableName,
        "` CHANGE `sample_id` `sample_id` VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci"
    )
    )
    
    # Assign sample group and sample group color columns
    var.char.50.cols <- names(df.pca)[grep("sample.group", names(df.pca))]
    if (length(var.char.50.cols) > 0){
        for (i in 1:length(var.char.50.cols)){
            dbGetQuery(dbDB, paste0(
                "ALTER TABLE `",
                PCAdbTableName,
                "` CHANGE `",
                var.char.50.cols[i],
                "` `",
                var.char.50.cols[i],
                "` VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci"
            )
            )
        }
    }
    
    dec.6.3.cols <- names(df.pca)[grep("^PC", names(df.pca))]
    for (i in 1:length(dec.6.3.cols)){
        dbGetQuery(dbDB, paste0("ALTER TABLE ",PCAdbTableName," 
                                CHANGE `",dec.6.3.cols[i],"` `",dec.6.3.cols[i],"` DECIMAL(6,3) NULL DEFAULT NULL"
        )
        )
        
    }
    
}

## End of function                                                           ##
###############################################################################

###############################################################################
# (19) upload.datatable.to.database()
###############################################################################

## Indexing of gene name column 
# CREATE INDEX idx_mgi_symbol ON p268_rna_seq_table(mgi_symbol)

upload.datatable.to.database <- function(
    host = "www.biologic-db.org", 
    user = "db.user",
    password = "db.pwd",
    prim.data.db = "project.database",
    dbTableName = "rnaseqdbTableName",
    df.data = "df.data.to.upload",
    db.col.parameter.list = list(
        "VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("gene_description"),
        "VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("ENSG", "ENSMUSG", "hgnc_symbol", "mgi_symbol", "uniprot", "entrezgene","display_ptm", "^sequence_window", "p_site_env","for_GSEA_gene_chip","associated_gene_name", "gene_type"),
        "VARCHAR(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("ppos", "amino_acid", "charge","known_site"),
        "BIGINT(8) NULL DEFAULT NULL" = c("row_names"),
        "INT(8) NULL DEFAULT NULL" = c("row_id", "cluster_order","cluster_id", "count_cut_off", "^position$", "raw_counts"),
        "DECIMAL(6,3) NULL DEFAULT NULL" = c("norm_counts", "NES", "logFC", "lg2_avg", "intensity", "^int", "iBAQ","^localization_prob$"),
        "DECIMAL(6,5) NULL DEFAULT NULL" = c("padj", "pvalue","^pep$")
    ),
    increment = 5000,
    new.table = FALSE,
    first.row.name.index = 1,
    startOnlyWithConnectionCount1 = FALSE,
    cols2Index = NULL
){
    
    
    
    if (startOnlyWithConnectionCount1){
        
        ## helper function ##
        getConnectonCount <- function(
            user= "user",
            password = "password",
            dbname = "prim.data.db",
            host = "host"){
            dbDB <- dbConnect(
                drv = RMySQL::MySQL(), 
                user = user, 
                password = password, 
                #dbname = prim.data.db, 
                host = host
            )
            
            connectionCount <- as.numeric(
                dbGetQuery(
                    dbDB, 
                    "SELECT COUNT(1) ConnectionCount, user FROM information_schema.processlist WHERE user <> 'system user' AND user = 'boeingS' GROUP BY user;"
                )$ConnectionCount
            )
            
            dbDisconnect(dbDB)
            
            return(connectionCount)
        }
        
        connectionCount <- getConnectonCount(
            user= user,
            password = password,
            dbname = prim.data.db,
            host = host
        )
        
        while (connectionCount > 2){
            print(paste(connectionCount, "connections open. Sleep 30 seconds and try again."))
            
            Sys.sleep(30)
            
            
            connectionCount <- getConnectonCount(
                user= user,
                password = password,
                dbname = prim.data.db,
                host = host
            )
            
            
        }
        
    }
    
    ## Uploading of data frame to database. Happens only if all columns are defined ##
    library(RMySQL)
    ## Connect to MySQL to check existence of database ##
    dbDB <- dbConnect(
        drv = RMySQL::MySQL(), 
        user = user, 
        password = password, 
        host = host,
        new.table = TRUE
    )
    
    ## Create the database if it does not exist already##
    res <- dbGetQuery(
        dbDB, 
        paste(
            "CREATE DATABASE IF NOT EXISTS ", 
            prim.data.db, 
            sep = ""
        )
    )
    
    dbDisconnect(dbDB)
    
    ## Ensure that df.data has a row_names column ##
    df.data[["row_names"]] <- first.row.name.index:(first.row.name.index+nrow(df.data)-1)
    
    ## Check if all columns are assigned in db.col.parameter.list ##
    all.col.string.vec <- as.vector(do.call('c', db.col.parameter.list))
    
    ## Create a vector that contains all col names that contain at least in part the string in all.cols.vec
    
    ###############################################################################
    ## Function start                                                            ##
    get.all.col.names.with.these.strings <- function(all.col.string.vec){
        all.assigned.cols <- vector(mode="character", length=0)
        for (i in 1:length(all.col.string.vec)){
            pos <- grep(all.col.string.vec[i], names(df.data))
            if (length(pos) > 0){
                all.assigned.cols <- append(all.assigned.cols, names(df.data)[pos])
            }
        }
        return(all.assigned.cols)
    } 
    
    ## End of function                                                           ##
    ###############################################################################
    all.assigned.cols <- get.all.col.names.with.these.strings(all.col.string.vec)
    
    ## Ensure that all database columns are assigned ##
    not.assigned <- names(df.data)[!(names(df.data) %in% all.assigned.cols)]
    
    if (length(not.assigned) == 0){
        print("All database columns are defined. Uploading to database...")
    } else {
        print(
            paste0(
                "The following database columns have not been defined: ",
                paste(not.assigned, 
                      collapse = ', '
                ), 
                ". Datatable not uploaded to database.")
        )
        stop(not.assigned)
    }
    
    
    ## Connect to database for dbtable upload  ##
    dbDB <- dbConnect(
        drv = RMySQL::MySQL(), 
        user = user, 
        password = password, 
        dbname = prim.data.db, 
        host = host
    )
    
    ## Remove all tables with the same name from db ##
    if (new.table){
        res <- dbGetQuery(
            dbDB, 
            paste(
                "DROP TABLE IF EXISTS ", 
                dbTableName, 
                sep = ""
            )
        )
        dbDisconnect(dbDB)
    }
    
    ## Upload up to increment rows in one go ##
    iter <- nrow(df.data)%/%increment
    if (nrow(df.data)%%increment != 0){
        iter <- iter + 1
    }
    
    for (i in 1:iter){
        if (nrow(df.data) > increment){
            limit <- increment
        } else {
            limit <- nrow(df.data)
        }
        df.temp <- df.data[1:limit,]
        df.data <- df.data[(increment+1):nrow(df.data),]
        
        uploaded = FALSE
        while (!uploaded){
            tryCatch({
                killDbConnections()
                dbDB <- dbConnect(
                    drv = RMySQL::MySQL(), 
                    user = user, 
                    password = password, 
                    dbname = prim.data.db, 
                    host = host
                )
                
                ## Upload new dataframe to database ##
                res <- dbWriteTable(
                    dbDB, 
                    dbTableName, 
                    df.temp, 
                    row.names = FALSE,
                    append = TRUE, 
                    overwrite = FALSE
                )
                dbDisconnect(dbDB)
                uploaded = TRUE
                #dbDisconnect(dbDB)
            }, error=function(e){cat("Upload errror :",conditionMessage(e), "\n")}) 
        }
        
        print(paste0(i * increment, " rows uploaded to database..."))
        ## Connect to database for dbtable upload  ##
    }
    
    ####################################################
    ## Function alterDBtable
    alterDBtable <- function(
        cmd.string = "mysql command",
        user = "user",
        password = "password",
        dbname = "prim.data.db",
        host = "host"
    ){
        dbDB <- dbConnect(
            drv = RMySQL::MySQL(), 
            user = user, 
            password = password, 
            dbname = prim.data.db, 
            host = host
        )
        
        tryCatch({
            dbGetQuery(
                dbDB, 
                cmd.string
            )}, error=function(e) {paste0("Alter not executed. cmd.vector[", i, "]")})
        
        dbDisconnect(dbDB)
        
        
    }
    
    ## End of function ##
    ######################
    mysql.cmd = ""
    if (new.table){
        alterDBtable(
            cmd.string = paste(
                "ALTER TABLE `", 
                dbTableName,
                "` ADD UNIQUE(`row_names`)", 
                sep = ""
            ),
            user = user,
            password = password,
            dbname = dbname,
            host = host
        )
        
        ## Describe key columns in database table ##
        mysql.cmd <- paste(
            "ALTER TABLE `", 
            dbTableName,
            "` ADD UNIQUE(`row_names`)", 
            sep = ""
        )
        
        
        alterDBtable(
            cmd.string = paste(
                "ALTER TABLE `",
                dbTableName,
                "` ADD PRIMARY KEY(`row_names`)",
                sep = ""
            ),
            user = user,
            password = password,
            dbname = dbname,
            host = host
        ) 
        
        
        
        
        ###############################################################################
        ## Characterize and define secondary database columns                        ##
        for (i in 1:length(db.col.parameter.list)) {
            descriptor <- names(db.col.parameter.list[i])
            cols.in.class <-
                get.all.col.names.with.these.strings(db.col.parameter.list[[i]])
            
            if (length(cols.in.class) > 0) {
                print(
                    paste0(
                        "Assigned ", 
                        paste0(cols.in.class, collapse = ', '), 
                        " as ", 
                        descriptor, "."
                    )
                )
                
                ## Assign column names to MySQL class ##
                alteration.string <-
                    paste0("ALTER TABLE ", dbTableName, " ")
                for (j in 1:length(cols.in.class)) {
                    alteration.string <- paste0(
                        alteration.string,
                        paste0(
                            "CHANGE `", cols.in.class[j], "` `", cols.in.class[j], "` ", descriptor, ", "
                        )
                    )
                }
                ## Remove last comma from string
                alteration.string <-
                    substr(alteration.string, 1, (nchar(alteration.string) - 2))
                
                ## Carry out alteration
                ## Connect to database for dbtable upload  ##
                ## Connection is repated to avoid loss of a short lived connection.
                alterDBtable(
                    cmd.string = alteration.string,
                    user = user,
                    password = password,
                    dbname = dbname,
                    host = host
                )
            }
            #print(alteration.string)
            mysql.cmd <- append(mysql.cmd, 
                                alteration.string)
            
            #dbGetQuery(dbDB,
            #           alteration.string)
            
            
        }
        
    }
    ## End characterize and define secondary database columns                  ##
    #############################################################################
    ## Add index based on row namems ##
    
    if (length(cols2Index) > 0){
        for (i in 1:length(cols2Index)){
            print("...indexing...")
            cmd.string <- paste0("CREATE INDEX idx_",cols2Index[i]," ON ",dbTableName," (",cols2Index[i],")")
            
            dbDB <- dbConnect(
                drv = RMySQL::MySQL(), 
                user = user, 
                password = password, 
                dbname = prim.data.db, 
                host = host
            )
            
            tryCatch({
                dbGetQuery(
                    dbDB, 
                    cmd.string
                )}, error=function(e) {stop(paste0("Database table not uploaded. Problem adding index ",cols2Index[i],"."))})
            
            dbDisconnect(dbDB)
            
            print(paste0("Datatable ", dbTableName, " successfully uploaded and column(s) ",paste(cols2Index, collapse = " ")," indexed."))
        }
    }
    return(mysql.cmd) 
}



#RENAME TABLE p131_rna_seq_table_part_1 TO p131_rna_seq_table
#INSERT INTO p131_rna_seq_table SELECT * FROM p131_rna_seq_table_part_2;
#INSERT INTO p131_rna_seq_table SELECT * FROM p131_rna_seq_table_part_3;
#INSERT INTO p131_rna_seq_table SELECT * FROM p131_rna_seq_table_part_4;
#INSERT INTO p131_rna_seq_table SELECT * FROM p131_rna_seq_table_part_5;

#DROP TABLE p131_rna_seq_table_part_2;
#DROP TABLE p131_rna_seq_table_part_3;
#DROP TABLE p131_rna_seq_table_part_4;
#DROP TABLE p131_rna_seq_table_part_5;

## End of function                                                           ##
###############################################################################

###################################
# (17) Load datatable from database#
###################################

import.db.table.from.db <- function(dbtable = "interpro_categori",
                                    dbname = "reference_categories_db_new",
                                    user     = "boeings",
                                    password = "",
                                    host     = "www.biologic-db.org"
){
    ## Helper function ##
    oldw <- getOption("warn")
    options(warn = -1)
    
    
    
    ## End helper function ##
    
    
    library(RMySQL)
    ## Create connection
    dbDB <- dbConnect(MySQL(), user = user, password = password, host = host, dbname=dbname)
    ## Get number of expected rows from query ##
    nrows.to.download <- dbGetQuery(dbDB, paste0("SELECT COUNT(*) FROM ",dbtable))
    
    
    
    dbDisconnect(dbDB)
    download = TRUE
    i=1
    while (download) {
        dbDB <- dbConnect(MySQL(), user = user, password = password, host = host, dbname=dbname)
        out <- tryCatch({
            df.data = dbGetQuery(dbDB, paste0("SELECT DISTINCT * FROM ", dbtable))
        },
        error=function() {
            message("Database error")
            # Choose a return value in case of error
        }
        )    
        
        dbDisconnect(dbDB)
        if (nrow(df.data) == nrows.to.download){
            download = FALSE
            print(paste0(nrow(df.data), " of ", nrows.to.download, " rows downloaded."))
        } else {
            print(paste0("Expected: ", nrows.to.download, ". Downloaded: ", nrow(df.data), ". "))
            print(paste0("Download failed for the ", i, " time. Try again..."))
            i = i+1
        }
    }
    options(warn = oldw)
    return(df.data)
}

# End of function


###############################################################################
# (9A) create.GSEA.rnk.files                                                  #
###############################################################################
#Create rnk files for all logFC comparisons

create.gsea.rnk.files <- function(
    localWorkDir,
    df.dataTable,
    GSEA.colum.type = "stat",
    gene.symbol.column.name = "hgnc_symbol",
    medianCollapse = TRUE) {
    setwd(localWorkDir)
    #Create GSEA directory
    GSEADir = paste(localWorkDir, "GSEA", sep = "")
    if (length(grep("GSEA", list.dirs())) == 0) {
        dir.create("GSEA")
    }
    
    #Get Stat columns from the table
    setwd(GSEADir)
    
    ## Create rnk files ##
    stat.samples = names(df.dataTable)[grep(GSEA.colum.type, names(df.dataTable))]
    
    for (i in 1:length(stat.samples)) {
        df.rnk = unique(df.dataTable[,c(gene.symbol.column.name, stat.samples[i])])
        df.rnk = df.rnk[order(df.rnk[,stat.samples[i]]),]
        names(df.rnk) = c(gene.symbol.column.name, GSEA.colum.type)
        df.rnk = na.omit(df.rnk)
        stat.col.name <-
            names(df.rnk)[grep(GSEA.colum.type, names(df.rnk))]
        df.rnk = df.rnk[df.rnk[,stat.col.name] != "",]
        df.rnk = df.rnk[df.rnk[,gene.symbol.column.name] != "",]
        df.rnk[,GSEA.colum.type] = as.numeric(df.rnk[,GSEA.colum.type])
        df.rnk <- unique(df.rnk)
        
        ## Collapse based on gene id ##
        duplicatedIds <- unique(
            df.rnk[
                duplicated(
                    df.rnk[,gene.symbol.column.name]),
                gene.symbol.column.name
                ]
        )
        
        if (length(duplicatedIds) > 0){
            for (j in 1:length(duplicatedIds)){
                value <- median(df.rnk[df.rnk[,gene.symbol.column.name] == duplicatedIds[j],stat.col.name])
                df.rnk[df.rnk[,gene.symbol.column.name] == duplicatedIds[j],stat.col.name] <- value
            }
        }
        
        df.rnk <- unique(df.rnk)
        ## done collapsing ##
        
        write.table(
            df.rnk, paste(stat.samples[i], ".rnk", sep = ""), row.names = FALSE, 
            sep = "\t",
            eol = "\r",
            quote = F
        )
        
        
    }
    
    #The .rnk files currently need to be opened once in excel and saved before they can be processed by the GSEA
    #desktop application
    
    #GSEA parameters
    #Collapse dataset to gene symbols = FALSE
    #Number of permutations = 1000
    #C2: Min. size 15,
    
    #Got to GSEA to calculate category enrichments
    #Write result folders to .../GSEA
    setwd(localWorkDir)
    print(paste0("GSEA .rnk for all contrasts were created in ", GSEADir))
    
}

## End of function                                                             ##
#################################################################################   

################################################################################
# (27) db.cat2gmt()                                                            #
################################################################################

dbcat2gmt <- function(
    df.cat, # As downloaded from reference_categories_db_new database
    gene.id.column = "hgnc_symbol"
){
    cat.list <- sapply(df.cat[,gene.id.column], function(x) list(x) )
    names(cat.list) <- as.vector(df.cat[,"cat_id"])
    cat.list <- lapply(cat.list, function(x) unlist(strsplit(x, ";")))
    cat.list <- lapply(cat.list, function(x) x[x != ""])
    
    ## Equalize length of all vectors with empty spaces ##
    l2 <- lapply(cat.list, function(x) length(x))
    cat.list <- cat.list[l2 > 0]
    
    l2 <- lapply(cat.list, function(x) length(x))
    
    maxVecLength <- max(unlist(l2))
    l2 <- lapply(l2, function(x) maxVecLength - x)
    l2 <- lapply(l2, function(x) rep("", x))
    library(tidyverse)
    
    #cat.list <- map2(cat.list, l2,c)
    for (k in 1:length(cat.list)){
        cat.list[[k]] <- c(cat.list[[k]], l2[[k]])
    }
    
    ## Add first two columns ##
    df.cat <- df.cat[df.cat$cat_id %in% names(cat.list),]
    lColName <- sapply(df.cat[,"cat_name"], function(x) list(x) )
    lColCom <- sapply(df.cat[,"comments_1"], function(x) list(x) )
    
    laddCols <- map2(lColName, lColCom, c)
    #for (k in 1:length(lColName)){
    #    laddCols[[k]] <- c(lColName[[k]], lColCom[[k]])
    #}
    
    cat.list <- map2(laddCols, cat.list, c)
    #for (k in 1:length(cat.list)){
    #    cat.list[[k]] <- c(laddCols[[k]], cat.list[[k]])
    #}
    
    df.gmt <- as.data.frame(do.call(rbind, cat.list))
    
    
    return(df.gmt)
}

## End function dbcat2gmt()                                                  ##
###############################################################################

################################################################################
# (12) create.gmt.file.from.ref.data.table()                                   #
################################################################################
create.gmt.file.from.ref.data.table <- function(
    host = 'www.biologic-db.org',
    dbname = "reference_categories_db_new",
    dataTable = "st_lab_categories",
    pwd = "Saturday08",
    user="boeings",
    gene.id.column = "hgnc_symbol"){
    
    ## Step 1: retrieve database table ##
    library(RMySQL)
    
    for (i in 1:length(dataTable)){
        dbDB <- dbConnect(
            drv = RMySQL::MySQL(), 
            user = user, 
            password = pwd, 
            dbname= dbname, 
            host = host
        ) 
        
        out <- tryCatch({
            df.temp = dbGetQuery(
                dbDB, 
                paste("SELECT DISTINCT * FROM ", dataTable[i], sep=""))
        },
        error=function() {
            message("Database error")
            df.temp = NA
            # Choose a return value in case of error
        }
        ) 
        
        dbDisconnect(dbDB)
        if (i ==1){
            df.res <- df.temp
        } else {
            df.res <- rbind(df.res, df.temp)
        }
    }
    ## Step 2: transform to gmt file ##
    ###############################################################################
    ## Function dbcat2gmt                                                        ##
    ## Example of usage is given in 20170505.procedure.gmt2.median.timecourse.r
    # dbcat2gmt <- function(
    #     df.cat, # As downloaded from reference_categories_db_new database
    #     gene.id.column = "hgnc_symbol"
    # ){
    #     cat.list <- sapply(df.cat[,gene.id.column], function(x) list(x) )
    #     names(cat.list) <- as.vector(df.cat[,"cat_id"])
    #     cat.list <- lapply(cat.list, function(x) unlist(strsplit(x, ";")))
    #     cat.list <- lapply(cat.list, function(x) x[x != ""])
    #     
    #     ## Equalize length of all vectors with empty spaces ##
    #     l2 <- lapply(cat.list, function(x) length(x))
    #     cat.list <- cat.list[l2 > 0]
    #     
    #     l2 <- lapply(cat.list, function(x) length(x))
    #     
    #     maxVecLength <- max(unlist(l2))
    #     l2 <- lapply(l2, function(x) maxVecLength - x)
    #     l2 <- lapply(l2, function(x) rep("", x))
    #     library(tidyverse)
    #     
    #     cat.list <- map2(cat.list, l2,c)
    #     
    #     ## Add first two columns ##
    #     df.cat <- df.cat[df.cat$cat_id %in% names(cat.list),]
    #     lColName <- sapply(df.cat[,"cat_name"], function(x) list(x) )
    #     lColCom <- sapply(df.cat[,"comments_1"], function(x) list(x) )
    #     
    #     laddCols <- map2(lColName, lColCom, c)
    #     cat.list <- map2(laddCols, cat.list, c)
    #     
    #     df.gmt <- as.data.frame(do.call(rbind, cat.list))
    #     
    #     
    #     return(df.gmt)
    # }
    
    ## End function dbcat2gmt()                                                  ##
    ###############################################################################
    
    df.gmt <- dbcat2gmt(
        df.cat = df.res,
        gene.id.column = gene.id.column
    )
    df.gmt <- data.frame(df.gmt)
    return(df.gmt)
}

##
## End of function create.gmt.file.from.ref.data.table()                     ##
###############################################################################

###############################################################################
# (9B) create.GSEA.table                                                      #
###############################################################################

## Run GSEA
## java -jar ${ROOTGSEA}/gsea.jar -Xmx512m -cp xtools.gsea.GseaPreranked -gmx /camp/stp/babs/working/boeings/Projects/reference_data/GSEA.gmt.files/20160508.rna.seq.txn.analysis.gmt -norm meandiv -nperm 1000 -rnk /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA/contrast_1_logFC_IFNARLA_vs_WTLA30.rnk -scoring_scheme weighted -rpt_label contrast_1_rnaSeqTxnAnalysis -create_svgs false -make_sets true -plot_top_x 100 -rnd_seed timestamp -set_max 500 -set_min 15 -zip_report false -out /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA -gui false

## This appears to work ##
#java -Xmx2512m -cp /camp/stp/babs/working/boeings/Projects/software/gsea-3.0.jar xtools.gsea.GseaPreranked -gmx /camp/stp/babs/working/boeings/Projects/reference_data/GSEA.gmt.files/20160508.rna.seq.txn.analysis.gmt -rnk /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA/contrast_1_logFC_IFNARLA_vs_WTLA30.rnk -rpt_label contrast_1_rnaSeqTxnTest -out /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA -collapse false -mode Max_probe -norm meandiv -nperm 1000 -scoring_scheme classic -include_only_symbols true -make_sets true -plot_top_x 100 -rnd_seed timestamp -set_max 2500 -set_min 10 -zip_report false -gui false

#module load Java/1.8.0_131 
#cat('      sbatch --time=12:00:00 --wrap "java -jar ${EBROOTPICARD}/picard.jar AddOrReplaceReadGroups \\'); cat('\n');
#cat(sbatch --time=12:00:00 --wrap "java -Xmx2512m -cp /camp/stp/babs/working/boeings/Projects/software/gsea-3.0.jar xtools.gsea.GseaPreranked -gmx /camp/stp/babs/working/boeings/Projects/reference_data/GSEA.gmt.files/20160508.rna.seq.txn.analysis.gmt -rnk /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA/contrast_1_logFC_IFNARLA_vs_WTLA30.rnk -rpt_label contrast_1_rnaSeqTxnTest -out /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA -collapse false -mode Max_probe -norm meandiv -nperm 1000 -scoring_scheme classic -include_only_symbols true -make_sets true -plot_top_x 100 -rnd_seed timestamp -set_max 2500 -set_min 10 -zip_report false -gui false'" --job-name="job" -c 1 --mem-per-cpu=7000 -o gsea.slurm >> commands.txt'); cat('\n');
#sbatch --time=12:00:00 --wrap "java -Xmx7000m -cp /camp/stp/babs/working/boeings/Projects/software/gsea-3.0.jar xtools.gsea.GseaPreranked -gmx /camp/stp/babs/working/boeings/Projects/reference_data/GSEA.gmt.files/20160508.rna.seq.txn.analysis.gmt -rnk /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA/contrast_1_logFC_IFNARLA_vs_WTLA30.rnk -rpt_label contrast_1_rnaSeqTxnTest -out /camp/stp/babs/working/boeings/Projects/126_SL_MP_RNA_seq_macrophage_stimulation_timecourse/workdir/GSEA -collapse false -mode Max_probe -norm meandiv -nperm 1000 -scoring_scheme classic -include_only_symbols true -make_sets true -plot_top_x 100 -rnd_seed timestamp -set_max 2500 -set_min 10 -zip_report false -gui false" --job-name='job' -c 1 --mem-per-cpu=7000 -o gsea.slurm >> commands.txt

## end of working

create.GSEA.table <- function(
    GSEADir,
    logFC.column.name = "logFC",
    host = 'www.biologic-db.org',
    refdbname= "reference_categories_db_new",
    refDBTableName = paste0(project.code, "_VTL_ES_enriched_categories_table"),
    db.user = db.user,
    db.password = db.pwd, 
    tables = tables,
    df.dataTable,
    outputDir = "", # this should be set to projectDir/outputs
    project.code = "p001"
){
    #####################################################################
    #Function#
    #####################################################################
    compile.gsea.results <- function(folder.name)
    {cwd = getwd()
    setwd(folder.name)
    result.xls.list = list.files()[grep("gsea_report", list.files())]
    result.xls.list = result.xls.list[grep(".xls", result.xls.list)]
    df.res1 = read.delim(result.xls.list[1], header=TRUE, sep="\t", stringsAsFactors = FALSE)
    df.res2 = read.delim(result.xls.list[2], header=TRUE, sep="\t", stringsAsFactors = FALSE)
    df.res = rbind(df.res1, df.res2)
    setwd(cwd)
    return(df.res)
    }
    #End of function
    
    #Collate GSEA output files
    setwd(GSEADir)
    folder.list = list.files()[(grep("Gsea", list.files()))]
    if (length(grep("error", folder.list)) > 0){
        folder.list <- folder.list[-grep("error", folder.list)]
    }
    samples = unique(substr(folder.list,1, 10))
    logFC.samples = names(df.dataTable)[grep(logFC.column.name, names(df.dataTable))]
    
    for (j in 1:length(samples)){
        setwd(GSEADir)
        folder.list = list.files()[(grep("Gsea", list.files()))]
        folder.list = folder.list[grep(samples[j], folder.list)]
        if (length(grep("error", folder.list)) > 1){
            folder.list <- folder.list[-grep("error", folder.list)]
        }
        
        for (i in 1:length(folder.list)){
            name = paste("cat.results", samples[j], sep="_")
            name.all = paste("all.cat.results", samples[j], sep="_")
            assign(name, compile.gsea.results(folder.name=folder.list[i]))
            assign(name, get(name)[,c("NAME", "FDR.q.val", "NES")])
            if (i == 1){
                assign(name.all, get(name))
            } else {
                assign(name.all, rbind(get(name.all), get(name)))
            }
        }
        assign(name.all, get(name.all)[get(name.all)$FDR.q.val <= 0.05, ])
        
        if (j == 1){
            all.samples.vector = name.all
            
            enriched.categories = get(name.all)
            names(enriched.categories)[which(names(enriched.categories) == "FDR.q.val")] = paste("padj_", substr(logFC.samples[j], 18, 50), sep="")
            names(enriched.categories)[which(names(enriched.categories) == "NES")] = paste("NES_", substr(logFC.samples[j], 18, 50), sep="") 
        } else {
            all.samples.vector = append(all.samples.vector, name.all)
            enriched.categories = merge(enriched.categories, get(name.all), by.x="NAME", by.y="NAME", all=TRUE)
            enriched.categories[is.na(enriched.categories)] = "1"
            names(enriched.categories)[which(names(enriched.categories) == "FDR.q.val")] = paste("padj_", substr(logFC.samples[j], 18, 50), sep="")
            names(enriched.categories)[which(names(enriched.categories) == "NES")] = paste("NES_", substr(logFC.samples[j], 18, 50), sep="") 
        }
    }
    
    #######################################################################
    #Now, get all image files and compile in one folder via a shell script#
    #######################################################################
    shellFileVec <- as.vector(NULL, mode="character")
    gseaScriptVec <- c("#!/bin/sh", "\n")
    gseaTrVec <- as.vector(NULL, mode="character")
    gseaShVec <- as.vector(NULL, mode="character")
    
    for (j in 1:length(samples)){
        setwd(GSEADir)
        folder.list = list.files()[(grep("Gsea", list.files()))]
        folder.list = folder.list[grep(samples[j], folder.list)]
        if (length(grep("error", folder.list)) > 1){
            folder.list <- folder.list[-grep("error", folder.list)]
        }
        
        
        for (i in 1:length(folder.list)){
            cwd = getwd()
            setwd(folder.list[i])
            temp.file.list = list.files()[grep("enplot", list.files())]
            temp.path.list = paste(folder.list[i], temp.file.list, sep="/")
            temp.target.file = paste("enrichment_plots",samples[j], temp.file.list, sep="/")
            temp.contrast = rep(samples[j], length(temp.file.list))
            
            if (i ==1){
                full.file.list = temp.file.list
                full.path.list = temp.path.list
                full.target.list = temp.target.file
                contrast.list = temp.contrast 
            } else {
                full.file.list = append(full.file.list, temp.file.list)
                full.path.list = append(full.path.list, temp.path.list)
                full.target.list = append(full.target.list, temp.target.file)
                contrast.list = append(contrast.list, temp.contrast)
            }
            setwd(cwd)
        }
        
        cat_names = sapply(full.file.list, function(x) unlist(strsplit(x, "_")))
        cat_names = sapply(cat_names, function(x) paste(x[3:length(x)-1], collapse = "_"))
        
        ## Escape all ( and ) in full path list
        full.path.list <- gsub("\\(", "\\\\\\(",full.path.list)
        full.path.list <- gsub("\\)", "\\\\\\)",full.path.list)
        
        full.path.list <- gsub("\\&", "\\\\\\&",full.path.list)
        full.path.list <- gsub("\\;", "\\\\\\;",full.path.list)
        
        full.path.list <- gsub("\\'", "\\\\\\'",full.path.list)
        
        df.files = data.frame(full.file.list, full.path.list, cat_names, full.target.list, contrast.list)
        
        
        
        
        #Create shell script to transfer all png.files
        #Destinatin folder GSEA/enrichment_plots
        
        setwd(GSEADir)
        gseaShVec <- c(
            gseaTrVec,
            paste0(
                "sh ",
                samples[j], 
                ".file.transfer.sh"   
            )
        )
        
        # gseaShVec <- c(
        #     gseaShVec,
        #     paste0(
        #         "sh conv.",
        #         samples[j], 
        #         ".file.transfer.sh"   
        #     )
        # )
        
        #print(paste0("If you create the shell script on a windows machine, remove end of line character with the command: \\n",
        #             " tr -d '\r' <",paste(samples[j], ".file.transfer.sh", sep=""),"> conv.",
        #             paste(samples[j], ".file.transfer.sh", sep="")))
        
        ## List all transfer scripts ##
        shellFileVec <- c(
            shellFileVec,
            # paste0(
            #     "tr -d '\\\r' <",
            #     paste(
            #         samples[j], 
            #         ".file.transfer.sh", 
            #         sep=""
            #     ),
            #     "> conv.",
            #     paste(
            #         samples[j], 
            #         ".file.transfer.sh", 
            #         sep="")
            # ),
            # "",
            paste0(
                "sh ",
                paste(
                #    "conv.",
                    samples[j], 
                    ".file.transfer.sh", 
                    sep=""
                )
            ),
            ""
        )
        
        
        ## Make individual shell script ##
        sink(file=paste(samples[j], ".file.transfer.sh", sep=""))
        
        cat('mkdir -p enrichment_plots'); cat('\n');
        
        
        cat(paste("mkdir enrichment_plots/",samples[j], sep="")); cat("\n");
        if (j ==1){
            image.link.array <- paste0(samples[j], "_image_link", sep="")
        } else {
            image.link.array <- append(image.link.array,paste0(samples[j], "_image_link", sep=""))
        }
        
        for (i in 1:length(full.path.list)){
            cmd = paste("cp ", full.path.list[i], " ./enrichment_plots/", samples[j], sep="")
            
            # Escape all $ and ( and ) in file names
            
            cat(cmd); cat("\n");
        }
        
        sink()
        if (j == 1){
            df.all.files = df.files
        } else {
            df.all.files = rbind(df.all.files, df.files)
        }
    }
    
    ## Create masterscript ##
    setwd(GSEADir)
    sink("GSEAmasterscript.sh")
    for (a in 1:length(shellFileVec)){
        cat(shellFileVec[a]); cat("\n");
    }
    sink()
    
    print(
        paste0(
            "If you create the shell script on a windows machine, remove end of line character with the command: \\n",
            " tr -d '\r' <GSEAmasterscript.sh> conv.GSEAmasterscript.sh"
        )
    )
    
    sink("GSEAplotfileTransfer.sh")
    cat("#!/bin/sh");cat("\n");
    
    #for (a in 1:length(gseaTrVec)){
    #    cat(gseaTrVec[a]); cat("\n");
    #}
    
    #cat("\n");
    cat("#Copying files");cat("\n");
    
    for (a in 1:length(gseaShVec)){
        cat(gseaShVec[a]); cat("\n");
    }
    
    sink()
    
    print(
        paste0(
            "If you create the shell script on a windows machine, remove end of line character with the command: \\n",
            " tr -d '\r' <GSEAmasterscript.sh> conv.GSEAmasterscript.sh"
        )
    )
    print(
        paste0(
            "If you create the shell script on a windows machine, remove end of line character with the command: \\n",
            " tr -d '\r' <GSEAplotfileTransfer.sh> conv.GSEAplotfileTransfer.sh"
        )
    )
    
    
    #####################
    #Upload to database##
    #####################
    #Create database table
    #List of enriched categories: FDR <= 0.25 all.cat.results
    #merge all.cat.results$NAME to db_table_cat_name (1:1 match)
    
    library(RMySQL)
    
    
    #tables = tables[grep("mysigdb", tables)]
    
    #Get all categories from all tables
    for (i in 1:length(tables)){
        
        temp.cat.list <- import.db.table.from.db(
            host = host,
            dbname = refdbname,
            dbtable = tables[i],
            password = db.pwd,
            user = db.user
        )
        
        temp.cat.list <- unique(
            temp.cat.list[,
                          c(
                              "cat_id", 
                              "cat_name", 
                              "cat_type", 
                              "data_source", 
                              "comments_1", 
                              "comments_2", 
                              "cat_item_size"
                          )
                          ]
        )
        
        
        
        
        if (length(grep("mysigdb", tables[i])) == 0){
            temp.cat.list$comments_2 = ""
            temp.cat.list$cat_name = toupper(temp.cat.list$cat_name)
            temp.cat.list$cat_name = gsub(" ", "_", temp.cat.list$cat_name)
            temp.cat.list$cat_name = gsub("'", "", temp.cat.list$cat_name)
        }
        
        if (i ==1){
            full.cat.list = temp.cat.list
        } else {
            full.cat.list = rbind(full.cat.list, temp.cat.list)
        }
    }
    
    
    
    #Merge with result list 
    enriched.categories = unique(merge(enriched.categories, full.cat.list, by.x = "NAME", by.y = "cat_name"))
    
    
    
    
    df.all.files = df.all.files[c("cat_names", "full.file.list", "contrast.list", "full.target.list")]
    names(df.all.files)= c("cat_names" ,"full.file.list", "contrast", "image_link")
    df.all.files$cat_names = sapply(df.all.files$cat_names, function(x) gsub("V_", "V$", x))
    
    for (j in 1:length(samples)){
        df.temp = df.all.files[df.all.files$contrast == samples[j],]
        df.temp = df.temp[,c("cat_names", "image_link")]
        names(df.temp) = c("cat_names", paste(samples[j], "_image_link", sep=""))
        enriched.categories = unique(merge(enriched.categories, df.temp, by.x = "NAME", by.y = "cat_names", all=TRUE))
        write.table(enriched.categories, "temp.file.txt", row.names=FALSE, sep="\t")
        enriched.categories = read.delim("temp.file.txt", header=TRUE, sep="\t", stringsAsFactors = FALSE)
        enriched.categories[is.na(enriched.categories)] = ""
    }
    
    
    setwd(GSEADir)
    if (dir.exists(outputDir)){
        setwd(outputDir)
    } else if (outputDir != ""){
        dir.create(outputDir)
        if (dir.exists(outputDir)){
            setwd(outputDir)
        }
    }
    
    
    
    write.table(enriched.categories, paste0(project.code, ".enriched.categories.txt"), row.names=FALSE, sep="\t")
    df1 = read.delim(paste0(project.code, ".enriched.categories.txt"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
    df1[is.na(df1)] = ""
    df1[["enrichment_type"]] = "GSEA"
    names(df1)[grep("NAME", names(df1))] = "cat_name"
    
    #names(df1)[grep("FDR.q.val", names(df1))] = "FDR_q_val"
    df1 = df1[df1$cat_id != "",]
    write.table(df1, paste0(project.code, ".enriched.categories.txt"), row.names=FALSE, sep="\t")
    
    #df1[df1$FDR_q_val == 0, "FDR_q_val"] = 0.0001
    
    df.enriched = df1
    
    #Upload to database
    
    ##############################################
    # Create score column for ordering columns
    ##############################################
    padj.cols <- names(df.enriched)[grep("padj", names(df.enriched))]
    if (length(padj.cols) > 0){
        df.enriched[["gsea_display_score"]] <- as.numeric(df.enriched[,padj.cols[1]])
        if (length(padj.cols) > 1){
            for (l in 2:length(padj.cols)){
                df.enriched[,"gsea_display_score"] <- as.numeric(df.enriched[,"gsea_display_score"]) + as.numeric(df.enriched[,padj.cols[l]])  
            }
            
        }
    }
    
    df.enriched[["row_names"]] = 1:nrow(df.enriched)
    
    image.link.vector = names(df.enriched)[grep("image_link", names(df.enriched))]
    padj.vector = names(df.enriched)[grep("padj", names(df.enriched))]
    NES.vector = names(df.enriched)[grep("NES", names(df.enriched))]
    
    df.enriched <- unique(df.enriched)
    
    upload.datatable.to.database(
        host = host, 
        user = db.user,
        password = db.pwd,
        prim.data.db = "enriched_categories",
        dbTableName = refDBTableName,
        df.data = df.enriched,
        db.col.parameter.list = list(
            "VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("cat_name", "comments_1", "comments_2",image.link.vector),
            "VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("cat_id", "cat_type","data_source"),
            "VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci" = c("enrichment_type"),
            "BIGINT(8) NULL DEFAULT NULL" = c("row_names"),
            "INT(5) NULL DEFAULT NULL" = c("cat_item_size"),
            "DECIMAL(6,3) NULL DEFAULT NULL" = c("gsea_display_score", NES.vector),
            "DECIMAL(9,8) NULL DEFAULT NULL"= padj.vector
        ),
        increment = 5000,
        new.table = TRUE,
        first.row.name.index = 1
    )
    
    
    # End upload to database
    
    # Create vector with parameters for ini file
    ###############################################################################
    # The section below needs to relocate to create.parameters                    #
    ###############################################################################
    ###########################
    #Create display parameters#
    ###########################
    gsea.cat.lines <- "#################"
    gsea.cat.lines <- append(gsea.cat.lines, "#GSEA Parameters#")
    gsea.cat.lines <- append(gsea.cat.lines, "#################")
    gsea.cat.lines <- append(gsea.cat.lines, paste('$enriched_categories_table="',refDBTableName,'";', sep=""))
    enriched.cols = paste(NES.vector, collapse ="','")
    enriched.cols = paste("$enriched_padj_cols = array('", enriched.cols, "');", sep="")
    gsea.cat.lines <- append(gsea.cat.lines, enriched.cols)
    image.link.array <- paste(image.link.array, collapse = "', '")
    image.link.array <- paste0("$image_link_array = array('",image.link.array,"');")
    gsea.cat.lines <- append(gsea.cat.lines, image.link.array)
    return(gsea.cat.lines) 
}

## End of function                                                           ##
###############################################################################

###############################################################################
## (2B) createSettingsFile()                                                 ##

createSettingsFile <- function(
    obj = "object",
    df.data = 'database.table',
    defaultXcolName = NULL,
    defaultYcolName = NULL,
    timepointName = NULL,
    sample.order = "names(database.table)[grep('norm_counts', names(databse.table))]", #set to "" to go with default sorting
    heatmapSampleOrder = "lg2_avg vec",
    sample.names = "", # default is sample.order
    count.sample.colors = 'rainbow(length(sample.order))',
    ptm.colum = "display_ptm",
    count.table.headline = "PTM ratio H/L counts for all samples",
    count.table.sidelabel = "Counts",
    venn.slider.selector.strings = 'c("contrast_x_logFC", "constrast_x_padj")',
    plot.selection.strings = 'c(
    "_logFC", 
    "_PCA_",
    "_lg10p"
)',
    webSiteDir = "/camp/stp/babs/working/boeings/Stefan/protocol_files/github/biologic/src/experiments",
    upper_heatmap_limit = 3, 
    lower_heatmap_limit = -3,
    heamap.headline.text = "heamap.headline.text",
    project_id = "project_id",
    primDataTable = "p123_rna_seq_table",
    pcaDbTable = NULL,
    pointer = "Gene Symbol:"
    ){
    
    ###############################################################################
    ## Create timecourse string from dfDesign                                    ##
    
    createTSparams <- function(
        dfDesign = Obio@dfDesign,
        timepointName = "Timepoint"
    ) {
        
        tsOrder <- as.numeric(sort(unique(dfDesign$timepoint)))
        scriptVec <- as.vector(NULL, mode = "character")
        scriptVec <- c(
            scriptVec,
            "// New Begin: Timecourse",
            "'timecourse_chart' => array(",  
            "    'timepoint_name' => 'Day',",
            "    'display_median' => 'calculate_median',",
            paste0("    'timepoint_array' => array(", paste(tsOrder, collapse = ","),"),"),
            "    'datasets' => array("
        )
        
        
        if (length(grep("dataseries_order", names(dfDesign))) > 0){
            if (length(grep("ts_color", names(dfDesign))) > 0){
                dfO <- unique(dfDesign[,c("dataseries", "dataseries_order","ts_color")])
                dfO <- dfO[order(dfO$dataseries_order, decreasing = F),]
                dataseriesVec <- as.vector(dfO$dataseries)
                dataseriesColVec <- as.vector(dfO$ts_color)
            } else {
                dfO <- unique(dfDesign[,c("dataseries", "dataseries_order")])
                dfO <- dfO[order(dfO$dataseries_order, decreasing = F),]
                dataseriesVec <- as.vector(dfO$dataseries)
                dataseriesColVec <- rainbow(length(dataseriesVec))
            }
            
            
        } else {
            if (length(grep("ts_color", names(dfDesign))) > 0){
                dfO <- unique(dfDesign[,c("dataseries", "ts_color")])
                dfO <- dfO[order(dfO$dataseries, decreasing = F),]
                dataseriesVec <- as.vector(dfO$dataseries)
                dataseriesColVec <- as.vector(dfO$ts_color)
            } else {
                dataseriesVec <- sort(unique(dfDesign$dataseries))
                dataseriesColVec <- rainbow(length(dataseriesVec))
            }
        }
        
        
        
        for (i in 1:length(dataseriesVec)){
            dfTemp <- unique(
                dfDesign[dfDesign$dataseries == dataseriesVec[i], c("sample.id", "dataseries", "sample.group", "timepoint")]
            )
            
            dfTemp <- dfTemp[order(dfTemp$timepoint, decreasing = F),]
            timepointVec <- unique(dfTemp$timepoint)
            sampleGroupVec <- unique(dfTemp$sample.group)
            
            scriptVec <- c(
                scriptVec,
                paste0("'",dataseriesVec[i],"' => array("),
                paste0("    'color' => '",dataseriesColVec[i],"',"),
                paste0("    'sample_group' => array(")
            )
            
            for (j in 1:length(sampleGroupVec)){
                dfTemp3 <- unique(dfDesign[dfDesign$sample.group %in% sampleGroupVec, c(timepointName, "sample.group")])
                dfTemp3 <- dfTemp3[order(dfTemp3[,timepointName], decreasing = F),]
                timepointVec <- as.numeric(dfTemp3[,timepointName])
                
                dfTemp2 <- unique(dfTemp[dfTemp$sample.group == sampleGroupVec[j],])
                scriptVec <- c(
                    scriptVec,
                    paste0("'",sampleGroupVec[j],"' => array("),
                    paste0("    'timepoint' =>  ",timepointVec[j],","),
                    paste0("    'sampleDbCols' =>  array("),
                    
                    paste0(
                        sampleCols <- paste0("'norm_counts_", sort(dfTemp2$sample.id), "_TPM'"),
                        collapse = ","
                    ),
                    
                    ")),"
                )
            }
            scriptVec[length(scriptVec)] <- gsub(")),", ")))),",scriptVec[length(scriptVec)])
        }
        
        scriptVec[length(scriptVec)] <- gsub(",", ")),",scriptVec[length(scriptVec)])
        
        scriptVec <- c(
            scriptVec,
            
            "// New End: Timecourse"
        )
        
        
        
        return(scriptVec)
        
    }
    
    ## Create timecourse string                                                  ##
    ###############################################################################
    
    
    if (sample.order[1] == "" | is.na(sample.order[1])){
        sample.order <- sort(names(database.table)[grep("norm_counts_", names(database.table))])
    }
    
    if (count.sample.colors[1] == "" | is.na(count.sample.colors[1])){
        count.sample.colors <- rainbow(length(sample.order))
    }
    
    if (sample.names[1] == "" | is.na(sample.names[1])){
        sample.names <- gsub("norm_counts_", "", sample.order)
        sample.names <- gsub("_", " ", sample.names)
    }
    
    settingsPhpVec <- c(
        "<?php",
        "",
        "return array(",
        "    'lab' => array(",
        paste0("        'name' => '",obj@parameterList$labname," DB'"),
        "    ),",
        "",
        "    /*",
        "    * Experiment settings",
        "    */",
        paste0("    'data_db_name' => '",obj@dbDetailList$primDataDB,"',"),
        "    'data_db' => array(",
        paste0("            'cat_table_name' => '",obj@parameterList$cat.ref.db.table,"'"),
        "    ),",
        "",
        paste0("    'rnaseq_db_table' => '",obj@parameterList$rnaseqdbTableName,"',"),
        paste0("    'primary_gene_symbol' => '",obj@parameterList$geneIDcolumn,"',"),
        paste0("    'ptm_display_column' => '",obj@parameterList$displayPTMcolumn,"',"),
        "",
        "    'heatmap' => array(",
        paste0("        'upper_limit' => ",upper_heatmap_limit,","),
        paste0("        'lower_limit' => ",lower_heatmap_limit,","),
        paste0("        'headline' => '",obj@parameterList$heamap.headline.text,"',"),
        paste0("        'pointer' => '",pointer,"'"),
        "    ),",
        ""
    )
    
    ## Add sample array ##
    settingsPhpVec <- c(
        settingsPhpVec,
        "    'samples' => array("
    )
    
    for (i in 1:length(sample.order)){
        settingsPhpVec <- c(
            settingsPhpVec,
            paste0("        '",sample.order[i],"' => array("),
            paste0("            'color' => '",sample.colors[i],"',"),
            paste0("            'name' => '",sample.names[i],"'"),
            "        )"
        )
        if (i < length(sample.order)){    
            settingsPhpVec[length(settingsPhpVec)] <- paste0(
                settingsPhpVec[length(settingsPhpVec)], ","
            )
        }
    }
    settingsPhpVec <- c(
        settingsPhpVec,
        "    ), // End samples array"
    )
    
    ## Done adding samples ##
    
    ## Adding barchart parameters ##
    settingsPhpVec <- c(
        settingsPhpVec,
        "    // bar chart",
        "    'count_table' => array(",
        paste0("        'headline' => '", obj@parameterList$count.table.headline,"',"),
        paste0("        'sidelabel' => '", obj@parameterList$count.table.sidelabel,"'"),
        "    ),"
    )
    ## Done adding barchart parameters ##
    
    ## Adding timecourse parameters ##
    if (!is.null(timepointName)){
        tempVec <- createTSparams(
            dfDesign = Obio@dfDesign, 
            timepointName = timepointName
        )
        
        settingsPhpVec <- c(
            settingsPhpVec,
            tempVec
        )
    }
    
    ## Done adding timecourse parameters ##
    
    
    ## Adding Venn section ##
    if (heatmapSampleOrder[1] == ""){
        heatmapSampleOrder <- names(df.data)[grep("lg2_avg", names(df.data))]
    } 
    
    heatMapString <- paste(heatmapSampleOrder, collapse = "','")
    heatMapString <- paste0("'", heatMapString,"'")
    
    settingsPhpVec <- c(
        settingsPhpVec,
        "    // Venn Diagram Parameters",
        "    'venn' => array(",
        paste0("        'experiments' => array(", heatMapString,"),"),
        "",
        "    'table' => array(",
        "        'col_name_start' => 11,",
        "        'low_highlight' => -1,",
        "        'high_highlight' => 1",
        "    ),",
        "",
        "    'selection' => array("
    )
    
    vennCols <- as.vector(NULL, mode = "character")
    
    ## Make sure all venn cols are numeric ##
    df.data[,vennCols] <- apply(df.data[,vennCols], 2, as.numeric)
    
    for (i in 1:length(venn.slider.selector.strings)){
        vennCols <- c(
            vennCols,
            names(df.data)[grep(venn.slider.selector.strings[i], names(df.data))]
        )
    }
    
    for (i in 1:length(vennCols)){
        colMax <- ceiling(max(as.numeric(df.data[,vennCols[i]]), na.rm = TRUE))
        colMin <- floor(min(as.numeric(df.data[,vennCols[i]]), na.rm = TRUE))
        
        Vname <- vennCols[i]
        Vname <- substr(Vname ,11,100)
        Vname <- gsub("^_", "", Vname)
        Vname <- gsub("_", " ", Vname)
        
        if (is.numeric(colMax) & is.numeric(colMin)){
            settingsPhpVec <- c(
                settingsPhpVec,
                paste0("        '",vennCols[i],"' => array("),
                paste0("            'name' => '",Vname,"',"),
                paste0("            'slider_min' => ", colMin,","),
                paste0("            'slider_max' => ", colMax,","),
                paste0("            'default_low' => ", colMin,","),
                paste0("            'default_high' => ", colMax,""),
                "        )"
            )
        }
        
        if (i < length(vennCols)){
            settingsPhpVec[length(settingsPhpVec)] <- paste0(
                settingsPhpVec[length(settingsPhpVec)], ","
            )
        }
        
        
    }
    
    settingsPhpVec <- c(
        settingsPhpVec,
        "    )",  ## Done with venn array 
        "    )," ## Done with venn array 
    )
    ## Done adding Venn section
    
    ## Adding scatterplot ##
    scatterCols <- as.vector(NULL, mode = "character")
    for (i in 1:length(plot.selection.strings)){
        scatterCols <- c(
            scatterCols,
            names(df.data)[grep(plot.selection.strings[i], names(df.data))]
        )
    }
    
    if (!is.null(pcaDbTable)){
        settingsPhpVec <- c(
            settingsPhpVec,
            "    // Scatterplot Parameters",
            paste0("'pca' => '", pcaDbTable, "',")
        )
    }
    
    if (length(scatterCols) > 0){
        
        if (is.null(defaultXcolName)){
            defaultXcolName <- scatterCols[1]
        }
        
        if (is.null(defaultYcolName)){
            defaultXcolName <- scatterCols[2]
        }
        
        settingsPhpVec <- c(
            settingsPhpVec,
            "    // Scatterplot Parameters",
            "    'scatterplot' => array(",
            paste0("        'default-x' => '",defaultXcolName,"',"),
            paste0("        'default-y' => '",defaultYcolName,"',"),
            "        'selection' => array("
            
        )
        
        for (i in 1:length(scatterCols)){
            Sname <- scatterCols[i]
            Sname <- substr(Sname ,11,100)
            Sname <- gsub("^_", "", Sname)
            Sname <- gsub("_", " ", Sname)
            
            settingsPhpVec <- c(
                settingsPhpVec,
                paste0("            '",scatterCols[i],"' => array("),
                paste0("                'name' => '",Sname,"'"),
                "            )"
            )
            
            if (i < length(scatterCols)){
                settingsPhpVec[length(settingsPhpVec)] <- paste0(
                    settingsPhpVec[length(settingsPhpVec)], ","
                )
            }
            
            
        }
        
        settingsPhpVec <- c(
            settingsPhpVec,
            "        )", # close scatterplot selection array
            "    )", # close scatterplot  array
            "//End scatterplot" # close scatterplot  array
        )
    }
    
    ## Done adding scatterplot ##
    
    ## End of file ##
    settingsPhpVec <- c(
        settingsPhpVec,
        ");"
    )
    
    ###########################################################################
    ## Create settings.php file                                              ##
    setwd(webSiteDir)
    if (!dir.exists(project_id)){
        dir.create(project_id)
    }
    
    
    if (substr(webSiteDir, nchar(webSiteDir), nchar(webSiteDir)) != "/"){
        webSiteDir <- paste0(
            webSiteDir,
            "/"
        )
    }
    
    FN <- paste0(
        webSiteDir,
        project_id,
        "/settings.php"
    )
    
    sink(FN)
    for (i in 1:length(settingsPhpVec)){
        cat(settingsPhpVec[i]); cat("\n")
    }
    sink()
    
    ## Done creating settings.php file                                       ##
    ###########################################################################
}

## End: createSettingsFile()                                                 ##
###############################################################################

###############################################################################
##                                                                           ##
###############################################################################
##

createSeuratSettingsFile <- function(
    #obj = "object",
    labname = "labname",
    prim.data.db = "primDataDB",
    cat.ref.db.table = "cat.ref.db.table",
    rnaseqdbTableName = "rnaseqdbTableName",
    geneIDcolumn = "geneIDcolumn",
    displayPTMcolumn = "",
    heatmap.headline.text = "Heatmap",
    count.table.headline = "",
    count.table.sidelabel = "", 
    df.data = 'database.table',
    defaultXcolName = NULL,
    defaultYcolName = NULL,
    sample.order = "names(database.table)[grep('norm_counts', names(databse.table))]", #set to "" to go with default sorting
    heatmapSampleOrder = "lg2_avg vec",
    sample.names = "", # default is sample.order
    count.sample.colors = 'rainbow(length(sample.order))',
    ptm.colum = "display_ptm",
    venn.slider.selector.strings = 'c("contrast_x_logFC", "constrast_x_padj")',
    plot.selection.strings = 'c(
    "_logFC", 
    "_PCA_",
    "_lg10p"
)',
    webSiteDir = "/camp/stp/babs/working/boeings/Stefan/protocol_files/github/biologic/src/experiments",
    upper_heatmap_limit = 3, 
    lower_heatmap_limit = -3,
    heamap.headline.text = "heamap.headline.text",
    project_id = "project_id",
    primDataTable = "p123_rna_seq_table",
    pcaDbTable = NULL,
    pointer = "Gene Symbol:"
){
    if (sample.order[1] == "" | is.na(sample.order[1])){
        sample.order <- sort(names(database.table)[grep("norm_counts_", names(database.table))])
    }
    
    if (count.sample.colors[1] == "" | is.na(count.sample.colors[1])){
        count.sample.colors <- rainbow(length(sample.order))
    }
    
    if (sample.names[1] == "" | is.na(sample.names[1])){
        sample.names <- gsub("norm_counts_", "", sample.order)
        sample.names <- gsub("_", " ", sample.names)
    }
    
    settingsPhpVec <- c(
        "<?php",
        "",
        "return array(",
        "    'lab' => array(",
        paste0("        'name' => '",labname," DB'"),
        "    ),",
        "",
        "    /*",
        "    * Experiment settings",
        "    */",
        paste0("    'data_db_name' => '",primDataDB,"',"),
        "    'data_db' => array(",
        paste0("            'cat_table_name' => '",cat.ref.db.table,"'"),
        "    ),",
        "",
        paste0("    'rnaseq_db_table' => '",rnaseqdbTableName,"',"),
        paste0("    'primary_gene_symbol' => '",geneIDcolumn,"',"),
        paste0("    'ptm_display_column' => '",displayPTMcolumn,"',"),
        "",
        "    'heatmap' => array(",
        paste0("        'upper_limit' => ",upper_heatmap_limit,","),
        paste0("        'lower_limit' => ",lower_heatmap_limit,","),
        paste0("        'headline' => '",heamap.headline.text,"',"),
        paste0("        'pointer' => '",pointer,"'"),
        "    ),",
        ""
    )
    
    ## Add sample array ##
    settingsPhpVec <- c(
        settingsPhpVec,
        "    'samples' => array("
    )
    
    for (i in 1:length(sample.order)){
        settingsPhpVec <- c(
            settingsPhpVec,
            paste0("        '",sample.order[i],"' => array("),
            paste0("            'color' => '",sample.colors[i],"',"),
            paste0("            'name' => '",sample.names[i],"'"),
            "        )"
        )
        if (i < length(sample.order)){    
            settingsPhpVec[length(settingsPhpVec)] <- paste0(
                settingsPhpVec[length(settingsPhpVec)], ","
            )
        }
    }
    settingsPhpVec <- c(
        settingsPhpVec,
        "    ), // End samples array"
    )
    
    ## Done adding samples ##
    
    ## Adding barchart parameters ##
    settingsPhpVec <- c(
        settingsPhpVec,
        "    // bar chart",
        "    'count_table' => array(",
        paste0("        'headline' => '", count.table.headline,"',"),
        paste0("        'sidelabel' => '", count.table.sidelabel,"'"),
        "    ),"
    )
    ## Done adding barchart parameters ##
    
    ## Adding Venn section ##
    if (heatmapSampleOrder[1] == ""){
        heatmapSampleOrder <- names(df.data)[grep("lg2_avg", names(df.data))]
    } 
    
    heatMapString <- paste(heatmapSampleOrder, collapse = "','")
    heatMapString <- paste0("'", heatMapString,"'")
    
    settingsPhpVec <- c(
        settingsPhpVec,
        "    // Venn Diagram Parameters",
        "    'venn' => array(",
        paste0("        'experiments' => array(", heatMapString,"),"),
        "",
        "    'table' => array(",
        "        'col_name_start' => 11,",
        "        'low_highlight' => -1,",
        "        'high_highlight' => 1",
        "    ),",
        "",
        "    'selection' => array("
    )
    
    vennCols <- as.vector(NULL, mode = "character")
    
    ## Make sure all venn cols are numeric ##
    df.data[,vennCols] <- apply(df.data[,vennCols], 2, as.numeric)
    
    for (i in 1:length(venn.slider.selector.strings)){
        vennCols <- c(
            vennCols,
            names(df.data)[grep(venn.slider.selector.strings[i], names(df.data))]
        )
    }
    
    for (i in 1:length(vennCols)){
        colMax <- ceiling(max(as.numeric(df.data[,vennCols[i]]), na.rm = TRUE))
        colMin <- floor(min(as.numeric(df.data[,vennCols[i]]), na.rm = TRUE))
        
        Vname <- vennCols[i]
        Vname <- substr(Vname ,11,100)
        Vname <- gsub("^_", "", Vname)
        Vname <- gsub("_", " ", Vname)
        
        if (is.numeric(colMax) & is.numeric(colMin)){
            settingsPhpVec <- c(
                settingsPhpVec,
                paste0("        '",vennCols[i],"' => array("),
                paste0("            'name' => '",Vname,"',"),
                paste0("            'slider_min' => ", colMin,","),
                paste0("            'slider_max' => ", colMax,","),
                paste0("            'default_low' => ", colMin,","),
                paste0("            'default_high' => ", colMax,""),
                "        )"
            )
        }
        
        if (i < length(vennCols)){
            settingsPhpVec[length(settingsPhpVec)] <- paste0(
                settingsPhpVec[length(settingsPhpVec)], ","
            )
        }
        
        
    }
    
    settingsPhpVec <- c(
        settingsPhpVec,
        "    )",  ## Done with venn array 
        "    )," ## Done with venn array 
    )
    ## Done adding Venn section
    
    ## Adding scatterplot ##
    scatterCols <- as.vector(NULL, mode = "character")
    for (i in 1:length(plot.selection.strings)){
        scatterCols <- c(
            scatterCols,
            names(df.data)[grep(plot.selection.strings[i], names(df.data))]
        )
    }
    
    if (!is.null(pcaDbTable)){
        settingsPhpVec <- c(
            settingsPhpVec,
            "    // Scatterplot Parameters",
            paste0("'pca' => '", pcaDbTable, "',")
        )
    }
    
    if (length(scatterCols) > 0){
        
        if (is.null(defaultXcolName)){
            defaultXcolName <- scatterCols[1]
        }
        
        if (is.null(defaultYcolName)){
            defaultXcolName <- scatterCols[2]
        }
        
        settingsPhpVec <- c(
            settingsPhpVec,
            "    // Scatterplot Parameters",
            "    'scatterplot' => array(",
            paste0("        'default-x' => '",defaultXcolName,"',"),
            paste0("        'default-y' => '",defaultYcolName,"',"),
            "        'selection' => array("
            
        )
        
        for (i in 1:length(scatterCols)){
            Sname <- scatterCols[i]
            Sname <- substr(Sname ,11,100)
            Sname <- gsub("^_", "", Sname)
            Sname <- gsub("_", " ", Sname)
            
            settingsPhpVec <- c(
                settingsPhpVec,
                paste0("            '",scatterCols[i],"' => array("),
                paste0("                'name' => '",Sname,"'"),
                "            )"
            )
            
            if (i < length(scatterCols)){
                settingsPhpVec[length(settingsPhpVec)] <- paste0(
                    settingsPhpVec[length(settingsPhpVec)], ","
                )
            }
            
            
        }
        
        settingsPhpVec <- c(
            settingsPhpVec,
            "        )", # close scatterplot selection array
            "    )", # close scatterplot  array
            "//End scatterplot" # close scatterplot  array
        )
    }
    
    ## Done adding scatterplot ##
    
    ## End of file ##
    settingsPhpVec <- c(
        settingsPhpVec,
        ");"
    )
    
    ###########################################################################
    ## Create settings.php file                                              ##
    setwd(webSiteDir)
    if (!dir.exists(project_id)){
        dir.create(project_id)
    }
    
    
    if (substr(webSiteDir, nchar(webSiteDir), nchar(webSiteDir)) != "/"){
        webSiteDir <- paste0(
            webSiteDir,
            "/"
        )
    }
    
    FN <- paste0(
        webSiteDir,
        project_id,
        "/settings.php"
    )
    
    sink(FN)
    for (i in 1:length(settingsPhpVec)){
        cat(settingsPhpVec[i]); cat("\n")
    }
    sink()
    
    ## Done creating settings.php file                                       ##
    ###########################################################################
}


##
###############################################################################

##                                                                           ##
###############################################################################

###############################################################################
## (20) Function add2labCatSelectionDBtable()                                ##
##                                                                           ##

add2labCatSelectionDBtable <- function (
    df.ref = "reference table",
    cat_group_name = "Tybulewicz lab",
    reference.gene.vector = "reference gene vector",
    ref.gene.vec.id = "hgnc_symbol",
    cat_views = NA
){
    sel.vec = c(
        "cat_name",  
        "cat_id",
        "hgnc_symbol",
        "mgi_symbol",
        "cat_item_size",
        "comments_1"
    )
    
    df.ref <- unique(df.ref[,sel.vec])
    df.ref[["cat_group"]] = cat_group_name
    df.ref[["cat_count"]] = 0
    df.ref[["cat_weight"]] = 0
    df.ref[["cat_views"]] = 0
    
    for (i in 1:nrow(df.ref)){
        gene.vector <- df.ref[i, ref.gene.vec.id]
        gene.vector <- unlist(strsplit(gene.vector, ";"))
        
        ## Remove numeric values if present e.g. gene_name(1.0)
        gene.vector <- sapply(gene.vector, function(x) unlist(strsplit(x, "\\("))[1])
        gene.vector <- as.vector(na.omit(gene.vector))
        gene.vector <- gene.vector[gene.vector != ""]
        a = sum(relevant.genes %in% gene.vector)
        b = sum(toupper(relevant.genes) %in% gene.vector)
        if (a >= b){
            df.ref[i, "cat_count"] = a
        } else {
            df.ref[i, "cat_count"] = b
        }
    }
    if (i%%100 == 0){
        print(cat(i))
    }
    
    df.ref[df.ref$cat_item_size > 0, "cat_weight"] <- round(
        df.ref[df.ref$cat_item_size > 0, "cat_count"]/
            df.ref[df.ref$cat_item_size > 0, "cat_item_size"],
        2
    )
    
    df.ref$hgnc_symbol <- NULL
    df.ref$mgi_symbol <- NULL
    return(df.ref)
}

## End Function add2labCatSelectionDBtable()                                 ##
###############################################################################

###############################################################################
## (2) Create.website.parameters                                             ##
###############################################################################
create.website.parameters <- function(
    df.data,
    gene.id.column = "hgnc_symbol",
    ptm.colum = "display_ptm",
    lab_id = "st_lab",
    user_ids = c("project", "st_lab_all", "thomas.mercer"),
    project_id = "stl1",
    download_result_table = "20160823.logFC.datatable.txt",
    download_cat_enrichment_table = "p50.interesting.categories.txt",
    database = "stl_data",
    reference_categories_db = "reference_categories_db_new",
    labname = "Tooze",
    rnaseqdbTableName,
    lab.categories.table = "st_lab_categories",
    sample.order = names(df.data)[grepl("norm_counts_",names(df.data))], 
    #set to "" to go with default sorting
    count.sample.colors = "",
    count.table.headline = "PTM ratio H/L counts for all samples",
    count.column.chart.x.axis.label = "hrs",
    count.table.sidelabel = "Counts",
    webSiteDir = "C:/xampp/htdocs/",
    heamap.headline.text = "log2FC(SILAC) Heatmap",
    upper_heatmap_limit = 3, 
    lower_heatmap_limit = -3,
    slider.selection.name = "logFC",
    presentation.file = "",
    number_of_slides = "",
    default.sequence = "_____ARK_______",
    use.logFC.columns.for.heatmap = FALSE,
    peptide.view.link = "",
    create.2d.scatterplot.button =FALSE,
    low_highlight = -1,
    high_highlight =1,
    display.qc = FALSE,
    display.pca = FALSE,
    display.report = FALSE,
    pca.table.name = "",
    gsea.cat.lines = NA,
    timecourse.cat.lines = NA,
    venn.slider.selector.strings = c("contrast_x_logFC", "constrast_x_padj"),
    plot.selection.strings = NA, #strings to grep from col names for plot display
    plate.view.db.table = NA,
    plate.view.column.vec = NA,
    cat.seletion.table.vec = c(
        "reference_categories_db_new", 
        "cat_selection_default",
    ),
    localhost = "localhost",
    createOutputFile = TRUE
){
    
    #############################################################################
    ## Create login.ini.php                                                    ##
    #############################################################################
    
    setwd(webSiteDir)
    dirExist = length(grep(paste0("^",project_id,"$"), list.files()))
    
    if (dirExist == 0){
        dir.create(paste(webSiteDir, project_id, sep=""))
    }
    
    ## Create outputs ##
    setwd(paste(webSiteDir, project_id, sep=""))
    dirExist = length(grep("outputs", list.files()))
    
    if (dirExist == 0){
        dir.create(paste(webSiteDir, project_id, "/outputs", sep=""))
    }
    
    
    
    #############################################################################
    ## Create start.ini.php#########                                           ##
    #############################################################################
    
    # sink(file = "start.ini.php")
    # cat('<?php');cat("\n"); cat("\n");
    # cat(paste0('$host ="',localhost,'";'));cat("\n"); 
    # cat('$user = "logincheck";');cat("\n"); 
    # cat('$pwd = "O2ktmuTHqx7V";');cat("\n"); 
    # cat('$location = "search.result.php";');cat("\n"); 
    # cat(paste('$lab_id = "', lab_id,'";', sep=""));cat("\n"); 
    # cat(paste('$project_id = "', project_id,'";', sep=""));cat("\n"); 
    # #Create user array
    # user.array = '$user_id_array = array('
    # for (i in 1:length(user_ids)){
    #   user.array = paste(user.array, '"',user_ids[i], '", ', sep="")
    # }
    # 
    # user.array = substr(user.array, 1, nchar(user.array)-2)
    # user.array = paste(user.array, ');', sep="")
    # cat(user.array);cat("\n"); cat("\n");    
    # cat('?>');cat("\n"); cat("\n");
    # sink()
    
    ## Done with start ini                                                     ##
    #############################################################################          
    
    #############################################################################
    ## Create output table                                                     ##
    df.output <- df.data
    df.output$row_names <- NULL
    df.output$row_id <- NULL
    df.output$for_GSEA_gene_chip <- NULL
    df.output$entrezgene <- NULL
    df.output$associated_gene_name <- NULL
    df.output$cluster_order <- NULL
    df.output$cluster_id <- NULL
    names(df.output) <- gsub("contrast_1_", "", names(df.output))
    names(df.output) <- gsub("contrast_2_", "", names(df.output))
    names(df.output) <- gsub("contrast_3_", "", names(df.output))
    names(df.output) <- gsub("contrast_4_", "", names(df.output))
    names(df.output) <- gsub("contrast_5_", "", names(df.output))
    names(df.output) <- gsub("contrast_6_", "", names(df.output))
    names(df.output) <- gsub("contrast_7_", "", names(df.output))
    names(df.output) <- gsub("contrast_8_", "", names(df.output))
    names(df.output) <- gsub("contrast_9_", "", names(df.output))
    names(df.output) <- gsub("contrast_x_", "", names(df.output))
    names(df.output) <- gsub("contrast_X_", "", names(df.output))
    
    pos <- grep("lg2_avg", names(df.output))
    if (length(pos)> 0){
        df.output <- df.output[,-pos]
    }
    df.output <- unique(df.output)
    ## Done creating output table                                              ##
    #############################################################################
    
    ## Check if outputs folder needs to be made ##
    if (length(grep("outputs/", download_result_table)) > 0){
        if (!dir.exists("outputs")){
            dir.create("outputs")
        }
    }
    
    if (createOutputFile){
        write.table(
            df.output, paste0(
                download_result_table, 
                ".txt"
            ), 
            row.names=FALSE, 
            sep="\t"
        )
    }
    
    print(
        paste0(
            "Convert ", 
            paste0(download_result_table, 
                   ".txt"
            ), 
            " to .xlsx."
        )
    )            
    
    
    #############################################################################
    ## Create layout.ini.php                                                   ##
    
    sink(file = "layout.ini.php")
    cat('<?php');cat("\n"); cat("\n");
    cat('######################################');cat("\n");
    cat('#Basic Parameters                    #');cat("\n");
    cat('######################################');cat("\n");
    
    cat('######################################');cat("\n");
    cat('##Set pwd                           ##');cat("\n");
    cat('if (file_exists("distii/dist.txt")){');cat("\n");
    cat('    $fh = fopen("distii/dist.txt", "r");');cat("\n");
    cat('    $pwd = fgets($fh);');cat("\n");
    cat('    fclose($fh);');cat("\n");
    cat(paste0(    '$host ="',localhost,'";'));cat("\n");
    cat('} else if (file_exists("../../util/babs_db.php")){');cat("\n");
    cat("    require_once('../../util/babs_db.php');");cat("\n");
    cat(paste0('    $host ="clvd0-db-u-t-08.thecrick.test";'));cat("\n");
    cat('} else {');cat("\n");
    cat('    echo "Error: Database password could not be established.";');cat("\n");
    cat('}');cat("\n");
    cat('######################################');cat("\n");
    cat('$user = "biologic_website";');cat("\n");
    cat(paste('$database = "',database,'";', sep=''));cat("\n");
    cat(paste('$lab_id = "', lab_id,'";', sep=""));cat("\n"); cat("\n");
    cat(paste('$project_id = "', project_id,'";', sep=""));cat("\n"); cat("\n");
    #Create user array
    ##
    ## Get user array from db ##
    user.array = '          $user_id_array = array('
    for (i in 1:length(user_ids)){
        user.array = paste(user.array, '"',user_ids[i], '", ', sep="")
    }
    
    user.array = substr(user.array, 1, nchar(user.array)-2)
    user.array = paste(user.array, ');', sep="")
    
    
    cat("#if (!isset($_SESSION['userArray'])){");cat("\n");
    cat('#    $userSQLquery = "SELECT DISTINCT experiment_viewers FROM project_db_table WHERE experiment_id = :project_name";');cat("\n");
    cat('#    $userArray = query_db(');cat("\n");
    cat('#        $sql_query = $userSQLquery,');cat("\n");
    cat('#        $host= $host,');cat("\n");
    cat('#        $user= $user,');cat("\n");
    cat('#        $pwd= $pwd,');cat("\n");
    cat('#        $dbname="reference_categories_db_new",');cat("\n");
    cat("#        $bindParam_name_array = array(':project_name'),");cat("\n");
    cat('#        $bindParam_value_array = array($project_id)');cat("\n");
    cat('#    );');cat("\n");
    cat("#\n");
    cat('#      if (!empty($userArray)){');cat("\n");
    cat('#         $row = $userArray[0];');cat("\n");
    cat('#         extract($row);');cat("\n");
    cat('#         $experiment_viewers = trim($experiment_viewers, ";");');cat("\n");
    cat('#         $user_id_array = explode(";", $experiment_viewers);');cat("\n");
    cat('#      } else {');cat("\n");
    cat(user.array);cat("\n"); cat("\n");
    cat('#      }');cat("\n");
    cat('#}');cat("\n");cat("\n");cat("\n");
    ##
    
    
    
    
    
    
    
    cat(paste('$labname="',labname, '";',sep=''));cat("\n");
    cat(paste('$primary_gene_symbol = "', gene.id.column, '";', sep="")); cat("\n");
    if (gene.id.column == "hgnc_symbol"){
        cat(paste('$ensembl_id = "ENSG";', sep="")); cat("\n");
    } else {
        cat(paste('$ensembl_id = "ENSMUSG";', sep="")); cat("\n");
    }
    cat(paste('$ptm_display_column = "', ptm.colum, '";', sep="")); cat("\n");
    
    
    if (display.report){
        cat('#########################################');cat("\n");
        cat('## Report                              ##');cat("\n");
        cat('#########################################');cat("\n");
        cat('$display_report = TRUE;');cat("\n");
        cat('$reportDB = "internal_categories";');cat("\n");
        cat('$reportTable = "experiment_reports";');cat("\n");
    }
    
    
    cat('#########################################');cat("\n");
    cat('#Search.result.php                      #');cat("\n");
    cat('#########################################');cat("\n");
    cat(paste('$count_column_chart_x_axis_label = "', count.column.chart.x.axis.label, '";', sep="")); cat("\n");
    cat(paste('$count_column_chart_y_axis_label = "', count.table.sidelabel, '";', sep="")); cat("\n");
    cat('######################################');cat("\n");
    cat('#Table settings                      #');cat("\n");
    cat('######################################');cat("\n");
    cat('$narrow = 299;');cat("\n");
    cat('$wide = 600;');cat("\n");
    all.genes = sort(unique(df.data[,gene.id.column]))
    all.genes = all.genes[all.genes != ""]
    all.genes = paste(all.genes, collapse = "','")
    all.genes = paste("'", all.genes, "'", sep="")
    all.genes = paste('$all_genes = "[', all.genes,']";', sep="")
    cat(all.genes);cat("\n");
    cat(paste0('$low_highlight=' , low_highlight, ';'));cat("\n");
    cat(paste0('$high_highlight=' , high_highlight, ';'));cat("\n");
    cat('$wide = 600;');cat("\n");
    cat('######################################');cat("\n");
    cat('#QC                                  #');cat("\n");
    cat('######################################');cat("\n");
    if (display.qc){
        cat('$display_qc = TRUE;');cat("\n");
    } else {
        cat('$display_qc = FALSE;');cat("\n");
    }
    cat('$wide = 600;');cat("\n");
    cat('######################################');cat("\n");
    cat('#PCA                                  #');cat("\n");
    cat('######################################');cat("\n");
    if (display.pca){
        cat('$display_pca = TRUE;');cat("\n");
        cat(paste0('$pca_db_table ="',pca.table.name,'";'));cat("\n");
    } else {
        cat('$display_pca = FALSE;');cat("\n");
    }
    
    
    cat('$wide = 600;');cat("\n");
    cat('######################################');cat("\n");
    cat('#Other Variables                     #');cat("\n");
    cat('######################################');cat("\n");
    
    cat('$peptide_view_link = "";');cat("\n");
    cat('$display_plate_view = "";');cat("\n");
    cat('$display_ptm = "";');cat("\n");
    
    
    
    cat('######################################');cat("\n");
    cat('#Report                              #');cat("\n");
    cat('######################################');cat("\n");
    if (display.report){
        cat('$display_report = TRUE;');cat("\n");
    } else {
        cat('$display_report = FALSE;');cat("\n");cat("\n");
    }
    
    cat('######################################');cat("\n");
    cat('#Data tables                         #');cat("\n");
    cat('######################################');cat("\n");
    cat(paste('$cat_database = "',reference_categories_db,'";', sep=''));cat("\n");
    cat(paste('$ref_database = "',reference_categories_db,'";', sep=''));cat("\n");
    
    db  = paste('$rnaseq_db_table = "',rnaseqdbTableName, '";', sep='')
    cat(db); cat("\n");
    
    cat(paste('$lab_category_table="',lab.categories.table,'";', sep=""));cat("\n");
    
    cat(paste('$download_result_table = "',download_result_table,'";', sep=''));cat("\n");
    cat(paste('$download_cat_enrichment_table = "',download_cat_enrichment_table,'";', sep=''));cat("\n");
    if (gene.id.column == "mgi_symbol"){
        cat('$taxon_id="10090";'); cat("\n");
    } else if (gene.id.column == "Dmel_symbol"){
        cat('$taxon_id="7227";'); cat("\n");
    } 
    else {
        cat('$taxon_id="9606";'); cat("\n");
    }
    
    cat('########################################');cat("\n");
    cat('#2D plot array                         #');cat("\n");
    cat('########################################');cat("\n");
    
    if (is.na(plot.selection.strings[1])){
        #Create plot selection string
        
        if (ptm.colum == ""){
            string = names(df.data)[grep("contrast", names(df.data))]
        } else {
            string = append(names(df.data[grep("logFC", names(df.data))]), names(df.data[grep("int", names(df.data))]))    
        }
        
        string <- string[string != "logFC_cut_off"]
        ## If present, make contrast_1_logFC and contrast_1_lg10p first entries ##
        posLogFC <- grep("contrast_1_logFC", string)
        posLg10p <- grep("contrast_1_lg10p", string)
        
        if ((length(posLogFC) > 0) & (length(posLg10p) > 0)){
            string <- c(
                string[posLogFC],
                string[posLg10p],
                string
            )
        }
        
        string = paste(string, collapse = "','")
        string = paste("$plot_selection = array('", string, "');", sep="")
        cat(string);cat("\n");
    } else {
        string <- vector(mode="character", length=0)
        for (i in 1:length(plot.selection.strings)){
            string = append(string, names(df.data)[grep(plot.selection.strings[i], names(df.data))])
        }
        
        string <- string[string != "logFC_cut_off"]
        ## If present, make contrast_1_logFC and contrast_1_lg10p first entries ##
        posLogFC <- grep("contrast_1_logFC", string)
        posLg10p <- grep("contrast_1_lg10p", string)
        
        if ((length(posLogFC) > 0) & (length(posLg10p) > 0)){
            string <- c(
                string[posLogFC],
                string[posLg10p],
                string
            )
        }
        
        string = paste(string, collapse = "','")
        string = paste("$plot_selection = array('", string, "');", sep="")
        cat(string);cat("\n");
    }
    
    #Create 2D-scatterplot button
    if (create.2d.scatterplot.button){
        cat("$create_2d_scatterplot_button=TRUE;");cat("\n");
    } 
    
    if (!is.na(plate.view.db.table) & (!is.na(plate.view.column.vec[1]))){
        cat('########################################');cat("\n");
        cat('#Plate View Optons                     #');cat("\n");
        cat('########################################');cat("\n");
        cat(paste0("$display_plate_view = TRUE ;"));cat("\n");
        cat(paste0("$plate_view_db_table ='",plate.view.db.table, "';"));cat("\n");
        
        pv.string <- paste(plate.view.column.vec, collapse = "','")
        pv.string <- paste0("$plate_view_selection = array('", pv.string, "');")
        cat(pv.string);cat("\n");
    }
    
    #Create table.display string
    #The setup below will create a table displaying logFC changes only in the data table
    cat('########################################');cat("\n");
    cat('#Table display array                   #');cat("\n");
    cat('########################################');cat("\n");
    
    string = names(df.data)[grep("contrast", names(df.data))]
    string1 = string[grep("logFC", string)]
    #string2 = string[grep("padj", string)]
    ## Remove LRT padj ##
    
    #string = append(string1, string2)
    string <- string1
    
    string = paste(string, collapse = "','")
    string = paste("$table_display_columns = array('", string, "');", sep="")
    cat(string);cat("\n");
    cat('$col_name_start = 11;');cat("\n");
    
    cat('########################################');cat("\n");
    cat('#Sample order  array                   #');cat("\n");
    cat('########################################');cat("\n");
    
    #Make sample array string
    if (sample.order[1] == ""){
        sample.order = names(df.data[grep("counts", names(df.data))])
    }
    
    sample.string = paste(sample.order, collapse = "', '")
    sample.string = paste("$sample_array = array('", sample.string, "');", sep="")
    cat(sample.string);cat("\n");
    
    #In this case, I need the follownig pattern A, B, B, B, 
    cat('########################################');cat("\n");
    cat('#Sample colors                         #');cat("\n");
    cat('########################################');cat("\n");
    library(RColorBrewer)
    #Make sample_color_string Give each sample group a different color Needs to be of the same length and in the same order as
    # sample.string
    n.samples = length(sample.order)
    if (count.sample.colors[1] == "" | length(count.sample.colors) != length(sample.order)){
        selcol <- colorRampPalette(brewer.pal(12,"Set3"))
        selcol2 <- colorRampPalette(brewer.pal(9,"Set1"))
        cols = selcol2(n.samples);
    } else {
        cols = count.sample.colors
    }
    
    col.string = "$sample_color_array = array('"
    for (i in 1:length(cols)){
        col.string = paste(col.string,cols[i],"','",sep="")
    }
    
    col.string = substr(col.string, 1, nchar(col.string)-2)
    col.string = paste(col.string, ");", sep="")
    
    cat(col.string);cat("\n");
    
    cat('########################################');cat("\n");
    cat('#Venn Selection                        #');cat("\n");
    cat('########################################');cat("\n");
    ## Edited 20170314
    string <- vector(mode="character", length=0)
    for (i in 1:length(venn.slider.selector.strings)){
        string = append(string, names(df.data)[grep(venn.slider.selector.strings[i], names(df.data))])
    }
    
    string = paste(string, collapse = "','")
    string = paste("$venn_selection = array('", string, "');", sep="")
    cat(string);cat("\n");
    
    #Venn ranges
    cat(paste('$slider_selection_name = "',slider.selection.name,'";', sep=""));cat("\n");
    
    #This array defines the overall slider range
    string <- vector(mode="character", length=0)
    for (i in 1:length(venn.slider.selector.strings)){
        string = append(string, names(df.data)[grep(venn.slider.selector.strings[i], names(df.data))])
    }
    
    slider.min = '$venn_slider_min_array = array('
    for (i in 1:length(string)){
        if (length(grep("padj", string[i])) > 0){
            slider.min  = paste(
                slider.min, 
                0,
                ", ", 
                sep=""
            )
        } else {
            slider.min  = paste(slider.min, 
                                round(min(as.numeric(df.data[,string[i]]), na.rm=T)-1),
                                ", ", 
                                sep=""
            )
        }
    }
    
    slider.min = substr(slider.min, 1, nchar(slider.min)-2)
    slider.min = paste(slider.min, ");", sep="")
    cat(slider.min);cat("\n") 
    
    slider.max = '$venn_slider_max_array = array('
    for (i in 1:length(string)){
        if (length(grep("padj", string[i])) > 0){
            slider.max  = paste(slider.max,
                                1,
                                ", ", 
                                sep=""
            )
        } else {
            slider.max  = paste(slider.max, 
                                round(max(as.numeric(df.data[,string[i]]), na.rm=T)+1),
                                ", ", 
                                sep=""
            )
        }
    }
    
    slider.max = substr(slider.max, 1, nchar(slider.max)-2)
    slider.max= paste(slider.max, ");", sep="")
    cat(slider.max);cat("\n") 
    
    #This array defines the default positions of the sliders
    slider.min = '$default_venn_low_array = array('
    for (i in 1:length(string)){
        if (length(grep("padj", string[i])) > 0){
            slider.min  = paste(slider.min, 
                                0,
                                ", ", 
                                sep=""
            )
        } else {
            slider.min  = paste(slider.min, 
                                round(min(as.numeric(df.data[,string[i]]), na.rm=T)-1),
                                ", ", 
                                sep=""
            )
        }
    }
    
    slider.min = substr(slider.min, 1, nchar(slider.min)-2)
    slider.min = paste(slider.min, ");", sep="")
    cat(slider.min);cat("\n") 
    
    slider.max = '$default_venn_high_array = array('
    for (i in 1:length(string)){
        if (length(grep("padj", string[i])) > 0){
            if (i ==1){
                sliderValue <- 0.05
            } else {
                sliderValue <- 1
            }
            slider.max  = paste(slider.max,
                                sliderValue,
                                ", ", 
                                sep=""
            )
        } else {
            slider.max  = paste(slider.max, 
                                round(max(as.numeric(df.data[,string[i]]), na.rm=T)+1),
                                ", ", 
                                sep=""
            )
        }
    }
    
    slider.max = substr(slider.max, 1, nchar(slider.max)-2)
    slider.max= paste(slider.max, ");", sep="")
    cat(slider.max);cat("\n") 
    
    #Make experiment array
    #This array is used for heatmap display
    if (use.logFC.columns.for.heatmap){
        experiment.string = names(df.data)[grep("logFC_", names(df.data))]
        experiment.string = experiment.string[grep("contrast", experiment.string)]
    } else {
        experiment.string = names(df.data)[grep("lg2_avg_", names(df.data))]
    }
    
    experiment.string = paste(experiment.string, collapse = "','")
    experiment.string = paste("$experiment_array = array('", experiment.string, "');", sep="")
    cat(experiment.string);cat("\n");
    
    #This sink will be removed and joined with the GSEA parameters in the final version
    #1 Create environment
    #jsl1 folder
    #dist and distii folders
    ###########################
    #Create display parameters#
    ###########################
    cat("##################"); cat("\n");
    cat("#Heatmap settings#"); cat("\n");
    cat("##################"); cat("\n");
    cat(paste('$upper_heatmap_limit = ',upper_heatmap_limit,';', sep="")); cat("\n");
    cat(paste('$lower_heatmap_limit = ',lower_heatmap_limit, ';',sep="")); cat("\n");
    cat(paste('$hm_headline = "<h2>',heamap.headline.text,'</h2><br>";', sep="")); cat("\n");
    cat('$heatmap_pointer = "lg2(SILAC Ratio)";');
    
    cat("\n");
    cat("##################"); cat("\n");
    cat("#Count table     #"); cat("\n");
    cat("##################"); cat("\n");
    cat(paste('$count_table_headline = "',count.table.headline,'";', sep="")); cat("\n");
    cat(paste('$count_table_sidelabel = "',count.table.sidelabel,'";', sep="")); cat("\n");
    
    # GSEA
    if (!is.na(gsea.cat.lines[1])){
        for (k in 1:length(gsea.cat.lines)){
            cat(gsea.cat.lines[k]); cat("\n");
        }
    } else {
        cat("#################"); cat("\n");
        cat("#GSEA Parameters#"); cat("\n");
        cat("#################"); cat("\n");
        cat("# Not set."); cat("\n");
        cat("\n");
    }
    
    #enriched_categories_table = paste('$enriched_categories_table="',enriched.categories.db.table.name,'";', sep='')
    #cat(enriched_categories_table); cat("\n");
    #cat(paste('$image_link_array = "',image.link.array,'";', sep="")); cat("\n");
    
    #enriched.cols = paste('$enriched_padj_cols = "',enriched.padj.cols,'";', sep='')
    #cat(enriched.cols); cat("\n");  
    
    # timecourse
    if (!is.na(timecourse.cat.lines[1])){
        for (k in 1:length(timecourse.cat.lines)){
            cat(timecourse.cat.lines[k]); cat("\n");
        }
    } else {
        cat("########################"); cat("\n");
        cat("# Timecourse Parameters#"); cat("\n");
        cat("########################"); cat("\n");
        cat("# Not set."); cat("\n");
        cat("\n");
    }
    
    
    if (ptm.colum != ""){
        cat("#################"); cat("\n");
        cat("#Motif array    #"); cat("\n");
        cat("#################"); cat("\n");
        string = "$motif_default_array = array('"
        for (i in 1:nchar(default.sequence)){
            string = paste(string, substr(default.sequence,i,i), "','", sep="")
        }
        string = substr(string, 1, nchar(string)-2)
        string = paste(string, ");", sep="")
        cat(string); cat("\n");
    }
    
    if (presentation.file != ""){
        cat("##################"); cat("\n");
        cat("#Presentation    #"); cat("\n");
        cat("##################"); cat("\n");
        cat(paste("$download_presentation ='", presentation.file, "';", sep="")); cat("\n");
        cat(paste("$number_of_slides =", number_of_slides, ";", sep="")); cat("\n");
    }
    
    if (peptide.view.link != ""){
        cat("##########################"); cat("\n");
        cat("#PeptdideView section    #"); cat("\n");
        cat("##########################"); cat("\n");
        cat(paste("$peptide_view_link ='", peptide.view.link, "';", sep="")); cat("\n");
    }
    
    cat("\n");
    cat("###############################################################################"); cat("\n");
    cat("## CategoryView parameters                                                   ##"); cat("\n");
    cat("###############################################################################"); cat("\n");
    cat(paste0("$cat_selection_db = '",cat.seletion.table.vec[1], "';")); cat("\n");
    cat(paste0("$cat_selection_db_table = '",cat.seletion.table.vec[2], "';")); cat("\n");
    cat("\n");
    cat("?>"); cat("\n");  
    sink()  
    
}

## End of function                                                           ##
###############################################################################

###############################################################################
## (2B) createSettingsFile()                                                 ##

# createSettingsFile <- function(
#     df.data = 'database.table',
#     sample.order = "names(database.table)[grep('norm_counts', names(databse.table))]", #set to "" to go with default sorting
#     heatmapSampleOrder = "lg2_avg vec",
#     sample.names = "", # default is sample.order
#     count.sample.colors = 'rainbow(length(sample.order))',
#     ptm.colum = "display_ptm",
#     count.table.headline = "PTM ratio H/L counts for all samples",
#     count.table.sidelabel = "Counts",
#     venn.slider.selector.strings = 'c("contrast_x_logFC", "constrast_x_padj")',
#     plot.selection.strings = 'c(
#     "_logFC", 
#     "_PCA_",
#     "_lg10p"
# )',
#     webSiteDir = "/camp/stp/babs/working/boeings/Stefan/protocol_files/github/biologic/src/experiments",
#     upper_heatmap_limit = 3, 
#     lower_heatmap_limit = -3,
#     heamap.headline.text = "heamap.headline.text",
#     project_id = "project_id",
#     primDataTable = "p123_rna_seq_table"
#     ){
#     if (sample.order[1] == "" | is.na(sample.order[1])){
#         sample.order <- sort(names(database.table)[grep("norm_counts_", names(database.table))])
#     }
#     
#     if (count.sample.colors[1] == "" | is.na(count.sample.colors[1])){
#         count.sample.colors <- rainbow(length(sample.order))
#     }
#     
#     if (sample.names[1] == "" | is.na(sample.names[1])){
#         sample.names <- gsub("norm_counts_", "", sample.order)
#         sample.names <- gsub("_", " ", sample.names)
#     }
#     
#     settingsPhpVec <- c(
#         "<?php",
#         "",
#         "return array(",
#         "    'lab' => array(",
#         paste0("        'name' => '",labname," DB'"),
#         "    ),",
#         "",
#         "    /*",
#         "    * Experiment settings",
#         "    */",
#         paste0("    'data_db_name' => '",prim.data.db,"',"),
#         "    'data_db' => array(",
#         paste0("            'cat_table_name' => '",cat.ref.db.table,"'"),
#         "    ),",
#         "",
#         paste0("    'rnaseq_db_table' => '",primDataTable,"',"),
#         paste0("    'primary_gene_symbol' => '",gene.id.column,"',"),
#         paste0("    'ptm_display_column' => '",ptm.colum,"',"),
#         "",
#         "    'heatmap' => array(",
#         paste0("        'upper_limit' => ",upper_heatmap_limit,","),
#         paste0("        'lower_limit' => ",lower_heatmap_limit,","),
#         paste0("        'headline' => '",heamap.headline.text,"',"),
#         "        'pointer' => 'lg2(SILAC Ratio)'",
#         "    ),",
#         ""
#     )
#     
#     ## Add sample array ##
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    'samples' => array("
#     )
#     
#     for (i in 1:length(sample.order)){
#         settingsPhpVec <- c(
#             settingsPhpVec,
#             paste0("        '",sample.order[i],"' => array("),
#             paste0("            'color' => '",sample.colors[i],"',"),
#             paste0("            'name' => '",sample.names[i],"'"),
#             "        )"
#         )
#         if (i < length(sample.order)){    
#             settingsPhpVec[length(settingsPhpVec)] <- paste0(
#                 settingsPhpVec[length(settingsPhpVec)], ","
#             )
#         }
#     }
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    ), // End samples array"
#     )
#     
#     ## Done adding samples ##
#     
#     ## Adding barchart parameters ##
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    // bar chart",
#         "    'count_table' => array(",
#         paste0("        'headline' => '", count.table.headline,"',"),
#         paste0("        'sidelabel' => '", count.table.sidelabel,"'"),
#         "    ),"
#     )
#     ## Done adding barchart parameters ##
#     
#     ## Adding Venn section ##
#     if (heatmapSampleOrder[1] == ""){
#         heatmapSampleOrder <- names(df.data)[grep("lg2_avg", names(df.data))]
#     } 
#     
#     heatMapString <- paste(heatmapSampleOrder, collapse = "','")
#     heatMapString <- paste0("'", heatMapString,"'")
#     
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    // Venn Diagram Parameters",
#         "    'venn' => array(",
#         paste0("        'experiments' => array(", heatMapString,"),"),
#         "",
#         "    'table' => array(",
#         "        'col_name_start' => 11,",
#         "        'low_highlight' => -1,",
#         "        'high_highlight' => 1",
#         "    ),",
#         "",
#         "    'selection' => array("
#     )
#     
#     vennCols <- as.vector(NULL, mode = "character")
#     for (i in 1:length(venn.slider.selector.strings)){
#         vennCols <- c(
#             vennCols,
#             names(df.data)[grep(venn.slider.selector.strings[i], names(df.data))]
#         )
#     }
#     
#     for (i in 1:length(vennCols)){
#         colMax <- ceiling(max(df.data[,vennCols[i]], na.rm = TRUE))
#         colMin <- floor(min(df.data[,vennCols[i]], na.rm = TRUE))
#         
#         Vname <- vennCols[i]
#         Vname <- substr(Vname ,11,100)
#         Vname <- gsub("^_", "", Vname)
#         Vname <- gsub("_", " ", Vname)
#         
#         if (is.numeric(colMax) & is.numeric(colMin)){
#             settingsPhpVec <- c(
#                 settingsPhpVec,
#                 paste0("        '",vennCols[i],"' => array("),
#                 paste0("            'name' => '",Vname,"',"),
#                 paste0("            'slider_min' => ", colMin,","),
#                 paste0("            'slider_max' => ", colMax,","),
#                 paste0("            'default_low' => ", colMin,","),
#                 paste0("            'default_high' => ", colMax,""),
#                 "        )"
#             )
#         }
#         
#         if (i < length(vennCols)){
#             settingsPhpVec[length(settingsPhpVec)] <- paste0(
#                 settingsPhpVec[length(settingsPhpVec)], ","
#             )
#         }
#         
#         
#     }
#     
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    )",  ## Done with venn array 
#         "    )," ## Done with venn array 
#     )
#     ## Done adding Venn section
#     
#     ## Adding scatterplot ##
#     scatterCols <- as.vector(NULL, mode = "character")
#     for (i in 1:length(plot.selection.strings)){
#         scatterCols <- c(
#             scatterCols,
#             names(df.data)[grep(plot.selection.strings[i], names(df.data))]
#         )
#     }
#     
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "    // Scatterplot Parameters",
#         "    'scatterplot' => array(",
#         "        'selection' => array("
#     )
#     
#     for (i in 1:length(scatterCols)){
#         Sname <- scatterCols[i]
#         Sname <- substr(Sname ,11,100)
#         Sname <- gsub("^_", "", Sname)
#         Sname <- gsub("_", " ", Sname)
#         
#         settingsPhpVec <- c(
#             settingsPhpVec,
#             paste0("            '",scatterCols[i],"' => array("),
#             paste0("                'name' => '",Sname,"'"),
#             "            )"
#         )
#         
#         if (i < length(scatterCols)){
#             settingsPhpVec[length(settingsPhpVec)] <- paste0(
#                 settingsPhpVec[length(settingsPhpVec)], ","
#             )
#         }
#         
#         
#     }
#     
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         "        )", # close scatterplot selection array
#         "    )", # close scatterplot  array
#         "//End scatterplot" # close scatterplot  array
#     )
#     
#     ## Done adding scatterplot ##
#     
#     ## End of file ##
#     settingsPhpVec <- c(
#         settingsPhpVec,
#         ");"
#     )
#     
#     ###########################################################################
#     ## Create settings.php file                                              ##
#     setwd(webSiteDir)
#     if (!dir.exists(project_id)){
#         dir.create(project_id)
#     }
#     
#     
#     if (substr(webSiteDir, nchar(webSiteDir), nchar(webSiteDir)) != "/"){
#         webSiteDir <- paste0(
#             webSiteDir,
#             "/"
#         )
#     }
#     
#     FN <- paste0(
#         webSiteDir,
#         project_id,
#         "/settings.php"
#     )
#     
#     sink(FN)
#     for (i in 1:length(settingsPhpVec)){
#         cat(settingsPhpVec[i]); cat("\n")
#     }
#     sink()
#     
#     ## Done creating settings.php file                                       ##
#     ###########################################################################
# }
# 
# ## End: createSettingsFile()                                                 ##
# ###############################################################################

###############################################################################
## (47) listExistingProjects()                                              ##
listExistingProjects <- function(
    user     = "boeings",
    password = "",
    host     = "www.biologic-db.org",
    dbname = "reference_categories_db_new",
    dbtable = "project_description_table"
){
    library(RMySQL)
    dbDB <- dbConnect(MySQL(), user = user, password = password, host = host, dbname=dbname)
    ResVec = sort(as.vector(dbGetQuery(dbDB, paste0("SELECT DISTINCT project_name FROM ", dbtable))[,1]))
    dbDisconnect(dbDB)
    return(ResVec)
}

## End of function (47)                                                      ##
###############################################################################

###############################################################################
## (44) createNewProject                                                     ##

createNewProject <- function(
    dbname = "reference_categories_db_new",
    dbtable = "project_description_table",
    password = db.pwd,
    project_name = "G2 Cell Cycle Checkpoint",
    project_lab = ";Parker;",
    project_description = "This project investigates the influence of protein kinase C variants on the G2 cell cycle checkpoint."
){
    # Retrieve list of existing projects
    dfProjectTable <- import.db.table.from.db(
        dbname = dbname,
        dbtable = dbtable,
        password = password
    )
    
    dfProjectTable$row_names <- NULL
    dfProjectTable <- unique(dfProjectTable)
    
    ## Make safety copy ##
    FN <- paste0(
        hpc.mount,
        "Projects/tybulewiczv/edina.schweighoffer/102_VTL_DEV_build_projectView/basedata/",
        project.code,
        "backupForProjectDescriptionTable.txt"
    )
    
    write.table(
        dfProjectTable, 
        FN, 
        row.names = FALSE,
        sep = "\t"
    )
    ## Add new row ##
    cols <- names(dfProjectTable)
    NewRow <- data.frame(t(unlist(sapply(cols, function(x) get(x)))))
    
    if (sum(!(names(NewRow) %in% names(dfProjectTable))) == 0){
        dfProjectTable <- rbind(
            dfProjectTable,
            NewRow
        )
    }
    
    upload.datatable.to.database(
        host = host, 
        user = db.user,
        password = db.pwd,
        prim.data.db = dbname,
        dbTableName = dbtable,
        df.data = dfProjectTable,
        db.col.parameter.list = list(
            "VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci" = c("project_lab"),
            "VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci" = c("project_name"),
            "TEXT CHARACTER SET utf8 COLLATE utf8_general_ci" = c("project_description"),
            "BIGINT(8) NULL DEFAULT NULL" = c("row_names")
            
        ),
        new.table = TRUE
    )
}

## Done adding new project                                                   ##
###############################################################################

###############################################################################
## (45) List project in projects table                                       ##

addProject2ProjectTable <- function(
    dbname = "reference_categories_db_new",
    dbtable = "project_db_table",
    password = db.pwd,
    experiment_id= project_id,
    experiment_question = "Which genes are candidates for G2M checkpoint regulation?",
    experiment_description = "<b>RNAi screen</b> for genes that affect the G2M checkpoint",
    experiment_owner = ";Katharina Deiss;Nicola Longwood;",
    experiment_lab = paste0(";",labname,";"),
    experiment_viewers = paste0(";", paste(user_ids, collapse = ";"),";"),
    experiment_project = ";G2 Cell Cycle Checkpoint;",
    experiment_type = experiment.type,
    experiment_details = "Experimental details will follow here",
    experiment_x_coordinate = ";Screen;",
    experiment_x_coordinate_unit = "condition",
    experiment_link = paste0(
        "<a href='../",
        project_id,
        "/report.php' class='btn btn-success btn-lg' role='button'>Primary Data &raquo;</a>"
    ),            
    experiment_title = ""
){
    # Retrieve list of existing projects
    dfProjectTable <- import.db.table.from.db(
        dbname = "reference_categories_db_new",
        dbtable = "project_db_table",
        password = password
    )
    
    dfProjectTable <- dfProjectTable[dfProjectTable$experiment_id != "",]
    dfProjectTable$row_names <- NULL
    
    ## Make safety copy ##
    FN <- paste0(
        hpc.mount,
        "Projects/tybulewiczv/edina.schweighoffer/102_VTL_DEV_build_projectView/basedata/",
        project.code,
        "backupForProjectTable.txt"
    )
    
    write.table(
        dfProjectTable, 
        FN, 
        row.names = FALSE,
        sep = "\t"
    )
    ## Add new row ##
    cols <- names(dfProjectTable)
    NewRow <- data.frame(t(unlist(sapply(cols, function(x) get(x)))))
    
    if (sum(!(names(NewRow) %in% names(dfProjectTable))) == 0){
        dfProjectTable <- rbind(
            dfProjectTable,
            NewRow
        )
    }
    
    upload.datatable.to.database(
        host = host, 
        user = db.user,
        password = db.pwd,
        prim.data.db = dbname,
        dbTableName = dbtable,
        df.data = dfProjectTable,
        db.col.parameter.list = list(
            "VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci" = c("experiment_"),
            "TEXT CHARACTER SET utf8 COLLATE utf8_general_ci" = c("experiment_description", "experiment_details"),
            "BIGINT(8) NULL DEFAULT NULL" = c("row_names")
            
        ),
        new.table = TRUE
    )
    
}
## Done listing project                                                      ##
###############################################################################

###############################################################################
## Function: (32) createSRAdownloadScript()                                       ##
createSRAdownloadScript <- function(
    sra.id.vector = "sra.id.vector",
    gse.id.vector = "",
    datadir = "",
    module.load.cmd = "module use /camp/stp/babs/working/software/modules/all;module load sratoolkit/2.8.2-1",
    fastqDir = "./"
){
    sink(paste0(sra.id.vector, ".sra.download.instructions.sh"))
    cat("#!/bin/sh"); cat('\n');
    cat("## Change into download directory ##"); cat('\n');
    cat(paste0("cd ", fastqDir)); cat("\n");
    cat(module.load.cmd); cat('\n');
    
    ## Download by project ##
    wget.cmd <- paste0(
        "wget -m ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/",
        substr(sra.id.vector, 1, 6),
        "/",
        sra.id.vector,
        "/")
    
    cat("## Download SRA library ##"); cat('\n');
    cat(wget.cmd); cat('\n');
    
    
    mv.cmd <- paste0(
        "mv ",
        fastqDir,
        "ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/",
        substr(sra.id.vector, 1, 6),
        "/",
        sra.id.vector,
        "/* ./"
    )
    
    rm.cmd <- paste0(
        "rm -r ftp-trace.ncbi.nlm.nih.gov"
    )
    
    cat("## Organize files ##"); cat('\n');
    cat(mv.cmd); cat('\n');
    cat(rm.cmd); cat('\n');
    
    ## Make list of folders ##
    
    
    # create an array with all the filer/dir inside ~/myDir
    arr.cmd <- paste0(
        "arr=(",
        "./",
        "*)"
    )
    
    cat("## Create sample array ##"); cat('\n');
    cat(arr.cmd); cat('\n');
    
    ## fastq-dump command ##
    fastq.dump.cmd <- paste0(
        'sbatch --wrap "', 
        'fastq-dump --outdir ',
        fastqDir,
        ' --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-files --origfmt $directory.sra',
        '" --job-name=', 
        project.code ,
        ' -c 1 --mem-per-cpu=1000 -o ', 
        'fastqdump.slurm >> commands.txt'
    )
    
    # iterate through array using a counter
    ## convert to FASTQ ##
    
    cat('for ((i=0; i<${#arr[@]}; i++)); do'); cat('\n');
    cat('  #do something to each element of array'); cat('\n');
    cat('  echo "Processing ${arr[$i]} ..."'); cat('\n');
    cat('  directory=${arr[$i]}'); cat('\n');
    cat('  mv $directory/* ./'); cat('\n');
    cat('  rm -r $directory'); cat('\n');
    cat('  ## fastq-dump cmd'); cat('\n');
    cat(module.load.cmd); cat('\n');
    cat(fastq.dump.cmd); cat('\n');
    cat('  ## Estimating read length ##'); cat('\n');
    cat('filename=$directory__pass_1.fastq.gz'); cat('\n');
    cat('if [ -f "$filename" ];'); cat('\n');
    cat('then'); cat('\n');
    cat("zcat $filename | awk 'NR%2==0' | awk '{print length($1)}' | head"); cat('\n');
    cat(' fi'); cat('\n');
    
    cat('filename=$directory__pass_1.fastq.gz'); cat('\n');
    cat('if [ -f "$filename" ];'); cat('\n');
    cat('then'); cat('\n');
    cat("zcat $filename | awk 'NR%2==0' | awk '{print length($1)}' | head"); cat('\n');
    cat('fi'); cat('\n');
    
    
    cat('done'); cat('\n');
    cat('## Output files will be named like SRR2979627_pass_1.fastq.gz'); cat('\n');
    
    if (gse.id.vector != ""){
        cat('Get GSE annotation'); cat('\n');
        cat(
            paste0(
                "wget https://ftp.ncbi.nlm.nih.gov/geo/series/",
                substr(gse.id.vector, 1, 5),
                "nnn/",
                substr(gse.id.vector, 1, 10),
                "/matrix/",
                gse.id.vector,
                "_series_matrix.txt.gz -O ",
                datadir
            )
        ); cat('\n');
        
        cat(
            paste0(
                "gunzip ",
                datadir,
                gse.id.vector,
                "_series_matrix.txt.gz"
            )
        ); cat('\n');
    }
    
    sink()
    
    ## create documentation
    sra.docu.vec <- c(
        paste0("SRA project id:", sra.id.vector),
        paste0("Download date/time:" , date())
    )
    
    print("If this shell script was generated on a windows computer run:")
    print(paste0("tr -d '\r' <",paste0(sra.id.vector, ".sra.download.instructions.sh"),"> conv.",paste0(sra.id.vector, ".sra.download.instructions.sh")))
    
    return(sra.docu.vec)
}

## For ERA downloads use: For example, the files submitted in the SRA Submission ERA007448 are available at: ftp://ftp.sra.ebi.ac.uk/vol1/ERA007/ERA007448/


## End of function: createSRAdownloadScript()                                ##
###############################################################################

###############################################################################
## Function: (32b) createSRRdownloadScript()                                       ##
createSRRdownloadScript <- function(
    srr.id.vector = "srr.id.vector",
    sra.id.vector =  "sra.id.vector",
    gse.id.vector = "",
    datadir = "",
    module.load.cmd = "module use /camp/stp/babs/working/software/modules/all;module load sratoolkit/2.8.2-1",
    fastqDir = "./",
    project.code = "project.code"
){
    scriptVec <- as.vector(NULL, mode = "character")
    scriptVec <- c(
        scriptVec,
        "#!/bin/sh",
        "\n",
        "## Change into download directory ##",
        module.load.cmd,
        "\n",
        paste0("vdb-config --set /repository/user/default-path=", fastqDir),
        "\n",
        paste0("vdb-config --set /repository/user/main/public/root=", fastqDir),
        "\n",
        "\n"
    )
    
    # create an array with all the filer/dir inside ~/myDir
    srrIDstoDownload <- paste(srr.id.vector, collapse = " ")
    arr.cmd <- paste0(
        "arr=(",srrIDstoDownload,")"
    )
    
    scriptVec <- c(
        scriptVec, 
        "## Create sample array ##",
        arr.cmd,
        "\n"
    )
    
 
    ## fastq-dump command ##
    fastq.dump.cmd <- paste0(
        'sbatch --time=12:00:00 --wrap "', 
        'fastq-dump --outdir ',
        fastqDir,
        ' --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-files --origfmt $file',
        '" --job-name=', 
        project.code ,
        ' -c 1 --mem-per-cpu=1000 -o ', 
        'fastqdump.slurm >> commands.txt'
    )
    
    # iterate through array using a counter
    ## convert to FASTQ ##
    
    scriptVec <- c(
        scriptVec, 
        'for ((i=0; i<${#arr[@]}; i++)); do',
        '  #do something to each element of array',
        '  echo "Processing ${arr[$i]} ..."',
        '  file=${arr[$i]}',
        paste0('#  mv $directory/* '), fastqDir ,
        '#  rm -r $file',
        '  ## fastq-dump cmd',
        module.load.cmd,
        fastq.dump.cmd,
        '  ## Estimating read length ##',
        'filename=$directory__pass_1.fastq.gz',
        'if [ -f "$filename" ];',
        'then',
        "zcat $filename | awk 'NR%2==0' | awk '{print length($1)}' | head",
        'fi',
        'done',
        '## Output files will be named like SRR2979627_pass_1.fastq.gz'
    )
    
  
    
    if (gse.id.vector != ""){
        scriptVec <- c(
            scriptVec,
            'Get GSE annotation',
            paste0(
                "wget https://ftp.ncbi.nlm.nih.gov/geo/series/",
                substr(gse.id.vector, 1, 5),
                "nnn/",
                substr(gse.id.vector, 1, 10),
                "/matrix/",
                gse.id.vector,
                "_series_matrix.txt.gz -O ",
                datadir
            ),
            paste0(
                "gunzip ",
                datadir,
                gse.id.vector,
                "_series_matrix.txt.gz"
            )
        )
        
    }
    
    scriptVec <- c(
        scriptVec,
        paste0("# SRA project id:", sra.id.vector),
        paste0("# Download date/time:" , date())
    )
    
    ## Create shell script
    sink(paste0(sra.id.vector, ".srr.download.instructions.sh"))
    
    for (i in 1:length(scriptVec)){
        cat(scriptVec[i])
        cat("\n")
    }
    
    sink()
    ## Done
    
    print("If this shell script was generated on a windows computer run:")
    print(paste0("tr -d '\r' <",paste0(sra.id.vector, ".srr.download.instructions.sh"),"> conv.",paste0(sra.id.vector, ".srr.download.instructions.sh")))
    
    return(scriptVec)
}

## For ERA downloads use: For example, the files submitted in the SRA Submission ERA007448 are available at: ftp://ftp.sra.ebi.ac.uk/vol1/ERA007/ERA007448/


## End of function: createSRAdownloadScript()                                ##
###############################################################################

###############################################################################
# (9C) Create timecourse cat lines                                            #
###############################################################################
create.timecourse.cat.lines <- function(
    df.design,
    display.median.string = "calculate_median"
    # alternative for display.median.string example norm_counts_sample_X_avg > "_avg" Don't forget the underscore.
){
    # For the time series, the design file needs to contain the following colums
    # To create the datasets vector: a >>dataseries<< column
    # To assign data series colors >>dataseries_color<<
    # To create the timepoint sample name vectors a  >>sample.group<<
    # To create the timepoint sample replicate name vectors a  >>sample.id<<
    # To create the timepoint array an >>timepoint<< column (integers/double (hours, minutes, days))
    
    df.design.select <- unique(df.design[,c("dataseries","dataseries_color", "sample.group", "sample.id", "timepoint")])
    df.design.select <- df.design.select[order(df.design.select$timepoint,
                                               df.design.select$dataseries,
                                               df.design.select$sample.id,
                                               df.design.select$sample.group
    ),]
    
    timecourse.cat.lines <-                              "#########################"
    timecourse.cat.lines <- append(timecourse.cat.lines, "# Timecourse Parameters #")
    timecourse.cat.lines <- append(timecourse.cat.lines, "#########################")
    
    #Add Dataseries description
    add <- paste(unique(df.design.select$dataseries), collapse = "', '")
    add <- paste0("$datasets= array('", add, "');")
    timecourse.cat.lines <- append(timecourse.cat.lines, add)
    
    #Add dataset_colors
    add <- paste(unique(df.design.select$dataseries_color), collapse = "', '")
    add <- paste0("$dataset_colors = array('", add, "');")
    timecourse.cat.lines <- append(timecourse.cat.lines, add)
    
    # Create timepoint array
    add <- paste(unique(df.design.select$timepoint), collapse = ",")
    add <- paste0("$timepoint_array = array(", add, ");")
    timecourse.cat.lines <- append(timecourse.cat.lines, add)
    
    # Create sample arrays for each dataseries
    dataseries <- unique(df.design.select$dataseries)
    for (k in 1:length(dataseries)){
        add <- paste0("# Dataseries: ", dataseries[k])
        timecourse.cat.lines <- append(timecourse.cat.lines, add)
        add <- paste0("$", dataseries[k], " = array('")
        s.groups <- unique(df.design.select[df.design.select$dataseries == dataseries[k], "sample.group"])
        add.groups <- paste(s.groups, collapse = "','")
        add <- paste0(add, add.groups, "');")
        timecourse.cat.lines <- append(timecourse.cat.lines, add)
        # Add sample names (norm counts + sample.id)
        for (l in 1:length(s.groups)){
            string <- paste0("$", s.groups[l], " = array('")
            s.ids  <- unique(df.design.select[df.design.select$sample.group == s.groups[l], "sample.id"])
            s.ids  <- paste0("norm_counts_", s.ids)
            s.ids  <- paste(s.ids, collapse = "', '")
            string <- paste0(string, s.ids, "');")
            timecourse.cat.lines <- append(timecourse.cat.lines, string)
        }
    }
    
    # Display median parameter
    string <- paste0("$display_median = '", display.median.string,"';")
    timecourse.cat.lines <- append(timecourse.cat.lines, string)
    timecourse.cat.lines <- append(timecourse.cat.lines, "# End timecourse parameters #")
    return(timecourse.cat.lines)
}


## End of function                                                           ##
###############################################################################

###############################################################################
## (18) Retrieve gene category from db                                       ##           
###############################################################################

retrieve.gene.category.from.db <- function(
    cat_id         = "mysigdb_c5_MF__127",
    dbname         = "reference_categories_db_new",
    user           = "boeings",
    password       = "",
    host           = "www.biologic-db.org",
    gene.symbol    = "mgi_symbol",
    print.cat.name = TRUE
){
    library(RMySQL)
    
    table <- unlist(
        strsplit(
            cat_id, "__"
        )
    )[1]
    
    ## Query category name ##
    drv = RMySQL::MySQL()
    
    sql.query = paste0(
        "SELECT cat_id, cat_name from ", 
        table, 
        " WHERE cat_id = '", 
        cat_id, "'"
    )
    
    dbDB <- dbConnect(
        drv      = RMySQL::MySQL(), 
        user     = user, 
        password = password, 
        host     = host, 
        dbname   = dbname
    )
    
    cat.vec = dbGetQuery(
        dbDB, 
        sql.query
    )
    
    dbDisconnect(dbDB)
    
    if (print.cat.name){
        print(
            paste(
                "Retrieved category: ", 
                paste0(
                    cat.vec$cat_name, 
                    collapse = ", "
                )
            )
        )
        
        print(
            paste(
                "Retrieved category ID: ", 
                paste0(
                    cat.vec$cat_id, 
                    collapse = ", "
                )
            )
        )    
        
    }    
    
    
    ## Query genes ##
    sql.query = paste0(
        "SELECT ", 
        gene.symbol, 
        " from ", 
        table, 
        " WHERE cat_id = '", 
        cat_id, "'"
    )
    
    dbDB <- dbConnect(
        drv      = RMySQL::MySQL(), 
        user     = user, 
        password = password, 
        host     = host, 
        dbname   = dbname
    )
    
    cat.vec = dbGetQuery(
        dbDB, 
        sql.query
    )[,gene.symbol]
    
    dbDisconnect(dbDB)
    
    cat.vec <- unlist(
        strsplit(
            cat.vec, 
            ";"
        )
    )
    cat.vec <- cat.vec[!is.na(cat.vec)]
    cat.vec <- cat.vec[cat.vec != ""]
    cat.vec = as.vector(unique(cat.vec))
    return(cat.vec)
}

## End of function                                                           ##
###############################################################################

######################################################
# (11) add.category.to.lab.reference.table.hs        #
######################################################


###############################################################################
## Function update                                                           ##
add.category.to.lab.reference.table.hs <- function(
    host = 'www.biologic-db.org',
    pwd = db.pwd,
    user = "boeings",
    cat.ref.db = "reference_categories_db_new",
    cat.ref.db.table = "cs_lab_categories",
    gene.vector = gene.vec,
    gene.id = "hgnc_symbol", #options hgnc_symbol, mgi_symbol
    mm.hs.conversion.file =  "Y:/working/boeings/Projects/reference_data/20160303.homologene.data.txt",
    cat_name = "lung_cancer_late_subclonal_driver_genes",
    cat_type = "cs_lab",
    data_source = "Swanton lab",
    comments_1 = "",
    comments_2 = "",
    new.lab.category.table = FALSE,
    cat.description.db  = "internal_categories",
    cat.description.db.table = "category_description",
    cat.description.text = "Subclonal late driver genes, as compiled by the Swanton lab",
    lab.name = "Swanton",
    replaceExistingCatName = TRUE
) {
    ## Preparind gene.vector ##
    gene.vector <- na.omit(gene.vector)
    gene.vector <- gene.vector[gene.vector != ""]
    gene.vector <- as.vector(unique(gene.vector))
    
    ## Annotate genes ##
    #########################
    #Function################
    #########################
    make.mm.hs.conversion.table <- function(mm.hs.conversion.file){
        cwd = getwd()
        df.ncbi = read.delim(mm.hs.conversion.file, header=FALSE, sep="\t", stringsAsFactors = FALSE)
        names(df.ncbi)[1] = "conversion_id"
        names(df.ncbi)[2] = "taxon_id"
        names(df.ncbi)[4] = "gene_name"
        
        #Keep only mouse and human rows
        df.hs = unique(df.ncbi[df.ncbi$taxon_id == 9606, c("conversion_id", "gene_name")])
        names(df.hs)[2] = "hs_gene_name"
        df.ms = unique(df.ncbi[df.ncbi$taxon_id == 10090,c("conversion_id", "gene_name")])
        names(df.ms)[2] = "ms_gene_name"
        
        df.conversion = unique(merge(df.hs, df.ms, by.x = "conversion_id", by.y = "conversion_id"))
        df.conversion$conversion_id = NULL
        setwd(cwd)
        return (df.conversion)
    }
    #end of function
    df.conversion = make.mm.hs.conversion.table(mm.hs.conversion.file)
    names(df.conversion) = c("hgnc_symbol", "mgi_symbol")
    
    assign(gene.id, gene.vector)
    df.new <- data.frame(get(gene.id))
    names(df.new) <- gene.id
    
    
    df.conversion = df.conversion[df.conversion[,gene.id] %in% df.new[, gene.id], ]
    
    
    df.new = merge(df.new, df.conversion, by.x = gene.id, by.y = gene.id, all=TRUE)
    df.new[is.na(df.new)] = ""
    df.new = unique(df.new[df.new[,gene.id] != "", ])
    
    formatGeneVec <- function(gene.vec){
        gene.vec <- na.omit(gene.vec)
        gene.vec <- gene.vec[gene.vec != ""]
    }
    
    hgnc_symbol <- paste0(";",paste0(formatGeneVec(df.new$hgnc_symbol), collapse = ";"), ";")
    mgi_symbol <- paste0(";",paste0(formatGeneVec(df.new$mgi_symbol), collapse = ";"), ";")
    
    
    ## Created dependent vectors ##
    #cat_name = rep(cat_name, length(gene.vector))
    #cat_type = rep(cat_type, length(gene.vector))
    #data_source = rep(data_source, length(gene.vector))
    #comments_1 = rep(comments_1, length(gene.vector))
    #comments_2 = rep(comments_2, length(gene.vector))
    cat_item_size = length(gene.vector)
    
    
    ## Determine if cat exists ##
    library(RMySQL)
    dbDB <- dbConnect(
        drv = RMySQL::MySQL(), 
        user = user, 
        password = db.pwd, 
        host = host, 
        dbname = cat.ref.db
    )
    
    query <- paste0(
        "SELECT DISTINCT cat_id, cat_name FROM ",
        cat.ref.db.table, 
        " WHERE cat_name = '",cat_name,"'"
    )
    
    dfTest <- dbGetQuery(dbDB, query)
    dbDisconnect(dbDB)
    updateCat <- FALSE
    library(RMySQL)
    
    if (nrow(dfTest) == 1){
        cat_id <- dfTest[,"cat_id"]
        updateCat <- TRUE
        
        
    } else {
        if (!new.lab.category.table){
            dbDB = dbConnect(MySQL(), user = user, password = pwd, dbname= cat.ref.db ,host = host)
            
            ## Set default ##
            next.id = 1
            max.value = 0
            
            max.value <- as.numeric(
                dbGetQuery(dbDB, 
                           paste(
                               "SELECT MAX(row_names) FROM ", 
                               cat.ref.db.table, sep=""
                           )
                )
            )
            if (!is.na(max.value)){
                df.ref = dbGetQuery(dbDB, paste("SELECT DISTINCT cat_id FROM ", cat.ref.db.table, sep=""))
                ids = unique(df.ref$cat_id)
                ids = as.numeric(sapply(ids, function(x) unlist(strsplit(x, paste(cat.ref.db.table, "__", sep="")))[2]))
                next.id = max(ids)+1
            } else {
                max.value = 0
            }
            #df.ref = dbGetQuery(dbDB, "SELECT DISTINCT * FROM js_lab_categories WHERE cat_id = 'not_existing'")
            dbDisconnect(dbDB)
            
            
            cat_id = paste(cat.ref.db.table, "__", next.id, sep="")
            
        }
    }
    dbDB = dbConnect(MySQL(), user = user, password = pwd, dbname= cat.ref.db ,host = host)
    df.ref = dbGetQuery(dbDB, "SELECT DISTINCT * FROM js_lab_categories WHERE cat_id = 'not_existing'")
    dbDisconnect(dbDB)
    
    ## Get current reference category format from db ##
    
    
    
    
    ## Get default cat column names ##
    ## Current df.ref column names and order:
    #[1] "hgnc_symbol"   "mgi_symbol"    "cat_id"        "cat_name"      "cat_type"      "data_source"   "comments_1"
    #[8] "comments_2"    "cat_item_size" "row_names"
    
    add.internal.cat.description <- FALSE
    if (comments_1[1] == ""){
        comments_1 <- paste0("category.description.php?cat_id=", cat_id)
        add.internal.cat.description <- TRUE
    }
    
    
    df.cat.new = data.frame(
        hgnc_symbol,
        mgi_symbol,
        cat_id,
        cat_name,
        cat_type,
        data_source,
        comments_1,
        comments_2,
        cat_item_size,
        stringsAsFactors = FALSE
    )
    
    
    #Consider only genes that are pesent in df.data
    
    #Prepare data table
    #df.ref$row_names = NULL
    df.cat.new[["row_names"]] <- 0
    
    if (!updateCat){
        df.cat.new[["row_names"]] = max.value+1
    }
    
    df.cat.new = df.cat.new[, names(df.ref)]
    
    
    #Upload to database
    library(RMySQL)
    dbDB = dbConnect(MySQL(), user = user, password = pwd, dbname= cat.ref.db, host = host)
    if (new.lab.category.table){
        dbGetQuery(dbDB, paste("DROP TABLE IF EXISTS ", cat.ref.db.table, sep=""))
    }
    
    uploaded = FALSE
    while (!uploaded){
        tryCatch({
            killDbConnections()
            dbDB = dbConnect(MySQL(), user = user, password = pwd, dbname= cat.ref.db,host = host)
            if (updateCat){
                query <- paste0(
                    "UPDATE ", cat.ref.db.table,
                    " SET hgnc_symbol='",df.cat.new[,"hgnc_symbol"],
                    "', mgi_symbol='",df.cat.new[,"mgi_symbol"],
                    #"' cat_id='",df.cat.new[,"cat_id"],
                    "', cat_name='",df.cat.new[,"cat_name"],
                    "', cat_type='",df.cat.new[,"cat_type"],
                    "', data_source='",df.cat.new[,"data_source"],
                    "', comments_1='",df.cat.new[,"comments_1"],
                    "', comments_2='",df.cat.new[,"comments_2"],
                    "', cat_item_size='",df.cat.new[,"cat_item_size"],
                    "' WHERE cat_id = '", df.cat.new[,"cat_id"], "'"
                )
                dbGetQuery(dbDB, query)
                
            } else {
                dbWriteTable(
                    dbDB, 
                    cat.ref.db.table, 
                    df.cat.new, 
                    row.names= FALSE, 
                    overwrite=FALSE, 
                    append=TRUE
                )
            }
            
            
            uploaded = TRUE
            #dbDisconnect(dbDB)
        }, error=function(e){cat("Upload errror :",conditionMessage(e), "\n")})
    }
    
    #dbWriteTable(dbDB, dataTable, df.new, row.names= FALSE, overwrite=FALSE, append=TRUE)
    
    if (new.lab.category.table){
        dbGetQuery(dbDB, paste("ALTER TABLE `",cat.ref.db.table,"` ADD UNIQUE(`row_names`)", sep=""))
        dbGetQuery(dbDB, paste("ALTER TABLE `",cat.ref.db.table,"` ADD PRIMARY KEY(`row_names`)", sep=""))
        
        
        
        dbGetQuery(dbDB, paste("ALTER TABLE ",cat.ref.db.table,"
                               CHANGE `hgnc_symbol` `hgnc_symbol` LONGTEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `mgi_symbol` `mgi_symbol` LONGTEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `cat_name` `cat_name` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `cat_id` `cat_id` VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `cat_type` `cat_type` VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `data_source` `data_source` VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `comments_1` `comments_1` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `comments_2` `comments_2` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci ,
                               CHANGE `cat_item_size` `cat_item_size` INT(5) NULL DEFAULT NULL,
                               CHANGE `row_names` `row_names` BIGINT(8) NULL DEFAULT NULL",
                               sep="")
        )
    }
    dbDisconnect(dbDB)
    
    # Add description
    if (add.internal.cat.description){
        ## Escape ##
        #cat.description.text <- gsub("\\'", "\\'", cat.description.text)
        dbDB = dbConnect(MySQL(), user = user, password = pwd, dbname= cat.description.db,host = host)
        insert.query <- paste0("INSERT INTO `",cat.description.db,"`.`",cat.description.db.table,"` (`cat_id`, `cat_name`, `cat_description`, `created_by`, `lab`, `creation_date`) VALUES ('",cat_id[1],"', '",cat_name[1],"', '",cat.description.text,"', '",data_source[1],"', '",lab.name,"', CURDATE())");
        dbGetQuery(dbDB, insert.query)
        dbDisconnect(dbDB)
    }
    string = paste0(cat_id, " with cat_name ",cat_name, " added.")
    print(string)
    return(cat_id)
}

## End of function ##


## Done function update                                                      ##
###############################################################################



###############################################################################
# (4) createRMDscript                                                         #
###############################################################################
setGeneric(
    name="createRMDscript",
    def=function(
        obj #,
        #scriptVecSlot = "scriptVec"
    ){    
        scriptVec <- as.vector(Obio@scriptVec)
        
        sink("script.txt")
        for (i in 1:length(scriptVec)){
            cat(paste0("#", i,"#  "));cat(scriptVec[i])
        }
        sink()
        
        library(knitr)
        #(s = system.file("examples", "knitr-spin.R", package = "knitr"))
        spin("script.txt")  # default markdown
        #o = spin(s, knit = FALSE)  # convert to Rmd only
        #knit2html(o)  # compile to HTML
    }
)


###############################################################################
## (21) msigdb.gmt2refDB()                                                   ##
###############################################################################

msigdb.gmt2refDB <- function(
    df.gmt = "read.delim(gmt.file, header=FALSE, sep = '\t', stringsAsFactors = FALSE)",
    host = "www.biologic-db.org",
    db.user = "boeings",
    pwd = "pwd",
    ref.db = "reference_database",
    ref.db.table = "reference database table name",
    cat_type = "mysigdb_c5",
    data_source = "Broad Institute",
    keep.gene.values = FALSE,
    gene.id = "hgnc_symbol",
    create.new.table = FALSE,
    mm.hs.conversion.file = "C:/Users/boeing01/Desktop/homologene.data"
){
    ## Load tab delimited gmt file ##
    #setwd(dataDir)
    ## Load and generate file for ID conversion ##
    #mm.hs.conversion.file = "Y:/working/boeings/Projects/reference_data/20160303.homologene.data.txt"
    
    #########################
    #Function################
    #########################
    make.mm.hs.conversion.table <- function(mm.hs.conversion.file){
        cwd = getwd()
        df.ncbi = read.delim(mm.hs.conversion.file, header=FALSE, sep="\t", stringsAsFactors = FALSE)
        names(df.ncbi)[1] = "conversion_id"
        names(df.ncbi)[2] = "taxon_id"
        names(df.ncbi)[4] = "gene_name"
        
        #Keep only mouse and human rows
        df.hs = unique(df.ncbi[df.ncbi$taxon_id == 9606, c("conversion_id", "gene_name")])
        names(df.hs)[2] = "hs_gene_name"
        df.ms = unique(df.ncbi[df.ncbi$taxon_id == 10090,c("conversion_id", "gene_name")])
        names(df.ms)[2] = "ms_gene_name"
        
        df.conversion = unique(merge(df.hs, df.ms, by.x = "conversion_id", by.y = "conversion_id"))
        df.conversion$conversion_id = NULL
        setwd(cwd)
        names(df.conversion) <- c("hgnc_symbol", "mgi_symbol")
        return (df.conversion)
    }
    #end of function
    df.conversion <- make.mm.hs.conversion.table(mm.hs.conversion.file)
    
    ## Ensure that df.gmt is a data.frame ##
    df.gmt <- data.frame(df.gmt)
    
    ## Condense gene columns 3:n into column 3##
    df.genes <- df.gmt[,3:ncol(df.gmt)]
    df.gmt <- df.gmt[,1:2]
    df.gmt[["hgnc_symbol"]] = ""
    df.gmt[["mgi_symbol"]] = ""
    names(df.gmt)[1] <- "cat_name"
    names(df.gmt)[2] <- "comments_1"
    
    
    df.gmt[["cat_item_size"]] = 0
    
    ###############################################################################
    ## Adding all relevant database columns to df.gmt                            ##
    # To be added 
    col.vec <- c(
        "hgnc_symbol",
        "mgi_symbol",
        "cat_id",
        "cat_name",
        "cat_type",
        "data_source",
        "comments_1",
        "comments_2",
        "cat_item_size",
        "row_names"
    )  
    
    ## Check if dbTablename already exists, and if so, get cat_id vector ##
    library(RMySQL)
    dbDB <- dbConnect(
        MySQL(), 
        user = db.user, 
        password = db.pwd, 
        host = host, 
        dbname = ref.db
    )
    tables <- as.vector(dbGetQuery(dbDB, paste0("SHOW TABLES IN ", ref.db))[,1])
    
    if (is.na(match(ref.db.table, tables)) | create.new.table){
        ## if table does not exist yet ##
        first.id <- 1
        next.row <- 1
    } else {
        ## table exist already and need to be appended ##
        cat.ids <- dbGetQuery(dbDB, paste0("SELECT DISTINCT cat_id FROM ", ref.db.table))$cat_id
        ids <- as.numeric(sapply(cat.ids, function(x) unlist(strsplit(x, "__"))[2]))
        first.id <- max(ids) + 1
        
        next.row <- as.numeric(dbGetQuery(dbDB, paste0("SELECT MAX(row_names) FROM ", ref.db.table)))
        next.row <- next.row + 1
    }
    
    dbDisconnect(dbDB)
    
    
    df.gmt[["cat_id"]] = paste0(ref.db.table, "__", (first.id:(first.id + nrow(df.gmt)-1)))
    
    df.gmt[["cat_type"]] <- rep(cat_type, nrow(df.gmt))
    df.gmt[["data_source"]]<- rep(data_source, nrow(df.gmt))
    
    df.gmt[["comments_2"]] <- ""
    
    
    ## Done adding all relevant database columns to df.gmt                       ##
    ###############################################################################
    
    ## Adding mgi and hgnc gene names ##
    for (i in 1:nrow(df.gmt)){
        gene.vec <- unique(as.vector(t(df.genes[i,])))
        gene.vec <- na.omit(gene.vec)
        gene.vec <- gene.vec[gene.vec != ""]
        
        df.gmt[i, "cat_item_size"] = length(gene.vec)
        
        df.gene <- data.frame(gene.vec, stringsAsFactors = FALSE)
        df.gene[["gene_name"]] <- as.vector(sapply(gene.vec, function(x) unlist(strsplit(x, ","))[1]))
        df.gene[["value"]] <- as.vector(sapply(gene.vec, function(x) unlist(strsplit(x, ","))[2]))
        
        if (unique(df.gene$value)[1] == "" | is.na(df.gene$value)[1] ){
            numeric.values.present = FALSE
        } else {
            numeric.values.present = TRUE
        }
        
        if (gene.id == "hgnc_symbol"){
            names(df.gene) <- gsub("gene_name", "hgnc_symbol", names(df.gene))
            names(df.gene) <- gsub("value", "hgnc_value", names(df.gene))
            df.temp <- df.conversion[df.conversion$hgnc_symbol %in% as.vector(df.gene$hgnc_symbol),]
            #df.gene <- merge(df.gene, df.temp, by.x = "gene_name", by.y = "hgnc_symbol", all= TRUE)
            df.gene <- merge(df.gene, df.temp, by.x = "hgnc_symbol", by.y = "hgnc_symbol", all= TRUE)
            df.gene[is.na(df.gene)] = ""
            df.gene[["mgi_value"]] = ""
            df.gene[df.gene$mgi_symbol != "","mgi_value"] = df.gene[df.gene$mgi_symbol != "","hgnc_value"] 
        } else if (gene.id == "mgi_symbol"){
            names(df.gene) <- gsub("gene_name", "mgi_symbol", names(df.gene))
            names(df.gene) <- gsub("value", "mgi_value", names(df.gene))
            df.temp <- df.conversion[df.conversion$mgi_symbol %in% as.vector(df.gene$mgi_symbol),]
            df.gene <- merge(df.gene, df.temp, by.x = "mgi_symbol", by.y = "mgi_symbol", all = TRUE)
            df.gene[is.na(df.gene)] = ""
            df.gene[["hgnc_value"]] = ""
            df.gene[df.gene$mgi_symbol != "","hgnc_value"] = df.gene[df.gene$mgi_symbol != "","mgi_value"] 
        } else {
            print("Error: No valid gene id provided. Allowed: hgnc_symbol or mgi_symbol")
            return()
        }
        
        if (i%%1000 == 0){
            print(paste0(i, " categories processed..."))
        }
        #print(
        #  paste0(
        #    df.gmt[i,1], 
        #    ": total genes:", 
        #    length(gene.vec), 
        #    "; hgnc_symbol:", 
        #    length(unique(df.gene$hgnc_symbol)), 
        #    "; mgi_symbol:", 
        #    length(unique(df.gene$mgi_symbol))
        #  )
        #)
        
        ## Check if data values are present ##
        
        # Create hgnc string
        df.temp <- unique(df.gene[df.gene$hgnc_symbol != "", c("hgnc_symbol", "hgnc_value")])
        
        if (numeric.values.present){
            hgnc.string <- paste0(df.temp$hgnc_symbol, "(",df.temp$hgnc_value,")")
        } else {
            hgnc.string <- df.temp$hgnc_symbol
        }
        
        hgnc.string <- paste0(";", paste0(hgnc.string, collapse = ";"), ";")
        df.gmt[i, "hgnc_symbol"] <- hgnc.string
        
        ## Create mgi string ##
        df.temp <- unique(df.gene[df.gene$mgi_symbol != "", c("mgi_symbol", "mgi_value")])
        if (numeric.values.present){
            mgi.string <- paste0(df.temp$mgi_symbol, "(",df.temp$mgi_value,")")
        } else {
            mgi.string <- df.temp$mgi_symbol
        }
        mgi.string <- paste0(";", paste0(mgi.string, collapse = ";"), ";")
        df.gmt[i, "mgi_symbol"] <- mgi.string
        
        
    }
    
    ## Re-order df.gmt ##
    df.gmt[["row_names"]] = next.row:(nrow(df.gmt)+ next.row -1)
    df.gmt <- df.gmt[,col.vec]
    
    
    ## Upload to database ##
    library(RMySQL)
    dbDB = dbConnect(
        drv = RMySQL::MySQL(), 
        user = db.user, 
        password = db.pwd, 
        dbname = ref.db, 
        host = host
    )
    
    if (create.new.table){
        dbGetQuery(
            dbDB, 
            paste(
                "DROP TABLE IF EXISTS ", 
                ref.db.table, 
                sep = ""
            )
        )
    }
    
    
    dbWriteTable(
        dbDB, 
        ref.db.table, 
        df.gmt, 
        row.names = FALSE,
        append = TRUE, 
        overwrite = FALSE)
    
    
    if (create.new.table){
        resp <- dbGetQuery(
            dbDB, 
            paste(
                "ALTER TABLE `", 
                ref.db.table, 
                "` ADD UNIQUE(`row_names`)", 
                sep = "")
        )
        
        resp <- dbGetQuery(
            dbDB, 
            paste(
                "ALTER TABLE `", 
                ref.db.table, 
                "` ADD PRIMARY KEY(`row_names`)", 
                sep = "")
        )
        
        resp <- dbGetQuery(
            dbDB, 
            paste("ALTER TABLE ", 
                  ref.db.table, 
                  " CHANGE `hgnc_symbol` `hgnc_symbol` LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `mgi_symbol` `mgi_symbol` LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `cat_name` `cat_name` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `cat_id` `cat_id` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `cat_type` `cat_type` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `data_source` `data_source` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `comments_1` `comments_1` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `comments_2` `comments_2` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci ,
            CHANGE `cat_item_size` `cat_item_size` INT(5) NULL DEFAULT NULL,
            CHANGE `row_names` `row_names` BIGINT(8) NULL DEFAULT NULL", 
                  sep = ""
            )
        )
    }
    dbDisconnect(dbDB)
} # end of function 
##                                                                           ##
###############################################################################

###############################################################################
## (22) prepareDotPlotData()                                                 ##
###############################################################################

## This function is a derivative of the Seurat DotPlot function 

DotPlotSB <- function (
    object, 
    assay = NULL, 
    features, 
    cols = c("lightgrey", "blue"), 
    col.min = -2.5, 
    col.max = 2.5, 
    dot.min = 0, 
    dot.scale = 6, 
    group.by = NULL, 
    split.by = NULL, 
    scale.by = "radius", 
    scale.min = NA, 
    scale.max = NA
) {
    assay <- assay %||% DefaultAssay(object = object)
    DefaultAssay(object = object) <- assay
    scale.func <- switch(
        EXPR = scale.by, 
        size = scale_size, 
        radius = scale_radius, 
        stop("'scale.by' must be either 'size' or 'radius'")
    )
    
    data.features <- FetchData(
        object = object, 
        vars = features
    )
    
    
    
    data.features$id <- if (is.null(x = group.by)) {
        Idents(object = object)
    } else {
        object[[group.by, drop = TRUE]]
    }
    
    if (!is.factor(x = data.features$id)) {
        data.features$id <- factor(x = data.features$id)
    }
    
    id.levels <- levels(x = data.features$id)
    
    data.features$id <- as.vector(x = data.features$id)
    
    if (!is.null(x = split.by)) {
        splits <- object[[split.by, drop = TRUE]]
        if (length(x = unique(x = splits)) > length(x = cols)) {
            stop("Not enought colors for the number of groups")
        }
        cols <- cols[1:length(x = unique(x = splits))]
        names(x = cols) <- unique(x = splits)
        data.features$id <- paste(data.features$id, splits, sep = "_")
        unique.splits <- unique(x = splits)
        id.levels <- paste0(rep(x = id.levels, each = length(x = unique.splits)), 
                            "_", rep(x = unique(x = splits), times = length(x = id.levels)))
    }
    
    PercentAbove <- function(x, threshold) {
        return(length(x = x[x > threshold]) / length(x = x))
    }
    
    data.plot <- lapply(
        X = unique(x = data.features$id), 
        FUN = function(ident) {
            data.use <- data.features[data.features$id == ident, 1:(ncol(x = data.features) - 1), drop = FALSE]
            avg.exp <- apply(
                X = data.use, 
                MARGIN = 2, 
                FUN = function(x) {
                    return(mean(x = expm1(x = x)))
                }
            )
        
            pct.exp <- apply(
                X = data.use, 
                MARGIN = 2, 
                FUN = PercentAbove, 
                threshold = 0
            )
        return(list(avg.exp = avg.exp, pct.exp = pct.exp))
        }
    )
    
    names(x = data.plot) <- unique(x = data.features$id)
    data.plot <- lapply(X = names(x = data.plot), FUN = function(x) {
        data.use <- as.data.frame(x = data.plot[[x]])
        data.use$features.plot <- rownames(x = data.use)
        data.use$id <- x
        return(data.use)
    })
    
    data.plot <- do.call(what = "rbind", args = data.plot)
    
    
    dfClust <- data.frame(data.plot %>% pivot_wider(!pct.exp, names_from = features.plot, values_from = avg.exp))
    row.names(dfClust) <- dfClust$id
    dfClust$id <- NULL
    
    if (ncol(dfClust) >=2){
        dfDist <- hclust(d=dist(t(dfClust)), method = "ward.D2")
        orderVec <- names(dfClust)[dfDist$order]
    } else {
        orderVec <- names(dfClust)
    }
    
    if (!is.null(x = id.levels)) {
        data.plot$id <- factor(x = data.plot$id, levels = id.levels)
    }
    
    avg.exp.scaled <- sapply(
        X = unique(x = data.plot$features.plot), 
        FUN = function(x) {
            data.use <- data.plot[data.plot$features.plot == x, "avg.exp"]
            data.use <- scale(x = data.use)
            data.use <- MinMax(
                data = data.use, 
                min = col.min, 
                max = col.max
            )
        return(data.use)
        }
    )
    
    avg.exp.scaled <- as.vector(x = t(x = avg.exp.scaled))
    
    if (!is.null(x = split.by)) {
        avg.exp.scaled <- as.numeric(
            x = cut(x = avg.exp.scaled, 
            breaks = 20)
        )
    }
    
    data.plot$avg.exp.scaled <- avg.exp.scaled
    data.plot$features.plot <- factor(
        x = data.plot$features.plot, 
        levels = rev(x = features)
    )
    
    data.plot$pct.exp[data.plot$pct.exp < dot.min] <- NA
    data.plot$pct.exp <- data.plot$pct.exp * 100
    
    if (!is.null(x = split.by)) {
        splits.use <- vapply(
            X = strsplit(
                x = as.character(x = data.plot$id), 
                split = "_"
            ), FUN = "[[", FUN.VALUE = character(length = 1L), 2
        )
        
        data.plot$colors <- mapply(FUN = function(color, value) {
            return(colorRampPalette(colors = c("grey", color))(20)[value])
        }, color = cols[splits.use], value = avg.exp.scaled)
    }
    color.by <- ifelse(
        test = is.null(x = split.by), 
        yes = "avg.exp.scaled", 
        no = "colors"
    )
    
    if (!is.na(x = scale.min)) {
        data.plot[data.plot$pct.exp < scale.min, "pct.exp"] <- scale.min
    }
    if (!is.na(x = scale.max)) {
        data.plot[data.plot$pct.exp > scale.max, "pct.exp"] <- scale.max
    }
    
    old <- theme_get()
    theme_set(theme_bw())
    
    data.plot$features.plot <- factor(data.plot$features.plot, levels = orderVec)
    if (is.factor(object@meta.data$clusterName)){
        levels <- levels(object@meta.data$clusterName)
    } else {
        levels <- unique(object@meta.data$clusterName)
    }
    
    
    data.plot$id <- factor(data.plot$id, levels = levels)
    data.plot <- na.omit(data.plot)
    
    plot <- ggplot(
        data=data.plot, aes_string(x= "id", y="features.plot")
    ) +  theme(
        axis.text.y   = element_text(size=8),
        axis.text.x   = element_text(size=8,angle = 45, vjust = 1, hjust = 1),
        axis.title.y  = element_blank(),
        axis.title.x  = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, size=1),
        plot.title = element_text(hjust = 0.5, size = 12),
        legend.position="bottom"
    ) + geom_point(
        aes_string(size = "pct.exp",color = color.by)
    #) + coord_fixed(
    ) + guides(size = guide_legend(title = "Perc Expr")
    ) + labs(
        x = ifelse(test = is.null(x = split.by), 
                   yes = "Identity", no = "Split Identity"), 
        y = "Features"
    ) 
    
    if (nrow(data.plot) > 10){
        plot <- plot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    }
   
    if (!is.null(x = split.by)) {
        plot <- plot + scale_color_identity()
    } else if (length(x = cols) == 1) {
        plot <- plot + scale_color_distiller(palette = cols)
    } else {
        plot <- plot + scale_color_gradient(low = cols[1], high = cols[2])
    }
    
    if (is.null(x = split.by)) {
        plot <- plot + guides(color = guide_colorbar(title = "Avg Expr"))
    }
    
    theme_set(old)
    
    return(plot)
}


##                                                                           ##
###############################################################################


#####################################################
# (15) Function to list all tables in a database     #
#####################################################
list.db.tables.in.db <- function(dbname = "reference_categories_db_new",
                                 user     = "boeings",
                                 password = "",
                                 host     = "www.biologic-db.org"
){
    library(RMySQL)
    dbDB <- dbConnect(MySQL(), user = user, password = password, host = host, dbname=dbname)
    table.vector = sort(as.vector(dbGetQuery(dbDB, "SHOW TABLES")[,1]))
    dbDisconnect(dbDB)
    return(table.vector)
}

# End of function

#####################################################
# (16) Function to list all columns in a db table    #
#####################################################
list.db.table.col.names <- function(dbtable = "interpro_categori",
                                    dbname = "reference_categories_db_new",
                                    user     = "boeings",
                                    password = "",
                                    host     = "www.biologic-db.org"
){
    library(RMySQL)
    dbDB <- dbConnect(MySQL(), user = user, password = password, host = host, dbname=dbname)
    column.vector = sort(as.vector(dbGetQuery(dbDB, paste0("SHOW COLUMNS in ",dbtable))[,1]))
    dbDisconnect(dbDB)
    return(column.vector)
}

# End of function

###############################################################################
## Hypergeometric test enrichment                                            ##

###############################################################################
## Method Determine row variability                                          ##

setGeneric(
    name="profileCluster",
    def=function(
        # Input gmt file with categories to test: dfGmt
        # Output: table with enrichments
        obj = "Obio",
        markerList = "residualClusterMarkers",
        gmtList = "clusterProfilerGMTList",
        nTop = 10,
        pvalueCutoff = 0.5
    ) {
        library(clusterProfiler)
        library(ggplot2)
        library(tidyr)
        
        if (Obio@parameterList$geneIDcolumn != "mgi_symbol" & Obio@parameterList$geneIDcolumn != "hgnc_symbol") {
            queryGS <- "hgnc_symbol" 
        } else {
            queryGS <- Obio@parameterList$geneIDcolumn
        }
        
        if (Obio@parameterList$host == "10.27.241.234"){
            urlString <- "biologic.thecrick.org"
        } else {
            urlString <- "biologic.crick.ac.uk"
        }
        
        VersionPdfExt <- paste0(".V", gsub("-", "", Sys.Date()), ".pdf")
        
        ## Set plotting colors ##
        plotNames <- sort(unique(names(gmtList)))
        
        library(scales)
        plotCols <- hue_pal()(length(plotNames))
        names(plotCols) <- plotNames
        
        catEnrichmentList <- list()
        
        ## markerList is derrived from a gmt file and has in the one position a category description.
        
        ## Determine colors ##
        library(scales)
        enrCols <- hue_pal()(length(gmtList))
        names(enrCols) <- names(gmtList)
        
        for (i in 1:length(markerList)){
            geneVec <- markerList[[i]][2:length(markerList)]
            geneVec <- geneVec[geneVec != ""]
            geneVec <- geneVec[!is.na(geneVec)]
            first <- TRUE
            
            if (length(geneVec) > 0){
                for (j in 1:length(gmtList)){
                    egmt <- data.frame(
                        enricher(
                            geneVec, 
                            TERM2GENE=gmtList[[j]],
                            pvalueCutoff = pvalueCutoff
                        )
                    )
                    
                    
                    if (!is.null(egmt)){
                        if (nrow(egmt) > 0){
                            egmt[["Collection"]] <- substr(names(gmtList)[j], 1,10)
                        }
                        if (first){
                            dfTempEnriched <- egmt    
                            first <- FALSE
                        } else {
                            dfTempEnriched <- rbind(
                                dfTempEnriched, 
                                egmt
                            )    
                        }
                        
                    } 
                }
            }
            
            
            if (!first & nrow(dfTempEnriched > 0)){
                dfTempEnriched <- dfTempEnriched[order(dfTempEnriched$p.adjust, decreasing=F),]
                catEnrichmentList[[names(markerList)[i]]] <- dfTempEnriched   
            }
            print(paste0(names(markerList)[i], " done."))
        }
        
        
        
        ## Make the plots ##    
        plotList <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        for (i in 1:length(catEnrichmentList)){
            catName <- names(catEnrichmentList)[i]
            catNameString <- gsub("_", " ", names(catEnrichmentList)[i])
            
            dfEnr <- catEnrichmentList[[i]]
            dfEnr[["lg10p"]] <- -1*log10(dfEnr$p.adjust)
            dfEnr <- unique(dfEnr[,c("ID", "lg10p", "Collection")])
            dfEnr[["Cluster"]] <- catNameString
            
            dfEnr <- dfEnr[order(dfEnr$lg10p, decreasing = T),]
            
            if (i ==1){
                dfResTable <- dfEnr
            } else {
                dfResTable <- rbind(
                    dfResTable, 
                    dfEnr
                )
            }
            
            if (nTop > nrow(dfEnr)){
                tempSel <- nrow(dfEnr)
            } else {
                tempSel <- nTop
            }
            dfEnr <- dfEnr[1:tempSel, ]
            dfEnr <- dfEnr[order(dfEnr$lg10p, decreasing = F),]
            dfEnr$ID <- substr(dfEnr$ID, 1, 40)
            dfEnr$ID <- factor(dfEnr$ID, levels = unique(dfEnr$ID))
            tag <- paste0("Cell_Types_", names(catEnrichmentList)[i])
            
            tempPlotCols <- plotCols[unique(dfEnr$Collection)]
            
            plotList[[tag]] <- ggplot(
                data=dfEnr, aes(x= ID, y=lg10p, fill=Collection)
            ) + geom_hline(yintercept = c(-1*log10(0.05)), color = "black", size=0.5, lty=2    
            ) + geom_bar(stat="identity", colour="black"
            ) + coord_flip()   + scale_fill_manual("CatType",values = enrCols) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            ) + labs(title = paste0(gsub("_", " ", tag)," enriched genes") ,y = "-log10(padj)", x = ""
            ) + geom_hline(yintercept = 0, color = "black", size=0.5
            ) + theme_bw()
            
            
            
            
            ## Save to file ##
            FNbase <- paste0("CellTypeEnrichment_", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            
            pdf(FN)
            print(plotList[[tag]])
            dev.off()
            
            link <- paste0(
                '<a href="https://', urlString, '/',
                obj@parameterList$project_id,
                '/category-view?category_type=Cell Type Signatures" target="_blank">CategoryView > Cell Signatures</a>'
            )
            
            ## Create R markdown chunk ##
            figLegend <- paste0(
                '**Figure ', 
                figureCount, 
                '**: Enrichment analysis of cluster gene signatures to infer the cluster cell type. ', 
                'Download a pdf of this figure <a href="',FNrel,'" target="_blank">here</a>. To view these gene sets in the context of your data, go to ',link,' and find these categories using the search box.'
            )
            figureCount <- figureCount + 1 
            
            NewChnk <- paste0(
                "#### ", gsub("_", " ", tag),
                "\n```{r enrichr_", tag, ", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotList[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
        }
        
        returnList <- list(
            "chnkVec" = chnkVec,
            "plotList" = plotList,
            "dfResTable" = dfResTable
        )
        return(returnList)
    })

## Done category enrichments 
###############################################################################
###############################################################################
# End createRMDscript                                                         #
###############################################################################

###############################################################################
## Open data frame in Excel                                                  ##

## Function written by Daniel Cook ##
excel <- function(df) {
    f <- paste0(tempdir(),'/', make.names(deparse(substitute(df))),'.',paste0(sample(letters)[1:5],collapse=""), '.csv')
    write.csv(df,f)
    system(sprintf("open -a 'Microsoft Excel' %s",f))
}

## Usage 
# wrap a dataframe directory
##excel(cars)

# Or pipe output with dplyr
## cars %>% excel()

##