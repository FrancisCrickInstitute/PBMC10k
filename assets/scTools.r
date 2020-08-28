
###############################################################################
## Write table to Excel File                                                 ##
createXLSXoutput <- function(
    dfTable = "dfTable",
    outPutFN = "path/to/output/FN.xlsx",
    tableName = "Table1"
){
    library(openxlsx)
    wb <- createWorkbook()
    
    addWorksheet(wb, tableName)
    freezePane(wb, tableName ,  firstActiveRow = 2)
    
    hs1 <- createStyle(
        fontColour = "#ffffff",
        fgFill = "#000000", 
        halign = "CENTER", 
        textDecoration = "Bold"
    )
    
    writeData(wb, 1, dfTable, startRow = 1, startCol = 1, headerStyle = hs1)
    
    
    saveWorkbook(
        wb, 
        outPutFN , 
        overwrite = TRUE
    )
    print(paste0("Table saved as ", outPutFN, "."))
}

##                                                                           ##
###############################################################################

###############################################################################
## DoCRplots                                                                 ##
setGeneric(
    name="doCRplots",
    def=function(
        obj,
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5
    ) {
        
        figureCreated <- FALSE
        sampleNames <- names(Obio@sampleDetailList)
        
        rawSampleList <- list()
        filtSampleList <- list()
        
        for (i in 1:length(sampleNames)){
            if (obj@sampleDetailList[[sampleNames[i]]]$type == "TenX"){
                baseFN <- obj@sampleDetailList[[sampleNames[i]]]$path
                rawFN <- gsub("filtered_feature_bc_matrix", "raw_feature_bc_matrix", baseFN)
                
                if (file.exists(rawFN)){
                    rawSampleList[[sampleNames[i]]] <- Read10X(data.dir = rawFN)
                    filtSampleList[[sampleNames[i]]] <- Read10X(data.dir = baseFN)
                    
                    cellID <- colnames(rawSampleList[[sampleNames[i]]])
                    
                    CellRanger <- rep("Excl", length(cellID)) 
                    CellRanger[cellID %in% colnames(filtSampleList[[sampleNames[i]]])] <- "Incl"    
                    
                    UMI_count <- colSums(rawSampleList[[sampleNames[i]]])
                    
                    sampleID <- rep(sampleNames[i], length(cellID))
                    
                    
                    ###################################################################
                    ## Calculate nFeatures                                           ##
                    UMI_filt <- UMI_count[UMI_count > 0]
                    rawM <- rawSampleList[[sampleNames[i]]]
                    rawM <- rawM[,names(UMI_filt)]
                    #rawM[rawM > 0] <- 1
                    
                    ## Done calculate nFeatures                                      ##
                    ###################################################################
                    
                    dfTemp <- data.frame(sampleID, cellID, CellRanger,UMI_count)
                    dfTemp <- dfTemp[dfTemp$cellID %in% names(UMI_filt), ]
                    
                    
                    ###################################################################
                    ## Count features                                                ##
                    # increment <- 10000
                    # iter <- floor(nrow(dfTemp)/increment)
                    # resVec <- as.vector(NULL, mode="character")
                    # 
                    # for (k in 0:(iter)){
                    #     uL <- ((k+1)*increment )
                    #     if (uL > ncol(rawM)){
                    #         uL = ncol(rawM)
                    #     }
                    #     
                    #     h <- rawM[,(k*increment + 1):uL]
                    #     h2 <- apply(h, 2, function(x) length(x[x>0]))
                    #     names(h2) <- colnames(h)
                    #     resVec <- c(
                    #         resVec,
                    #         h2
                    #     )
                    #     print(k)
                    # }
                    
                    ## Done count features                                           ##
                    ###################################################################
                    
                    dfTemp <- dfTemp[order(dfTemp$UMI_count, decreasing = T),]
                    dfTemp[["sampleOrder"]] <- 1:nrow(dfTemp)
                    dfTemp[dfTemp$sampleOrder < 10, "sampleOrder"] <- 10
                    
                    dfTemp$sampleOrder <- log10(dfTemp$sampleOrder)
                    
                    dfTemp[["lg10_UMI_count"]] <- dfTemp$UMI_count
                    #dfTemp$lg10_UMI_count[dfTemp$lg10_UMI_count < 10] <- 1 
                    dfTemp$lg10_UMI_count <- log10(dfTemp$lg10_UMI_count)
                    
                    ###################################################################
                    ## Plot Selection                                                ##
                    selVecF <- as.vector(dfTemp[dfTemp$CellRanger == "Incl", "cellID"])
                    selVecR <- as.vector(dfTemp[dfTemp$CellRanger != "Incl", "cellID"])
                    if (length(selVecR) > length(selVecF)){
                        selVecR <- selVecR[sample(1:length(selVecR), size = length(selVecF), replace = F)]
                    }
                    
                    
                    selVec <- c(
                        selVecF, 
                        selVecR
                    )
                    
                    dfTemp[["plot_selection"]] <- "Excl_CR"
                    dfTemp[dfTemp$cellID %in% selVec, "plot_selection"] <- "Incl_CR"
                    
                    ## Done Plot Selection                                           ##
                    ###################################################################
                    
                    if (!figureCreated){
                        figureCreated = TRUE
                        dfRes <- dfTemp
                    } else {
                        dfRes <- rbind(
                            dfRes,
                            dfTemp
                        )
                    }
                }
            }
        }
        
        ## Done load raw data                                                        ##
        ###############################################################################
        
        ###############################################################################
        ## Make plots                                                                ##
        
        plotListQC1 <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        
        
        dfPlot <- dfRes[dfRes$plot_selection == "Incl_CR", ]
        sampleNames <- as.vector(unique(dfPlot$sampleID))
        
        for (i in 1:length(sampleNames)){
            tag <- sampleNames[i]
            greenLine <- min(dfPlot[dfPlot$CellRanger == "Incl" & dfPlot$sampleID == sampleNames[i], "lg10_UMI_count"]) 
            blackLine <- max(dfPlot[dfPlot$CellRanger != "Incl" & dfPlot$sampleID == sampleNames[i], "lg10_UMI_count"]) 
            
            plotListQC1[[tag]] <- ggplot(dfPlot[dfPlot$sampleID == sampleNames[i],], aes(sampleOrder, lg10_UMI_count, color=CellRanger)
            ) + geom_hline(yintercept = blackLine, color = "black", size=0.5
            ) + geom_hline(yintercept = greenLine, color = "#009900", size=0.5               
            ) + geom_point( 
                shape = 16,
                size = as.numeric(dotsize)
            ) + xlab("log10(N Droplets)") + ylab("lg10(UMI Count Per Cell)")  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                panel.background = element_rect(fill = "lightgrey")
            ) + ggtitle(paste0("QC Sample ", tag)
            ) + scale_color_manual(values=alpha(c("#000000","#009900"), 0.5)
            ) + coord_fixed(ratio=1
            ) + theme_bw() 
            
            FNbase <- paste0("cellranger.result.", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
                plotListQC1[[tag]]
            dev.off()
            
            figLegend <- paste0(
                "**Figure ", 
                figureCount, 
                ":** ",
                " CellRanger quality assessment. Green cells are considered for further analysis. Download a pdf of this figure [here](", FNrel,")."
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r CellRangerResult_",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotListQC1[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            
        }
        
        tag <- "All"
        plotListQC1[[tag]] <- ggplot(dfPlot, aes(sampleOrder, lg10_UMI_count, color=CellRanger)
        )+ geom_point( 
            shape = 16,
            size = as.numeric(dotsize)
        ) + xlab("log10(N Droplets)") + ylab("lg10(UMI Count Per Cell)")  +  theme(
            axis.text.y   = element_text(size=8),
            axis.text.x   = element_text(size=8),
            axis.title.y  = element_text(size=8),
            axis.title.x  = element_text(size=8),
            axis.line = element_line(colour = "black"),
            panel.border = element_rect(colour = "black", fill=NA, size=1),
            plot.title = element_text(hjust = 0.5, size = 12),
            panel.background = element_rect(fill = "lightgrey")
        ) + ggtitle(paste0("QC Sample ", tag)
        ) + scale_color_manual(values=alpha(c("#000000","#009900"), 0.5)
        ) + theme_bw()
        
        
        ## Save to file ##
        FNbase <- paste0("cellranger.result.", tag, VersionPdfExt)
        FN <- paste0(obj@parameterList$reportFigDir, FNbase)
        FNrel <- paste0("report_figures/", FNbase)
        
        pdf(FN)
        plotListQC1[[tag]]
        dev.off()
        
        figLegend <- paste0(
            "**Figure ", 
            figureCount, 
            ":** ",
            " CellRanger quality assessment. Green cells are considered for further analysis. Download a pdf of this figure [here](", FNrel,")."
        )
        
        figureCount <- figureCount + 1
        
        NewChnk <- paste0(
            paste(rep("#", tocSubLevel), collapse = ""), " ", tag,
            "\n```{r CellRangerResult_",
            tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
            figLegend,"'}\n",
            "\n",
            "\n print(plotListQC1[['",tag,"']])",
            "\n cat(  '\n')",
            "\n\n\n```\n"   
        )
        
        chnkVec <- c(
            chnkVec,
            NewChnk
        )
        
        returnList <- list(
            "plotListQC1" = plotListQC1,
            "chnkVec" = chnkVec,
            "dfPlot" = dfPlot,
            "figureCount" = figureCount
        )
        
    })

## Done doing CR plots                                                       ##
###############################################################################

###############################################################################
## RNA feature plot                                                                ##


setGeneric(
    name="doUMAP_plot_percMT",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        
        plotListUMT <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        
        sampleNames <- as.vector(names(obj@sampleDetailList))
        
        ## Determine min/max for all plots ##
        for (i in 1:length(sampleNames)){
            dfT <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            if (i ==1){
                dfR <- dfT
            } else {
                dfR <- rbind(
                    dfT,
                    dfR
                )
            }
        }
        
        maxX <- 1.1*max(dfR$UMAP_1, na.rm = T)
        minX <- 1.1*min(dfR$UMAP_1, na.rm = T)
        maxY <- 1.1*max(dfR$UMAP_2, na.rm = T)
        minY <- 1.1*min(dfR$UMAP_2, na.rm = T)
        
        
        for (i in 1:length(sampleNames)){
            tag <- paste0("UMT_",sampleNames[i])
            dfPlot <- SampleList[[sampleNames[i]]]@meta.data
            pos <- grep("included", names(dfPlot))
            if (length(pos) == 0){
                dfPlot[["included"]] <- "+"
            }
            dfPlot[["cellID"]] <- row.names(dfPlot)
            
            ## Get UMAP coordinates ##
            coord <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            coord[["cellID"]] <- row.names(coord)
            coord <-coord[coord$cellID %in% dfPlot$cellID, ]
            
            dfPlot <- merge(dfPlot, coord, by.x = "cellID", by.y="cellID", all=T)
            dfPlot[is.na(dfPlot)] <- 0
            dfPlot <- dfPlot[dfPlot$UMAP_1 != 0 & dfPlot$UMAP_2 != 0,]
            
            
            ## Add cluster colors ##
            # dfPlot[["Cluster"]] <- paste0("C", dfPlot$seurat_clusters)
            #clusterVec <- as.vector(paste0("C", unique(sort(dfPlot$seurat_clusters))))
            
            #library(scales)
            #clusterCols = hue_pal()(length(clusterVec))
            
            dfPlot$percent.mt <- as.numeric(dfPlot$percent.mt)
            
            
            
            plotListUMT[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=percent.mt)
            ) + geom_point( shape=16, size = as.numeric(dotsize)
            ) + xlab("UMAP1") + ylab("UMAP2")  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                legend.title = element_blank()
            ) + ggtitle(paste0("Sample: ", tag)
            ) + xlim(minX, maxX) + ylim(minY, maxY
            ) + coord_fixed(ratio=1
            ) + scale_colour_gradient2(high = "red", mid = "black"
            ) + theme_bw() 
            
            FNbase <- paste0("Sample.level.UMAP.perMT", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
            print(plotListSQCUMAP[[tag]])
            dev.off()
            
            figLegend <- paste0(
                "**Figure ", 
                figureCount, 
                ":** ",
                " Sample-level UMAP plot for QC purposes. Colored by the percent of mitochondrial gene expression per cell. Download a pdf of this figure [here](", FNrel,")."
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r UMT_UMAP_",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotListUMT[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            
        }
        
        
        
        returnList <- list(
            "plotListUMT" = plotListUMT,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done SL UMAP                                                              ##
###############################################################################




setGeneric(
    name="doUMAP_plot_nFeatRNA",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        
        plotListNC <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        
        sampleNames <- as.vector(names(obj@sampleDetailList))
        
        ## Determine min/max for all plots ##
        for (i in 1:length(sampleNames)){
            dfT <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            if (i ==1){
                dfR <- dfT
            } else {
                dfR <- rbind(
                    dfT,
                    dfR
                )
            }
        }
        
        maxX <- 1.1*max(dfR$UMAP_1, na.rm = T)
        minX <- 1.1*min(dfR$UMAP_1, na.rm = T)
        maxY <- 1.1*max(dfR$UMAP_2, na.rm = T)
        minY <- 1.1*min(dfR$UMAP_2, na.rm = T)
        
        
        for (i in 1:length(sampleNames)){
            tag <- paste0("NC_",sampleNames[i])
            dfPlot <- SampleList[[sampleNames[i]]]@meta.data
            pos <- grep("included", names(dfPlot))
            if (length(pos) == 0){
                dfPlot[["included"]] <- "+"
            }
            dfPlot[["cellID"]] <- row.names(dfPlot)
            
            ## Get UMAP coordinates ##
            coord <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            coord[["cellID"]] <- row.names(coord)
            coord <-coord[coord$cellID %in% dfPlot$cellID, ]
            
            dfPlot <- merge(dfPlot, coord, by.x = "cellID", by.y="cellID", all=T)
            dfPlot[is.na(dfPlot)] <- 0
            dfPlot <- dfPlot[dfPlot$UMAP_1 != 0 & dfPlot$UMAP_2 != 0,]
            
            
            ## Add cluster colors ##
            # dfPlot[["Cluster"]] <- paste0("C", dfPlot$seurat_clusters)
            #clusterVec <- as.vector(paste0("C", unique(sort(dfPlot$seurat_clusters))))
            
            #library(scales)
            #clusterCols = hue_pal()(length(clusterVec))
            
            dfPlot$nFeature_RNA <- as.numeric(dfPlot$nFeature_RNA)
            
            
            
            plotListNC[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=nFeature_RNA)
            ) + geom_point( shape=16, size = as.numeric(dotsize)
            ) + xlab("UMAP1") + ylab("UMAP2")  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                #legend.title = element_blank()
            ) + ggtitle(paste0("Sample: ", tag)
            ) + xlim(minX, maxX) + ylim(minY, maxY
            ) + coord_fixed(ratio=1
            ) + scale_colour_gradient2(high = "black", low = "red"
            ) + theme_bw() 
            
            FNbase <- paste0("Sample.level.UMAP.nFeatRNA", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
            print(plotListNC[[tag]])
            dev.off()
            
            figLegend <- paste0(
                "**Figure ", 
                figureCount, 
                ":** ",
                " Sample-level UMAP plot for QC purposes. Colored by the nFeatureRNA number. Download a pdf of this figure [here](", FNrel,")."
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r NC_UMAP_",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotListNC[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            
        }
        
        
        
        returnList <- list(
            "plotListNC" = plotListNC,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done SL UMAP                                                              ##
###############################################################################

###############################################################################
## RNA feature plot                                                                ##


setGeneric(
    name="doUMAP_plotSL",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        
        plotListSQCUMAP <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        
        sampleNames <- as.vector(names(obj@sampleDetailList))
        
        ## Determine min/max for all plots ##
        for (i in 1:length(sampleNames)){
            dfT <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            if (i ==1){
                dfR <- dfT
            } else {
                dfR <- rbind(
                    dfT,
                    dfR
                )
            }
        }
        
        maxX <- 1.1*max(dfR$UMAP_1, na.rm = T)
        minX <- 1.1*min(dfR$UMAP_1, na.rm = T)
        maxY <- 1.1*max(dfR$UMAP_2, na.rm = T)
        minY <- 1.1*min(dfR$UMAP_2, na.rm = T)
        
        
        for (i in 1:length(sampleNames)){
            tag <- paste0("U_",sampleNames[i])
            dfPlot <- SampleList[[sampleNames[i]]]@meta.data
            pos <- grep("included", names(dfPlot))
            if (length(pos) == 0){
                dfPlot[["included"]] <- "+"
            }
            dfPlot[["cellID"]] <- row.names(dfPlot)
            
            ## Get UMAP coordinates ##
            coord <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            coord[["cellID"]] <- row.names(coord)
            coord <-coord[coord$cellID %in% dfPlot$cellID, ]
            
            dfPlot <- merge(dfPlot, coord, by.x = "cellID", by.y="cellID", all=T)
            dfPlot[is.na(dfPlot)] <- 0
            dfPlot <- dfPlot[dfPlot$UMAP_1 != 0 & dfPlot$UMAP_2 != 0,]
            
            
            ## Add cluster colors ##
            dfPlot[["Cluster"]] <- paste0("C", dfPlot$seurat_clusters)
            clusterVec <- as.vector(paste0("C", unique(sort(dfPlot$seurat_clusters))))
            
            library(scales)
            clusterCols = hue_pal()(length(clusterVec))
            
            dfPlot$Cluster <- factor(dfPlot$Cluster, levels = clusterVec)
            
            
            
            plotListSQCUMAP[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=Cluster)
            ) + geom_point( shape=16, size = as.numeric(dotsize)
            ) + xlab("UMAP1") + ylab("UMAP2")  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                legend.title = element_blank()
            ) + ggtitle(paste0("Sample: ", tag)
            ) + xlim(minX, maxX) + ylim(minY, maxY
            ) + coord_fixed(ratio=1
            ) + theme_bw() 
            
            FNbase <- paste0("Sample.level.UMAP.", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
                print(plotListSQCUMAP[[tag]])
            dev.off()
            
            figLegend <- paste0(
                "**Figure ", 
                figureCount, 
                ":** ",
                " Sample-level UMAP plot for QC purposes. Download a pdf of this figure [here](", FNrel,")."
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r SL_UMAP_",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotListSQCUMAP[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            
        }
        
        
        
        returnList <- list(
            "plotListSQCUMAP" = plotListSQCUMAP,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done SL UMAP                                                              ##
###############################################################################

###############################################################################
## Do size exclustion                                                        ##

setGeneric(
    name="doRNAfeat_plotSL",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        
        plotListRF <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        
        sampleNames <- as.vector(names(Obio@sampleDetailList))
        
        for (i in 1:length(sampleNames)){
            tag <- sampleNames[i]
            
            SampleList[[sampleNames[i]]]@meta.data[["included"]] <- "+"
            
            SampleList[[sampleNames[i]]]@meta.data[((SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA < Obio@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMinFeatures) | (SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA > Obio@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMaxFeatures)), "included"] <- "ex_N_Feat_RNA"
            
            SampleList[[sampleNames[i]]]@meta.data[(SampleList[[sampleNames[i]]]@meta.data$percent.mt > Obio@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff ), "included"] <- "ex_MT_Perc"
            
            
            dfHist <-  SampleList[[sampleNames[i]]]@meta.data
            
            ## Fit GMM
            library(mixtools)
            x <- as.vector( dfHist$nFeature_RNA)
            dfHist[["x"]] <- x
            fit <- normalmixEM(x, k = 2) #try to fit two Gaussians
            
            dfHist[["temp1"]] <- fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
            dfHist[["temp2"]] <- fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
            
            # https://labrtorian.com/tag/mixture-model/
            
            ## Calculate Mean for distribution 1
            
            x1meanLine <- fit$mu[1]
            x2meanLine <- fit$mu[2]
            
            ## Find histogram max count ##
            pTest <- ggplot(data=dfHist, aes(x=nFeature_RNA, fill = included)
            ) + geom_histogram(binwidth=50
            ) 
            dfT <- ggplot_build(pTest)$data[[1]]
            yMax <- max(dfT$count)
            dMax1 <- max( fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1]))
            dMax2 <- max( fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2]))
            if (dMax1 > dMax2){
                dMax <- dMax1
                sF <- yMax/dMax
                dfHist[["fitVec1"]] <- sF *fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
                dfHist[["fitVec2"]] <- sF*fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
                dfHist[["x"]] <- fit$x
            } else {
                dMax <- dMax2
                sF <- yMax/dMax
                dfHist[["fitVec2"]] <- sF *fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
                dfHist[["fitVec1"]] <- sF*fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
                dfHist[["x"]] <- fit$x
            }
            
            dfHist <- dfHist[order(dfHist$x, decreasing = F),]
            
            colVec <- unique(sort(SampleList[[sampleNames[i]]]@meta.data$included))
            library(RColorBrewer)
            reds <- c("#FF0000", "#ffa500", "#A30000")
            colVec <- c("#000000", reds[1:(length(colVec)-1)])
            
        
            
            plotListRF[[paste0("Hist_GL_", tag)]] <- ggplot(data=dfHist, aes(x=nFeature_RNA, fill = included)
            ) + geom_vline( xintercept = c(x1meanLine, x2meanLine), col="grey", linetype = "dashed"
            ) + geom_histogram(binwidth=50, alpha = 0.5
            ) + scale_fill_manual(values=colVec) + geom_point(aes(x=x, y=fitVec1), color = "#009900", size = 0.5
            ) + geom_point(aes(x=x, y=fitVec2), color = "#FF0000", size = 0.1
            ) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            ) + geom_vline(xintercept = obj@parameterList$SeuratNrnaMinFeatures, col="red"
            ) + geom_hline(yintercept = 0, col="black"
                           
            ) + labs(title = paste0("Histogram nFeatures RNA per cell ", names(SampleList)[i], " (SD1: ", round(sd(x),2),")") ,y = "Count", x = "nFeatures RNA"
            ) + xlim(0, max(dfHist$x))
            
            ###########################################################################
            ## Save plot to file                                                     ##
            FNbase <- paste0("Historgram.GL",names(SampleList)[i], VersionPdfExt)
            FN <- paste0(Obio@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
            print(plotListRF[[paste0("Hist_GL_", tag)]])
            dev.off()
            ##                                                                       ##
            ###########################################################################
            
            
            
            
            figCap <- paste0(
                "**Figure ",
                figureCount,
                "C:** Histogram depicting genes found per cell/nuclei for sample ", 
                names(SampleList)[i],
                ". ",
                "Download a pdf of this figure [here](", FNrel, "). "
            )
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r Gene_plot_chunk_Histogram-",tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",figCap,"'}\n",
                "\n",
                "\n print(plotListRF[['",paste0("Hist_GL_", tag),"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            ## Histogram Part C done                                                 ##
            ###########################################################################
            
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            figureCount <- figureCount + 1
            
            
        }
        
        
        
        returnList <- list(
            "plotListRF" = plotListRF,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done sizing plots                                                         ##
###############################################################################


###############################################################################
## RNA feature plot                                                                ##


setGeneric(
    name="doDF_plotSL",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        library(DoubletFinder)
        
        SCTvar <- TRUE
        
        plotListDF <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        addList <- list()
        sampleNames <- as.vector(names(obj@sampleDetailList))
        pKlist <- list()
        bcmvnList <- list
        
        ## Determine min/max for all plots ##
        for (i in 1:length(sampleNames)){
            
            
            
            ## pK Identification (no ground-truth) ---------------------------------------------------------------------------------------
            # sweep.res.list <- paramSweep_v3(SampleList[[sampleNames[i]]], PCs = 1:10, sct = TRUE, num.cores =1)
            # sweep.stats <- summarizeSweep(sweep.res.list, GT = FALSE)
            # bcmvn_sample <- find.pK(sweep.stats)
            # pK <- grep(max(bcmvm_sample))
            # pKlist[[sampleNames[i]]] <- pK
            # bcmvnList[[sampleNames[i]]] <- bcmvn_sample
            # 
            # ## pK Identification (ground-truth) ------------------------------------------------------------------------------------------
            # sweep.res.list_OsC <- paramSweep_v3(OsC, PCs = 1:10, sct = TRUE)
            # gt.calls <- seu_kidney@meta.data[rownames(sweep.res.list_OsC[[1]]), "GT"]
            # sweep.stats_kidney <- summarizeSweep(sweep.res.list_kidney, GT = TRUE, GT.calls = gt.calls)
            # bcmvn_kidney <- find.pK(sweep.stats_kidney)
            
            ## Homotypic Doublet Proportion Estimate -------------------------------------------------------------------------------------
            annotations <- SampleList[[sampleNames[i]]]@meta.data[,"seurat_clusters"]
            homotypic.prop <- modelHomotypic(annotations)           ## ex: annotations <- seu_kidney@meta.data$ClusteringResults
            nExp_poi <- round(0.075*nrow(SampleList[[sampleNames[i]]]@meta.data))  ## Assuming 7.5% doublet formation rate - tailor for your dataset
            nExp_poi.adj <- round(nExp_poi*(1-homotypic.prop))
            
            ## Run DoubletFinder with varying classification stringencies ----------------------------------------------------------------
            #OsC_DF <- SampleList[[sampleNames[i]]]
            SampleList[[sampleNames[i]]] <- doubletFinder_v3(SampleList[[sampleNames[i]]], PCs = 1:10, pN = 0.25, pK = 0.09, nExp = nExp_poi, reuse.pANN = FALSE, sct = SCTvar)
            
            
            ## Adjust names ##
            names(SampleList[[sampleNames[i]]]@meta.data)[grep("pANN_",names(SampleList[[sampleNames[i]]]@meta.data))] <- "DF_pANN"
            
            names(SampleList[[sampleNames[i]]]@meta.data)[grep("DF.classifications",names(SampleList[[sampleNames[i]]]@meta.data))] <- "DF_Classification"
            
            dfAdd <- SampleList[[sampleNames[i]]]@meta.data[,c("DF_Classification", "DF_pANN")]
            addList[[sampleNames[i]]] <- dfAdd
            
            write.table(
                dfAdd,
                paste0(Obio@parameterList$localWorkDir,"DF_", sampleNames[i],".txt"),
                row.names = F,
                sep = "\t"
            )
            
            ## end new
            ## begin old
            dfT <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            if (i ==1){
                dfR <- dfT
            } else {
                dfR <- rbind(
                    dfT,
                    dfR
                )
            }
        }
        
        maxX <- 1.1*max(dfR$UMAP_1, na.rm = T)
        minX <- 1.1*min(dfR$UMAP_1, na.rm = T)
        maxY <- 1.1*max(dfR$UMAP_2, na.rm = T)
        minY <- 1.1*min(dfR$UMAP_2, na.rm = T)
        
        
        for (i in 1:length(sampleNames)){
            tag <- sampleNames[i]
            dfPlot <- SampleList[[sampleNames[i]]]@meta.data
            pos <- grep("included", names(dfPlot))
            if (length(pos) == 0){
                dfPlot[["included"]] <- "+"
            }
            dfPlot[["cellID"]] <- row.names(dfPlot)
            
            ## Get UMAP coordinates ##
            coord <- data.frame(SampleList[[sampleNames[i]]]@reductions$umap@cell.embeddings)
            coord[["cellID"]] <- row.names(coord)
            coord <-coord[coord$cellID %in% dfPlot$cellID, ]
            
            dfPlot <- merge(dfPlot, coord, by.x = "cellID", by.y="cellID", all=T)
            dfPlot[is.na(dfPlot)] <- 0
            dfPlot <- dfPlot[dfPlot$UMAP_1 != 0 & dfPlot$UMAP_2 != 0,]
            
            
            ## Add cluster colors ##
            dfPlot[["Cluster"]] <- paste0("C", dfPlot$seurat_clusters)
            clusterVec <- as.vector(paste0("C", unique(sort(dfPlot$seurat_clusters))))
            
            library(scales)
            clusterCols = hue_pal()(length(clusterVec))
            
            dfPlot$Cluster <- factor(dfPlot$Cluster, levels = clusterVec)
            
            
            
            plotListDF[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=DF_Classification)
            ) + geom_point( shape=16, size = as.numeric(dotsize)
            ) + xlab("UMAP1") + ylab("UMAP2")  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                legend.title = element_blank()
            ) + ggtitle(paste0("Sample: ", tag)
            ) + xlim(minX, maxX) + ylim(minY, maxY
            ) + scale_color_manual(values=c("#FF0000","#000000")
            ) + coord_fixed(ratio=1
            ) + theme_bw() 
            
            FNbase <- paste0("Sample.level.UMAP.", tag, VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            figLegend <- paste0(
                "**Figure ", 
                figureCount, 
                ":** ",
                " Sample-level UMAP plot for QC purposes. Download a pdf of this figure [here](", FNrel,")."
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r SL_UMAP_",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
                figLegend,"'}\n",
                "\n",
                "\n print(plotListDF[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            
        }
        
        
        returnList <- list(
            "plotListDF" = plotListDF,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount,
            #"pKlist" = pKlist,
            #"bcmvnList" = bcmvnList,
            "addList" = addList
        )
        
    })

## Done SL UMAP                                                              ##
###############################################################################


###############################################################################
## Create integration sample list                                            ##
setGeneric(
    name="createNormSampleList",
    def=function(
        obj,
        reduce = NULL #,
        #figureCount = 1,
        #VersionPdfExt = ".pdf",
        #tocSubLevel = 4
    ) {
        ## Create Sample List ##
        SampleList <- list()
        unionVarGenes <- as.vector(NULL, mode = "character")
        NtopGenes <- obj@parameterList$NtopGenes
        geneIntersectVec <- as.vector(NULL, mode="character")
        
        
        
        for (i in 1:length(obj@sampleDetailList)){
            sampleID <- names(obj@sampleDetailList)[i]
            
            # type must be in c("TenX", "matrixFiles", "loomFiles", "hdf5Files")
            if ( obj@sampleDetailList[[sampleID]]$type == "loomFiles" ){
                library(loomR)
                loomFN <- obj@sampleDetailList[[sampleID]]$path
                lfile <- connect(filename = loomFN, mode = "r+")
                
                fullMat <- lfile$matrix[, ]
                
                geneNames <- lfile[["row_attrs/Gene"]][]
                colnames(fullMat) <- geneNames 
                
                cellIDs <- lfile[["col_attrs/CellID"]][]
                
                row.names(fullMat) <- cellIDs
                
                fullMat <- t(fullMat)
                
            } else if (obj@sampleDetailList[[sampleID]]$type == "matrixFiles") {
                mFN <- obj@sampleDetailList[[sampleID]]$path
                
                fullMat <- read.delim(
                    mFN,
                    sep="\t",
                    stringsAsFactors = F
                )
                
            } else if (obj@sampleDetailList[[sampleID]]$type == "hdf5Files") {
                library(hdf5r)
                dataDir <- obj@sampleDetailList[[sampleID]]$path
                
                #print(paste0("Reading ", dataDir, "..."))
                
                assign(
                    "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                    Read10X_h5(filename = dataDir, use.names = TRUE, unique.features = TRUE)
                )
                
            } else {
                dataDir <- obj@sampleDetailList[[sampleID]]$path
                
                #print(paste0("Reading ", dataDir, "..."))
                
                assign(
                    "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                    Read10X(data.dir = dataDir)
                )
                
                
                
            }
            
            ## Remove -1 cells ##
            pos <- grep("-", colnames(fullMat))
            if (length(pos) > 0){
                repCols <- sapply(colnames(fullMat), function(x) unlist(strsplit(x, "-"))[1])
                
                if (length(unique(colnames(fullMat))) == length(unique(repCols)) ){
                    colnames(fullMat) <- repCols
                }
                
            }
            
            SampleList[[sampleID]] = CreateSeuratObject(
                counts = fullMat, 
                project = sampleID, 
                min.cells = 0, 
                min.features = obj@parameterList$SeuratNrnaMinFeatures
            )
            
            SampleList[[sampleID]]@meta.data[["sampleID"]] <-     
                sampleID
            
            if (!is.null(reduce)){
                set.seed(127)
                n.cells <- round(reduce * nrow(SampleList[[sampleID]]@meta.data))
                SampleList[[sampleID]] <- SubsetData(
                    SampleList[[sampleID]], 
                    cells.use = sample(x = object@cell.names, size = n.cells) )
            }
            
            ## Label mitochondrial cells ##
            if (Obio@parameterList$species == "mus_musculus"){
                mtSel <- "^mt-"
            } else if (Obio@parameterList$species == "homo_sapiens") {
                mtSel <- "^MT-"
            } else if (Obio@parameterList$species == "danio_rerio") {
                mtSel <- "^mt-"
            } else {
                mtSel <- "^MitoGene-"
            }
            
            SampleList[[i]][["percent.mt"]] <- PercentageFeatureSet(object =SampleList[[i]], pattern = mtSel)
            
            
            SampleList[[i]][["percent.mt"]] <- PercentageFeatureSet(
                object =SampleList[[i]], pattern = mtSel
            )
            ## Remove contaminating cells ##
            SampleList[[i]] <- subset(
                x = SampleList[[i]], 
                subset = nFeature_RNA > obj@sampleDetailList[[i]]$SeuratNrnaMinFeatures 
                & nFeature_RNA < obj@sampleDetailList[[i]]$SeuratNrnaMaxFeatures 
                & percent.mt < obj@sampleDetailList[[i]]$singleCellSeuratMtCutoff
            )
            
            ## Normalization 
            if (length(grep("scIntegrationMethod", names(obj@parameterList))) == 0){
                obj@parameterList$scIntegrationMethod <- "standard"
            }
            
            if (Obio@parameterList$scIntegrationMethod == "SCT"){
                SampleList[[i]] <- SCTransform(SampleList[[i]], verbose = FALSE)
                SampleList[[i]] <- NormalizeData(
                    SampleList[[i]], 
                    verbose = FALSE,
                    assay = "RNA"
                )
            } else {
                SampleList[[i]] <- NormalizeData(
                    SampleList[[i]], 
                    verbose = FALSE
                )
                
                SampleList[[i]] <- FindVariableFeatures(
                    SampleList[[i]],
                    selection.method = "vst",
                    nfeatures = NtopGenes,
                    verbose = FALSE
                )
                
                unionVarGenes <- unique(
                    c(
                        unionVarGenes, 
                        VariableFeatures(SampleList[[i]])
                    )
                )
                
                geneIntersectVec <- unique(
                    c(
                        geneIntersectVec, 
                        rownames(x = SampleList[[i]]@assays$RNA)
                    )
                )
                
            }
            
            
        }
        return(SampleList)
})
##                                                                           ##
###############################################################################

###############################################################################
## Create and Process sample List                                            ##

setGeneric(
    name="createSampleListQC",
    def=function(
        obj,
        reduce = NULL
        #figureCount = 1,
        #VersionPdfExt = ".pdf",
        #tocSubLevel = 4
    ) {
    ## Create Sample List ##
    SampleList <- list()
    
    for (i in 1:length(obj@sampleDetailList)){
        sampleID <- names(obj@sampleDetailList)[i]
        
        # type must be in c("TenX", "matrixFiles", "loomFiles", "hdf5Files")
        if ( obj@sampleDetailList[[sampleID]]$type == "loomFiles" ){
            library(loomR)
            loomFN <- obj@sampleDetailList[[sampleID]]$path
            lfile <- connect(filename = loomFN, mode = "r+")
            
            fullMat <- lfile$matrix[, ]
            
            geneNames <- lfile[["row_attrs/Gene"]][]
            colnames(fullMat) <- geneNames 
            
            cellIDs <- lfile[["col_attrs/CellID"]][]
            
            row.names(fullMat) <- cellIDs
            
            fullMat <- t(fullMat)
            
        } else if (obj@sampleDetailList[[sampleID]]$type == "matrixFiles") {
            mFN <- obj@sampleDetailList[[sampleID]]$path
            
            fullMat <- read.delim(
                mFN,
                sep="\t",
                stringsAsFactors = F
            )
            
        } else if (obj@sampleDetailList[[sampleID]]$type == "hdf5Files") {
            library(hdf5r)
            dataDir <- obj@sampleDetailList[[sampleID]]$path
            
            #print(paste0("Reading ", dataDir, "..."))
            
            assign(
                "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                Read10X_h5(filename = dataDir, use.names = TRUE, unique.features = TRUE)
            )
            
        } else {
            dataDir <- obj@sampleDetailList[[sampleID]]$path
            
            #print(paste0("Reading ", dataDir, "..."))
            
            assign(
                "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                Read10X(data.dir = dataDir)
            )
            
        }
        
        ## Remove -1 cells ##
        pos <- grep("-", colnames(fullMat))
        if (length(pos) > 0){
            repCols <- sapply(colnames(fullMat), function(x) unlist(strsplit(x, "-"))[1])
            
            if (length(unique(colnames(fullMat))) == length(unique(repCols)) ){
                colnames(fullMat) <- repCols
            }
            
        }
        
        SampleList[[sampleID]] = CreateSeuratObject(
            counts = fullMat, 
            project = sampleID, 
            min.cells = 0, 
            min.features = 0 #obj@parameterList$SeuratNrnaMinFeatures
        )
        
        SampleList[[sampleID]]@meta.data[["sampleID"]] <-     
            sampleID
        
        
        
        if (!is.null(reduce)){
            set.seed(127)
            n.cells <- round(reduce * nrow(SampleList[[sampleID]]@meta.data))
            SampleList[[sampleID]] <- SubsetData(
                SampleList[[sampleID]], 
                cells.use = sample(x = object@cell.names, size = n.cells) )
        }
        
        ## Normalise ##
        SampleList[[i]] <- SCTransform(SampleList[[i]])
        
        ## Label mitochondrial cells ##
        if (obj@parameterList$species == "mus_musculus"){
            mtSel <- "^mt-"
        } else if (obj@parameterList$species == "homo_sapiens") {
            mtSel <- "^MT-"
        } else if (obj@parameterList$species == "danio_rerio") {
            mtSel <- "^mt-"
        } else {
            mtSel <- "^MitoGene-"
        }
        
        SampleList[[i]][["percent.mt"]] <- PercentageFeatureSet(object =SampleList[[i]], pattern = mtSel)
        
        ## Do PCA ##
        SampleList[[i]] <- FindVariableFeatures(
            object = SampleList[[i]],
            selection.method = 'vst', 
            nfeatures = 2000
        )
        
    
        SampleList[[i]] <- ScaleData(SampleList[[i]], verbose = FALSE)
        
        SampleList[[i]] <- RunPCA(
            SampleList[[i]], 
            npcs = obj@sampleDetailList[[i]]$singleCellSeuratNpcs4PCA, verbose = FALSE
        )
        ## Do tSNE ##
        SampleList[[i]] <- RunTSNE(SampleList[[i]], reduction = "pca", dims = 1:20)
        
        ## Do UMAP ##
        SampleList[[i]] <- RunUMAP(SampleList[[i]], reduction = "pca", dims = 1:20)
        
        ## Do clustering ##
        SampleList[[i]] <- FindNeighbors(SampleList[[i]], reduction = "pca", dims = 1:20)
        SampleList[[i]] <- FindClusters(SampleList[[i]], resolution = obj@sampleDetailList[[i]]$singleCellClusterParameter)
        
        ## Annotated included/excluded cells ##
        SampleList[[i]]@meta.data[["selected"]] <- "+"
        SampleList[[i]]@meta.data[SampleList[[i]]@meta.data$percent.mt > obj@sampleDetailList[[i]]$singleCellSeuratMtCutoff  ,"selected"] <- ""
        SampleList[[i]]@meta.data[SampleList[[i]]@meta.data$nFeature_RNA > obj@sampleDetailList[[i]]$SeuratNrnaMaxFeatures  ,"selected"] <- ""
        SampleList[[i]]@meta.data[SampleList[[i]]@meta.data$nFeature_RNA < obj@sampleDetailList[[i]]$SeuratNrnaMinFeatures  ,"selected"] <- ""
    }
    return(SampleList)
        
})        
## Done Create and Process sample list                                       ##
###############################################################################


###############################################################################
## Do mt and feature selection plots                                         ##

setGeneric(
    name="doPercMT_plotSL",
    def=function(
        SampleList,
        obj,
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4
    ) {
    if (obj@parameterList$species == "mus_musculus"){
        mtSel <- "^mt-"
    } else if (obj@parameterList$species == "homo_sapiens") {
        mtSel <- "^MT-"
    } else if (obj@parameterList$species == "danio_rerio") {
        mtSel <- "^mt-"
    } else {
        mtSel <- "^MitoGene-"
    }
        
    plotListRF <- list()
    chnkVec <- as.vector(NULL, mode = "character")
        
    sampleNames <- as.vector(names(Obio@sampleDetailList))
        
    for (i in 1:length(sampleNames)){
            tag <- paste0("Hist_MT_", sampleNames[i])
            
            SampleList[[sampleNames[i]]]@meta.data[["included"]] <- "+"
            
            SampleList[[sampleNames[i]]]@meta.data[((SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA < obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMinFeatures) | (SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA > obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMaxFeatures)), "included"] <- "ex_N_Feat_RNA"
            
            SampleList[[sampleNames[i]]]@meta.data[(SampleList[[sampleNames[i]]]@meta.data$percent.mt > obj@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff ), "included"] <- "ex_MT_Perc"
            
            
            dfHist <-  SampleList[[sampleNames[i]]]@meta.data
            
            ## Fit GMM
            library(mixtools)
            x <- as.vector( dfHist$percent.mt)
            dfHist[["x"]] <- x
            fit <- normalmixEM(x, k = 2) #try to fit two Gaussians
            
            dfHist[["temp1"]] <- fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
            dfHist[["temp2"]] <- fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
            
            # https://labrtorian.com/tag/mixture-model/
            
            ## Calculate Mean for distribution 1
            
            x1meanLine <- fit$mu[1]
            x2meanLine <- fit$mu[2]
            
            ## Find histogram max count ##
            pTest <- ggplot(data=dfHist, aes(x=percent.mt, fill = included)
            ) + geom_histogram(binwidth=0.3
            ) 
            dfT <- ggplot_build(pTest)$data[[1]]
            yMax <- max(dfT$count)
            dMax1 <- max( fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1]))
            dMax2 <- max( fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2]))
            if (dMax1 > dMax2){
                dMax <- dMax1
                sF <- yMax/dMax
                dfHist[["fitVec1"]] <- sF *fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
                dfHist[["fitVec2"]] <- sF*fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
                dfHist[["x"]] <- fit$x
            } else {
                dMax <- dMax2
                sF <- yMax/dMax
                dfHist[["fitVec2"]] <- sF *fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
                dfHist[["fitVec1"]] <- sF*fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])
                dfHist[["x"]] <- fit$x
            }
            
            dfHist <- dfHist[order(dfHist$x, decreasing = F),]
            
            colVec <- unique(sort(SampleList[[sampleNames[i]]]@meta.data$included))
            library(RColorBrewer)
            reds <- c("#FF0000", "#ffa500", "#A30000")
            colVec <- c("#000000", reds[1:(length(colVec)-1)])
            
            
            
            plotListRF[[tag]] <- ggplot(data=dfHist, aes(x=percent.mt, fill = included)
            ) + geom_vline( xintercept = c(x1meanLine, x2meanLine), col="grey", linetype = "dashed"
            ) + geom_histogram(binwidth=0.3, alpha = 0.5
            ) + geom_vline( xintercept = obj@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff, col="red", linetype = "dashed"
            ) + scale_fill_manual(values=colVec) + geom_point(aes(x=x, y=fitVec1), color = "#009900", size = 0.5
            ) + geom_point(aes(x=x, y=fitVec2), color = "#FF0000", size = 0.1
            ) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            ) + geom_vline(xintercept = Obio@parameterList$SeuratNrnaMinFeatures, col="red"
            ) + geom_hline(yintercept = 0, col="black"
                           
            ) + labs(title = paste0("Histogram Percent Mitochondrial Genes per Cell ", names(SampleList)[i], " \n (SD1: ", round(sd(x),2),")") ,y = "Count", x = "Percent Mitochondrial Genes"
            ) + xlim(0, max(dfHist$x))
            
            ###########################################################################
            ## Save plot to file                                                     ##
            FNbase <- paste0("Historgram.MT",names(SampleList)[i], VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
                print(plotListRF[[tag]])
            dev.off()
            ##                                                                       ##
            ###########################################################################
            
            
            
            
            figCap <- paste0(
                "**Figure ",
                figureCount,
                "C:** Histogram depicting percent mitochondrial genes for each sample ", 
                names(SampleList)[i],
                ". ",
                "Download a pdf of this figure [here](", FNrel, "). "
            )
            
            NewChnk <- paste0(
                paste(rep("#", tocSubLevel), collapse=""), " ", tag,
                "\n```{r Gene_plot_chunk_Histogram-",tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",figCap,"'}\n",
                "\n",
                "\n print(plotListRF[['",tag,"']])",
                "\n cat(  '\n')",
                "\n\n\n```\n"   
            )
            
            ## Histogram Part C done                                                 ##
            ###########################################################################
            
            
            chnkVec <- c(
                chnkVec,
                NewChnk
            )
            
            figureCount <- figureCount + 1
            
            
        }
        
        
        
        returnList <- list(
            "plotListRF" = plotListRF,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )    
        
        
                
})        

## Done mt and feature selection plots                                       ##
###############################################################################
