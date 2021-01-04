
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
        sampleNames <- names(obj@sampleDetailList)

        rawSampleList <- list()
        filtSampleList <- list()

        for (i in 1:length(sampleNames)){
            if (obj@sampleDetailList[[sampleNames[i]]]$type == "TenX"){
                
                pos <- grep("gene.column", names(obj@sampleDetailList[[sampleNames[i]]]))
                if (length(pos) == 0){
                    gene.column = 2
                } else {
                    gene.column <-  obj@sampleDetailList[[i]]$gene.column
                }
                
                baseFN <- obj@sampleDetailList[[sampleNames[i]]]$path
                rawFN <- gsub("filtered_feature_bc_matrix", "raw_feature_bc_matrix", baseFN)

                if (file.exists(rawFN)){
                    rawSampleList[[sampleNames[i]]] <- Read10X(data.dir = rawFN, gene.column = gene.column)
                    filtSampleList[[sampleNames[i]]] <- Read10X(data.dir = baseFN, gene.column = gene.column)

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

            dfPlot$percent_mt <- as.numeric(dfPlot$percent_mt)



            plotListUMT[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=percent_mt)
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

        sampleNames <- as.vector(names(obj@sampleDetailList))

        for (i in 1:length(sampleNames)){
            tag <- sampleNames[i]

            SampleList[[sampleNames[i]]]@meta.data[["included"]] <- "+"

            SampleList[[sampleNames[i]]]@meta.data[((SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA < obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMinFeatures) | (SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA > obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMaxFeatures)), "included"] <- "ex_N_Feat_RNA"

            SampleList[[sampleNames[i]]]@meta.data[(SampleList[[sampleNames[i]]]@meta.data$percent_mt > obj@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff ), "included"] <- "ex_MT_Perc"


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
            ) + scale_fill_manual(values=colVec) + geom_point(aes(x=x, y=fitVec1), color = "#009900", size = 0.1
            ) + geom_point(aes(x=x, y=fitVec2), color = "#FF0000", size = 0.1
            ) + theme_bw(
            ) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            ) + geom_vline(xintercept = obj@sampleDetailList[[i]]$SeuratNrnaMinFeatures, col="red"
            ) + geom_hline(yintercept = 0, col="black"

            ) + labs(title = paste0("Histogram nFeatures RNA per cell ", names(SampleList)[i], " (SD1: ", round(sd(x),2),")") ,y = "Count", x = "nFeatures RNA"
            ) + xlim(0, max(dfHist$x))

            ###########################################################################
            ## Save plot to file                                                     ##
            FNbase <- paste0("Historgram.GL",names(SampleList)[i], VersionPdfExt)
            FN <- paste0(obj@parameterList$reportFigDir, FNbase)
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
            
            tempDir <- paste0(obj@parameterList$localWorkDir,"temp")
            if(!dir.exists(tempDir)){
                dir.create(tempDir)
            }

            write.table(
                dfAdd,
                paste0(obj@parameterList$localWorkDir,"temp/DF_", sampleNames[i],".txt"),
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
        reduce = NULL,
        vars.to.regress = NULL,
        g2m.genes = NULL,
        s.genes = NULL
        #vars to regress cell cycle options #c("S_Score", "G2M_Score) or
        #"CC_Difference"
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
                pos <- grep("gene.column", names(obj@sampleDetailList[[sampleID]]))
                if (length(pos) == 0){
                    gene.column = 2
                } else {
                    gene.column <-  obj@sampleDetailList[[sampleID]]$gene.column
                }
                
                dataDir <- obj@sampleDetailList[[sampleID]]$path

                #print(paste0("Reading ", dataDir, "..."))

                assign(
                    "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                    Read10X(data.dir = dataDir, gene.column = gene.column)
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
                cellVec <- row.names(SampleList[[sampleID]]@meta.data)
                cellVec <- cellVec[sample(1:length(cellVec), n.cells)]
                
                SampleList[[sampleID]] <- subset(
                    x = SampleList[[sampleID]],
                    cells = cellVec
                )
                
            }

            
            
            ## Label mitochondrial cells ##
            if (obj@parameterList$species == "mus_musculus"){
                mtSel <- "^mt-"
            } else if (obj@parameterList$species == "homo_sapiens") {
                mtSel <- "^MT-"
            } else if (obj@parameterList$species == "danio_rerio") {
                mtSel <- "^mt-"
            } else {
                stop("Mitochondrial gene identifier not specified for this species in function createNormSampleList().")
            }

            SampleList[[i]][["percent_mt"]] <- PercentageFeatureSet(object =SampleList[[i]], pattern = mtSel)


            SampleList[[i]][["percent_mt"]] <- PercentageFeatureSet(
                object =SampleList[[i]], pattern = mtSel
            )
            ## Remove contaminating cells ##
            SampleList[[i]] <- subset(
                x = SampleList[[i]],
                subset = nFeature_RNA > obj@sampleDetailList[[i]]$SeuratNrnaMinFeatures
                & nFeature_RNA < obj@sampleDetailList[[i]]$SeuratNrnaMaxFeatures
                & percent_mt < obj@sampleDetailList[[i]]$singleCellSeuratMtCutoff
            )

            ## Normalization
            if (length(grep("scIntegrationMethod", names(obj@parameterList))) == 0){
                obj@parameterList$scIntegrationMethod <- "standard"
            }

            if (obj@parameterList$scIntegrationMethod == "SCT"){
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
            }
            
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
            
            ## Assign cell cycle scores ##
            
            if (obj@parameterList$geneIDcolumn != "mgi_symbol" & obj@parameterList$geneIDcolumn != "hgnc_symbol") {
                queryGS <- "hgnc_symbol" 
            } else {
                queryGS <- obj@parameterList$geneIDcolumn
            }
            
            if (is.null(s.genes)){
                s.genes <- retrieve.gene.category.from.db(
                    cat_id = "ag_lab_categories__41",
                    password = db.pwd,
                    gene.symbol = queryGS,
                    user = obj@dbDetailList$db.user,
                    host = obj@dbDetailList$host
                )
            }
            
            if (is.null(g2m.genes)){
                g2m.genes <- retrieve.gene.category.from.db(
                    cat_id = "ag_lab_categories__42",
                    password = db.pwd,
                    gene.symbol = queryGS,
                    user = obj@dbDetailList$db.user,
                    host = obj@dbDetailList$host
                )
            }
            
            #Idents(SampleList[[sampleID]]) <- "sampleID"
            SampleList[[sampleID]] <- CellCycleScoring(
                SampleList[[sampleID]], 
                s.features = s.genes, 
                g2m.features = g2m.genes, 
                set.ident = TRUE
            )    
            ## Done adding cell cycle scores ##
            
            ## Remove dots from column names ##
            names(SampleList[[sampleID]]@meta.data) <- gsub("\\.", "_",names(SampleList[[sampleID]]@meta.data))
            
            ## Add G1 to G2M-S differences
            SampleList[[sampleID]]$CC_Difference <- SampleList[[sampleID]]$S_Score - SampleList[[sampleID]]$G2M_Score
            
            
            ## Regress out irrelevant items, if specified ##
            SampleList[[i]] <- ScaleData(
                SampleList[[i]], 
                verbose = FALSE,
                vars.to.regress = vars.to.regress,
                features = row.names(SampleList[[i]])
            )

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
        reduce = NULL,
        vars.to.regress = NULL,
        s.genes = NULL,
        g2m.genes = NULL
        #figureCount = 1,
        #VersionPdfExt = ".pdf",
        #tocSubLevel = 4
    ) {
    ## Create Sample List ##
    library(Seurat)
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
            pos <- grep("gene.column", names(obj@sampleDetailList[[sampleID]]))
            if (length(pos) == 0){
                gene.column = 2
            } else {
                gene.column <-  obj@sampleDetailList[[sampleID]]$gene.column
            }
            
            dataDir <- obj@sampleDetailList[[sampleID]]$path

            #print(paste0("Reading ", dataDir, "..."))

            assign(
                "fullMat", #names(obj@parameterList[[obj@parameterList$inputMode]])[i],
                Read10X(data.dir = dataDir, gene.column = gene.column)
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
            cellVec <- row.names(SampleList[[sampleID]]@meta.data)
            cellVec <- cellVec[sample(1:length(cellVec), n.cells)]
            
            SampleList[[sampleID]] <- subset(
                x = SampleList[[sampleID]],
                cells = cellVec
            )
            
        }

        
        
        ## Label mitochondrial cells ##
        if (obj@parameterList$species == "mus_musculus"){
            mtSel <- "^mt-"
        } else if (obj@parameterList$species == "homo_sapiens") {
            mtSel <- "^MT-"
        } else if (obj@parameterList$species == "danio_rerio") {
            mtSel <- "^mt-"
        } else {
            stop("mtSel not defined for this species in createSampleListQC")
            mtSel <- "^MitoGene-"
        }

        SampleList[[i]][["percent_mt"]] <- PercentageFeatureSet(object =SampleList[[i]], pattern = mtSel)
        names(SampleList[[i]]@meta.data) <- gsub("percent.mt","percent_mt",names(SampleList[[i]]@meta.data))

        ## Normalise ##
        SampleList[[i]] <- SCTransform(SampleList[[i]], verbose = FALSE)
        SampleList[[i]] <- NormalizeData(
            SampleList[[i]],
            verbose = FALSE,
            assay = "RNA"
        )
        
        ## Find variable features ##
        SampleList[[i]] <- FindVariableFeatures(
            object = SampleList[[i]],
            selection.method = 'vst',
            nfeatures =  obj@parameterList$NtopGenes
        )

        
        ## Assign cell cycle scores
        if (obj@parameterList$geneIDcolumn != "mgi_symbol" & obj@parameterList$geneIDcolumn != "hgnc_symbol") {
            queryGS <- "hgnc_symbol" 
        } else {
            queryGS <- obj@parameterList$geneIDcolumn
        }
        
        if (is.null(s.genes)){
            s.genes <- retrieve.gene.category.from.db(
                cat_id = "ag_lab_categories__41",
                password = db.pwd,
                gene.symbol = queryGS,
                user = obj@dbDetailList$db.user,
                host = obj@dbDetailList$host
            )
        }
        
        if (is.null(g2m.genes)){
            g2m.genes <- retrieve.gene.category.from.db(
                cat_id = "ag_lab_categories__42",
                password = db.pwd,
                gene.symbol = queryGS,
                user = obj@dbDetailList$db.user,
                host = obj@dbDetailList$host
            )
        }
        
        
        #Idents(SampleList[[sampleID]]) <- "orig.ident"
        SampleList[[sampleID]] <- CellCycleScoring(
            SampleList[[sampleID]], 
            s.features = s.genes, 
            g2m.features = g2m.genes, 
            set.ident = TRUE
        )    
        
        print(sampleID)
        print(names(SampleList[[sampleID]]@meta.data))
        
        ## Remove dots from column names ##
        names(SampleList[[sampleID]]@meta.data) <- gsub("\\.", "_",names(SampleList[[sampleID]]@meta.data))
        
        ## Add G1 to G2M-S differences
        SampleList[[sampleID]]$CC_Difference <- SampleList[[sampleID]]$S_Score - SampleList[[sampleID]]$G2M_Score
        
        
        ## 20201221 - added features = row.names(SampleList[[i]]) and vars to regress
        SampleList[[i]] <- ScaleData(
            SampleList[[i]], 
            verbose = FALSE,
            vars.to.regress = vars.to.regress,
            features = row.names(SampleList[[i]])
        )

        SampleList[[i]] <- RunPCA(
            SampleList[[i]],
            npcs = obj@sampleDetailList[[i]]$singleCellSeuratNpcs4PCA, 
            verbose = FALSE
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
        SampleList[[i]]@meta.data[SampleList[[i]]@meta.data$percent_mt > obj@sampleDetailList[[i]]$singleCellSeuratMtCutoff  ,"selected"] <- ""
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

    sampleNames <- as.vector(names(obj@sampleDetailList))

    for (i in 1:length(sampleNames)){
            tag <- paste0("Hist_MT_", sampleNames[i])

            SampleList[[sampleNames[i]]]@meta.data[["included"]] <- "+"

            SampleList[[sampleNames[i]]]@meta.data[((SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA < obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMinFeatures) | (SampleList[[sampleNames[i]]]@meta.data$nFeature_RNA > obj@sampleDetailList[[sampleNames[i]]]$SeuratNrnaMaxFeatures)), "included"] <- "ex_N_Feat_RNA"

            SampleList[[sampleNames[i]]]@meta.data[(SampleList[[sampleNames[i]]]@meta.data$percent_mt > obj@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff ), "included"] <- "ex_MT_Perc"


            dfHist <-  SampleList[[sampleNames[i]]]@meta.data

            ## Fit GMM
            library(mixtools)
            x <- as.vector( dfHist$percent_mt)
            dfHist[["x"]] <- x
            fit <- normalmixEM(x, k = 2) #try to fit two Gaussians

            dfHist[["temp1"]] <- fit$lambda[1]*dnorm(x,fit$mu[1],fit$sigma[1])
            dfHist[["temp2"]] <- fit$lambda[2]*dnorm(x,fit$mu[2],fit$sigma[2])

            # https://labrtorian.com/tag/mixture-model/

            ## Calculate Mean for distribution 1

            x1meanLine <- fit$mu[1]
            x2meanLine <- fit$mu[2]

            ## Find histogram max count ##
            pTest <- ggplot(data=dfHist, aes(x=percent_mt, fill = included)
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



            plotListRF[[tag]] <- ggplot(data=dfHist, aes(x=percent_mt, fill = included)
            ) + geom_vline( xintercept = c(x1meanLine, x2meanLine), col="grey", linetype = "dashed"
            ) + geom_histogram(binwidth=0.3, alpha = 0.5
            ) + geom_vline( xintercept = obj@sampleDetailList[[sampleNames[i]]]$singleCellSeuratMtCutoff, col="red", linetype = "dashed"
            ) + scale_fill_manual(values=colVec) + geom_point(aes(x=x, y=fitVec1), color = "#009900", size = 0.1
            ) + geom_point(aes(x=x, y=fitVec2), color = "#FF0000", size = 0.1
            ) +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12)
            ) + geom_vline(xintercept = obj@sampleDetailList[[i]]$singleCellSeuratMtCutoff, col="red"
            ) + geom_hline(yintercept = 0, col="black"

            ) + labs(title = paste0("Histogram Percent Mitochondrial Genes per Cell ", names(SampleList)[i], " \n (SD1: ", round(sd(x),2),")") ,y = "Count", x = "Percent Mitochondrial Genes"
            ) + xlim(0, max(dfHist$x)
            ) + theme_bw()

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

###############################################################################
## Do DGEsc                                                                  ##
setGeneric(
    name="doDGEsc",
    def=function(
        obj,
        DGEselCol = "sub_clusters_ExNeurons",
        colName = "DGE_name",
        contrastTag = "contrast_1_",
        DGEsampleList = list(
            "M1" = c(5),
            "M2" = c(1)
        )

    ) {

        myPaths <- .libPaths()
        myNewPaths <- c("/camp/stp/babs/working/boeings/Projects/pachnisv/song.chng/330_10xscRNAseq_DIV4_DIV11_DIV20_SC19069/basedata", myPaths)
        .libPaths(myNewPaths)
        library(glmGamPoi)
        .libPaths(myPaths)

        library(Seurat)
        obj@meta.data[[colName]] <- ""
        ## Add DGEsamples to meta.data
        for (i in 1:length(DGEsampleList)){
            obj@meta.data[obj@meta.data[,DGEselCol] %in% DGEsampleList[[i]], colName] <- names(DGEsampleList)[i]
        }

        dfMeta <- obj@meta.data
        dfMeta <- dfMeta[dfMeta[,colName] != "",]


        cellVec <- dfMeta$cellID
        group <-  as.vector(dfMeta[,colName])

        dfMatrix <- OsC[["RNA"]]@counts
        dfMatrix <- data.matrix(dfMatrix[,cellVec])
        dfMatrix <- dfMatrix[rowSums(dfMatrix) != 0, ]



        ## LRT ##
        # fit <- glm_gp(dfMatrix, design = group)
        # res <- test_de(fit, reduced_design = ~ 1)

        ## Pseudobulk ##
        #sample_labels <- rep(paste0("sample_", 1:6), length = ncol(pbmcs_subset))
        #cell_type_labels <- sample(c("T-cells", "B-cells", "Macrophages"), ncol(pbmcs_subset), replace = TRUE)


        #group <-  as.vector(dfMeta$Glia_vs_Neuro_all)
        sample_labels <- group
        sample_labels[sample_labels == names(DGEsampleList)[1]] <- paste0(sample_labels[sample_labels == names(DGEsampleList[1])], "_", 1:length(sample_labels[sample_labels == names(DGEsampleList)[1]]))

        sample_labels[sample_labels == names(DGEsampleList)[2]] <- paste0(sample_labels[sample_labels == names(DGEsampleList[2])], "_", 1:length(sample_labels[sample_labels == names(DGEsampleList)[2]]))

        cell_type_lables <- group
        unique(group)

        fit <- glm_gp(dfMatrix, design = group)
        comparison <- names(DGEsampleList)

        contrastString <- (paste0(comparison[1], " - ", comparison[2]))

        res <- test_de(fit, contrast = contrastString,
                       pseudobulk_by = sample_labels,
                       #subset_to = cell_type_labels == "T-cells",
                       #n_max = 4,
                       sort_by = pval,
                       decreasing = FALSE
        )

        dfRes <- res[order(res$lfc),]
        dfRes <- dfRes[dfRes$lfc > -100 & dfRes$lfc < 100, ]
        dfRes[["padj"]] <- dfRes$adj_pval
        minP <- min(dfRes$padj[dfRes$padj != 0])
        dfRes[dfRes$padj == 0, "padj"] <- minP
        dfRes[["lg10p"]] <- -1 * log10(dfRes$padj)


        comp_1 <- dfRes
        comp_1[["gene"]] <- dfRes$name
        names(comp_1) <- gsub("lfc", paste0(contrastTag, "logFC_" ,colName), names(comp_1))

        names(comp_1) <- gsub("padj", paste0(contrastTag, "padj_",colName), names(comp_1))
        names(comp_1) <- gsub("lg10p", paste0(contrastTag, "lg10p_",colName), names(comp_1))

        selVec <- c(
            "gene",
            names(comp_1)[grep(contrastTag, names(comp_1))]
        )

        comp_1 <- unique(comp_1[,selVec])

        pos <- grep(paste0("DGE_", DGEselCol), names(obj@dataTableList))

        returnList <- list(
            "OsC" = obj,
            DGEtable = comp_1
        )

        return(returnList)
    })


## End doDGEsc Function                                                      ##
###############################################################################

###############################################################################
## Get Marker Gene Table                                                     ##
setGeneric(
    name="addClusterMarkers2CatDisplay",
    def=function(
        obj,
        addCorCatsToLabDb = TRUE
    ) {
        
        
        
        
        dfGeneralMarkers <- obj@dataTableList$dfGeneralMarkers
        dfGeneralMarkers <- dfGeneralMarkers[dfGeneralMarkers$direction == "positive",]
        
        clusterVec <- sort(as.vector(unique(dfGeneralMarkers$cluster)))
        gmt.list <- list()
        max.length <- 0
        
        for (i in 1:length(clusterVec)){
            dfTemp <- dfGeneralMarkers[dfGeneralMarkers$cluster == clusterVec[i], ]
            geneVec <- sort(unique(dfTemp$gene))
            
            head <- paste0(obj@parameterList$project_id, "_Markers_Cluster_", clusterVec[i])
            cat.id <- paste0("temp_",obj@parameterList$project_id, "_cluster_marker_", clusterVec[i])
            head <- append(head, paste0("https:\\/\\/biologic.crick.ac.uk\\/", obj@parameterList$project_id, "\\/category-view/", cat.id))
            
            gmt.vec <- append(head, geneVec)
            gmt.list[[cat.id]] <- gmt.vec
            
            if (max.length < length(gmt.vec)){
                max.length <- length(gmt.vec)
            }
        }
        
        ## Add empty spaces to gmt.list to fill up to max.length
        for (i in 1:length(gmt.list)){
            n.add <- max.length - length(gmt.list[[i]])
            gmt.list[[i]] <- append(
                gmt.list[[i]], rep("", n.add)
            )
        }
        
        ## Transform list into gmt data frame ##
        for (i in 1:length(gmt.list)){
            if (i ==1){
                df.gmt <- t(gmt.list[[i]])
            } else {
                df.gmt <- rbind(df.gmt, t(gmt.list[[i]]))
            }
        }
        
        ## Ensure df.gmt is a data frame
        df.gmt <- data.frame(df.gmt)
        
        
        ## Write to file #3
        #setwd(obj@parameterList$localWorkDir)
        FNc <- paste0(obj@parameterList$localWorkDir, obj@parameterList$projectID, ".cluster.marker.genes.gmt")
        write.table(df.gmt, FNc, row.names = FALSE, col.names = FALSE, sep="\t")
        
        
        ## Remove old entries for this project
        
        if (addCorCatsToLabDb){
            library(RMySQL)
            dbDB = RMySQL::dbConnect(
                drv = RMySQL::MySQL(),
                user = obj@parameterList$db.user,
                password = db.pwd,
                dbname = obj@dbDetailList$ref.cat.db,
                host = obj@dbDetailList$host
            )
            
            dbGetQuery(dbDB, paste0("DELETE FROM ", obj@parameterList$lab.categories.table, " WHERE cat_type='temp_cluster_marker_", obj@parameterList$project_id,"'"))
            RMySQL::dbDisconnect(dbDB)
            
            ## Done removing older categories for this project
            
            msigdb.gmt2refDB(
                df.gmt = df.gmt, #gmt.file = "cor.categories.gmt",
                host = obj@dbDetailList$host,
                db.user = obj@dbDetailList$db.user,
                pwd = db.pwd,
                ref.db = obj@dbDetailList$ref.cat.db,
                ref.db.table = obj@parameterList$lab.categories.table,
                cat_type = paste0("temp_cluster_marker_", obj@parameterList$project_id),
                data_source = "DGE Cluster Marker Genes",
                keep.gene.values = FALSE,
                gene.id = obj@parameterList$geneIDcolumn,
                create.new.table = FALSE,
                mm.hs.conversion.file =  paste0(hpc.mount, "Projects/reference_data/20160303.homologene.data.txt")
            )
        }
    })

## Done                                                                      ##
###############################################################################

###############################################################################
## Cell Cycle Barchart per sample                                             ##

# This function will display cell cycle phase estimates per sample ##
setGeneric(
    name="doCellCycleBarchart",
    def=function(
        SampleList,
        obj = "Obio",
        figureCount = 1,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        cellCycleRefFile = 'paste0(hpc.mount, "Projects/reference_data/cell_cycle_vignette_files/nestorawa_forcellcycle_expressionMatrix.txt")'
        
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        library(Seurat)
        
        exp.mat <- read.table(file = cellCycleRefFile, header = TRUE, 
                              as.is = TRUE, row.names = 1)
        
        
        # A list of cell cycle markers, from Tirosh et al, 2015, is loaded with Seurat.  We can
        # segregate this list into markers of G2/M phase and markers of S phase
        s.genes <- cc.genes$s.genes
        g2m.genes <- cc.genes$g2m.genes
        
        print(paste0("Used as S-phase marker genes: ", sort(unique(paste(s.genes, collapse = ", ")))))
        print(paste0("Used as G2M-phase marker genes: ", sort(unique(paste(g2m.genes, collapse = ", ")))))
        
        
        
        
        plotList <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        sampleNames <- as.vector(names(obj@sampleDetailList))
        
        ## Calculate cell cycle scores for each individual sample ##
        Idents(SampleList[[sampleNames[i]]]) <- "sampleID"
        
        for (i in 1:length(sampleNames)){
            # Create our Seurat object and complete the initalization steps
            SampleList[[sampleNames[i]]] <- CellCycleScoring(
                SampleList[[sampleNames[i]]], 
                s.features = s.genes, 
                g2m.features = g2m.genes, 
                set.ident = TRUE
            )
            
            NcellsS <- nrow(SampleList[[sampleNames[i]]]@meta.data[SampleList[[sampleNames[i]]]@meta.data$Phase == "S",])
            NcellsG2M <- nrow(SampleList[[sampleNames[i]]]@meta.data[SampleList[[sampleNames[i]]]@meta.data$Phase == "G2M",])
            NcellsG1 <- nrow(SampleList[[sampleNames[i]]]@meta.data[SampleList[[sampleNames[i]]]@meta.data$Phase == "G1",])
            Nsum <- sum(c(NcellsS, NcellsG2M, NcellsG1))
            PercS <- NcellsS/Nsum
            PercG2M <- NcellsG2M/Nsum
            PercG1 <- NcellsG1/Nsum
            
            dfTempRes <- data.frame(
                sampleName = rep(sampleNames[i], 3), 
                Phase = c("G1", "S", "G2M"),
                Ncells = c(NcellsG1, NcellsS, NcellsG2M),
                PercCells = c(PercG1, PercS, PercG2M)
            )
            
            if (i ==1){
                dfRes <- dfTempRes
            } else {
                dfRes <- rbind(dfRes, dfTempRes)
            }
            
            
            
        }    
        
        tag <- "CellCycle_Barchart_Ncells"    
        plotList[[tag]] <- ggplot(
            data=dfRes, aes(x= sampleName, y=Ncells, fill=Phase)
        ) + geom_bar(stat="identity", colour="black"
        ) + coord_flip()   + theme_bw() +  theme(
            axis.text.y   = element_text(size=8),
            axis.text.x   = element_text(size=8),
            axis.title.y  = element_text(size=8),
            axis.title.x  = element_text(size=8),
            axis.line = element_line(colour = "black"),
            panel.border = element_rect(colour = "black", fill=NA, size=1),
            plot.title = element_text(hjust = 0.5, size = 12)
        ) + labs(title = paste0(gsub("_", " ", tag)," enriched genes") ,y = "N Cells", x = ""
        ) 
        
        FNbase <- paste0("Sample.", tag, VersionPdfExt)
        FN <- paste0(obj@parameterList$reportFigDir, FNbase)
        FNrel <- paste0("report_figures/", FNbase)
        
        figLegend <- paste0(
            "**Figure ",
            figureCount,
            ":** ",
            " Sample-level cell cycle estimates. Download a pdf of this figure [here](", FNrel,")."
        )
        
        figureCount <- figureCount + 1
        
        NewChnk <- paste0(
            paste(rep("#", tocSubLevel), collapse=""), " ", tag,
            "\n```{r sample_",
            tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
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
        
        tag <- "CellCycle_Barchart_Percent_Cells"    
        plotList[[tag]] <- ggplot(
            data=dfRes, aes(x= sampleName, y=PercCells, fill=Phase)
        ) + geom_bar(stat="identity", colour="black"
        ) + coord_flip()   + theme_bw() +  theme(
            axis.text.y   = element_text(size=8),
            axis.text.x   = element_text(size=8),
            axis.title.y  = element_text(size=8),
            axis.title.x  = element_text(size=8),
            axis.line = element_line(colour = "black"),
            panel.border = element_rect(colour = "black", fill=NA, size=1),
            plot.title = element_text(hjust = 0.5, size = 12)
        ) + labs(title = paste0(gsub("_", " ", tag)," enriched genes") ,y = "Percent Cells", x = ""
        ) 
        
        
        
        FNbase <- paste0("Sample.", tag, VersionPdfExt)
        FN <- paste0(obj@parameterList$reportFigDir, FNbase)
        FNrel <- paste0("report_figures/", FNbase)
        
        figLegend <- paste0(
            "**Figure ",
            figureCount,
            ":** ",
            " Sample-level cell cycle estimates. Download a pdf of this figure [here](", FNrel,")."
        )
        
        figureCount <- figureCount + 1
        
        NewChnk <- paste0(
            paste(rep("#", tocSubLevel), collapse=""), " ", tag,
            "\n```{r sample_",
            tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
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
        
        
        
        
        
        returnList <- list(
            "plotList" = plotList,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done Cell Cycle Barchart                                                  ##
###############################################################################

###############################################################################
## Cell Cycle UMAP per sample                                                ##

# This function will display cell cycle phase estimates per sample ##
setGeneric(
    name="doUMAP_cellCyle",
    def=function(
        SampleList,
        obj = Obio,
        figureCount = figureCount,
        VersionPdfExt = ".pdf",
        tocSubLevel = 4,
        dotsize = 0.5,
        cellCycleRefFile = paste0(hpc.mount, "Projects/reference_data/cell_cycle_vignette_files/nestorawa_forcellcycle_expressionMatrix.txt")
    ) {
        ###############################################################################
        ## Make plots                                                                ##
        library(Seurat)
        
        exp.mat <- read.table(file = cellCycleRefFile, header = TRUE, 
                              as.is = TRUE, row.names = 1)
        
        
        # A list of cell cycle markers, from Tirosh et al, 2015, is loaded with Seurat.  We can
        # segregate this list into markers of G2/M phase and markers of S phase
        s.genes <- cc.genes$s.genes
        g2m.genes <- cc.genes$g2m.genes
        
        print(paste0("Used as S-phase marker genes: ", sort(unique(paste(s.genes, collapse = ", ")))))
        print(paste0("Used as G2M-phase marker genes: ", sort(unique(paste(g2m.genes, collapse = ", ")))))
        
        
        
        
        plotList <- list()
        chnkVec <- as.vector(NULL, mode = "character")
        sampleNames <- as.vector(names(obj@sampleDetailList))
        
        ## Calculate cell cycle scores for each individual sample ##
        Idents(SampleList[[sampleNames[i]]]) <- "sampleID"
        
        for (i in 1:length(sampleNames)){
            # Create our Seurat object and complete the initalization steps
            SampleList[[sampleNames[i]]] <- CellCycleScoring(
                SampleList[[sampleNames[i]]], 
                s.features = s.genes, 
                g2m.features = g2m.genes, 
                set.ident = TRUE
            )
            
            ###############################################################################
            ## Make one UMAP plot per sample                                             ##
            
            sampleVec <- sampleNames[i]
            
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
            dfPlot$UMAP_1 <- NULL
            dfPlot$UMAP_2 <- NULL
            
            dfPlot <- merge(dfPlot, coord, by.x = "cellID", by.y="cellID", all=T)
            dfPlot[is.na(dfPlot)] <- 0
            dfPlot <- dfPlot[dfPlot$UMAP_1 != 0 & dfPlot$UMAP_2 != 0,]
            
            
            ## Add cluster colors ##
            #dfPlot[["Cluster"]] <- paste0("C", dfPlot$seurat_clusters)
            #clusterVec <- as.vector(paste0("C", unique(sort(dfPlot$seurat_clusters))))
            
            #library(scales)
            #clusterCols = hue_pal()(length(clusterVec))
            
            #dfPlot$Cluster <- factor(dfPlot$Cluster, levels = clusterVec)            
            
            maxX <- 1.1*max(dfPlot$UMAP_1, na.rm = T)
            minX <- 1.1*min(dfPlot$UMAP_1, na.rm = T)
            maxY <- 1.1*max(dfPlot$UMAP_2, na.rm = T)
            minY <- 1.1*min(dfPlot$UMAP_2, na.rm = T)               
            
            
            tag <- paste0("UMAP_Cell_Cycle_Plot_", sampleNames[i])
            
            plotList[[tag]] <- ggplot(data=dfPlot[dfPlot$included == "+",], aes(UMAP_1, UMAP_2, color=Phase)
            ) + geom_point( shape=16, size = as.numeric(dotsize)
            ) + xlab("UMAP1") + ylab("UMAP2"
            ) + theme_bw(
            )  +  theme(
                axis.text.y   = element_text(size=8),
                axis.text.x   = element_text(size=8),
                axis.title.y  = element_text(size=8),
                axis.title.x  = element_text(size=8),
                axis.line = element_line(colour = "black"),
                panel.border = element_rect(colour = "black", fill=NA, size=1),
                plot.title = element_text(hjust = 0.5, size = 12),
                legend.title = element_blank()
            ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
            ) + ggtitle(paste0(gsub("_", " ",tag))
            ) + xlim(minX, maxX) + ylim(minY, maxY
            ) + coord_fixed(ratio=1
            ) 
            
            if (length(unique(dfPlot$Cluster)) > 15){
                plotList[[tag]] <- plotList[[tag]] + theme(legend.position = "none")
            }
            
            FNbase <- paste0(tag, VersionPdfExt)
            FN <- paste0(Obio@parameterList$reportFigDir, FNbase)
            FNrel <- paste0("report_figures/", FNbase)
            
            pdf(FN)
            print(plotList[[tag]])
            dev.off()
            
            figLegend <- paste0(
                '**Figure ', 
                figureCount, 
                ':** ',
                ' Sample-level UMAPs. Estimated cell-cylce phase color-coded. Download a pdf of this figure <a href="',FNrel,'" target="_blank">here</a>.'
            )
            
            figureCount <- figureCount + 1
            
            NewChnk <- paste0(
                paste("#### ", tag),
                "\n```{r ",
                tag,", results='asis', echo=F, eval=TRUE, warning=FALSE, fig.cap='",
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
            
            ## Done making one umap plot per sample                                      ##
            ###############################################################################
        }  ## End looping through samples
        
        returnList <- list(
            "plotList" = plotList,
            "chnkVec" = chnkVec,
            "figureCount" = figureCount
        )
        
    })

## Done Cell Cycle UMAP per sample                                           ##
###############################################################################

