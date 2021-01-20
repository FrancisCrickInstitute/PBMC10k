###############################################################################
##  Feature View Shiny App                                                   ##       


##                                                                           ##
###############################################################################


###############################################################################
## Load required packages                                                    ##       
library(ggplot2)
library(RMySQL)
library(gridExtra)
##                                                                           ##
###############################################################################


###############################################################################
## Make dfTemp   

    
    

##                                                                           ##
###############################################################################


###############################################################################
## Create plot namespace                                                     ##

plot_overlay_ui <- function(id) {
    ns <- NS(id)
    tagList(
        plotOutput(ns("my_plot"), 
                   width = "100%")
    )
}

##                                                                           ##
###############################################################################


###############################################################################
##                                                                           ##


plot_overlay_server <- function(
    input,
    output,
    session, 
    df,
    plot_name,
    colorBy = "lg10Expr",
    dotsize = "dotsize",
    lowColor = "grey", 
    dotcolor = "darkblue",
    x_axis = "UMAP_1",
    y_axis = "UMAP_2",
    background = "grey",
    maxX = NULL,
    minX = NULL,
    maxY = NULL,
    minY = NULL,
    geneSel = NULL
) {
    library(ggplot2)
    
    if (is.null(maxX)){
      maxX <- 1.1*max(df$x_axis, na.rm = T)  
    } 
  
    if (is.null(maxY)){
      maxY <- 1.1*max(df$y_axis, na.rm = T)  
    }
  
    if (is.null(minX)){
      minX <- 1.1*min(df$x_axis, na.rm = T)  
    } 
    
    if (is.null(minY)){
      minY <- 1.1*min(df$y_axis, na.rm = T)  
    }
    
    nCellsTotal <- nrow(df)
    nExpr <- nrow(df[df$gene != 0,])
    percExpr <- 100*round(nrow(df[df$gene != 0,])/nCellsTotal, 3)
    qGene <- unique(na.omit(df$gene))
    qGene <- qGene[qGene != 0]
    
    plotInput <- reactive({
        
        if( is.numeric( df$Dcolor ) ) {
            minExpr <- floor(min(df$Dcolor, na.rm = T))
            maxExpr <- ceiling(max(df$Dcolor, na.rm = T))   
            if (maxExpr == 1){
                ceiling_dec <- function(x, level=1) round(x + 5*10^(-level-1), level)
                maxExpr <- ceiling_dec(max(df$Dcolor, na.rm = T),2)   
            }
            
        } else {
          df$Dcolor[df$Dcolor == ""] <- "Rest"
          df$Dcolor <- factor(df$Dcolor)
        }     
      
        
        
        
        p <- ggplot( data = df, aes(x_axis, y_axis, color=Dcolor)
        )+ geom_point(
            shape = 16,
            size = as.numeric(dotsize)
        ) + xlab(x_axis) + ylab(y_axis)
        
        if (is.numeric( df$Dcolor )){
            if (minExpr < 0){
              p <- p + scale_color_gradient2("Expr",low= lowColor, mid = "white", high= dotcolor, midpoint = 0, limits=c(minExpr,maxExpr)
              )
              
             } else {
              p <- p + scale_color_gradient("Expr",low= lowColor, high= dotcolor, limits=c(minExpr,maxExpr)
              )
            }
            
        } else if (colorBy == "DF_Classification" & length(unique(df$Dcolor)) == 2) {
            p <- p + scale_colour_manual("Doublet Class",values = c("red","black")
            ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
            )
        } else if (colorBy == "all") {
            p <- p + scale_colour_manual("All",values = c("black")
            ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
            )
        }  else if (colorBy == "clusterName"){
          dfCol <- unique(df[,c("clusterName", "clusterColor")])
          colVec <- dfCol$clusterCol
          names(colVec) <- dfCol$clusterName
          colVec <- colVec[colVec != ""]
        
          
          p <- p + scale_colour_manual("Cluster Names" ,values = colVec
          ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
          )
        } else if (colorBy == "subClusterName"){  
          df$subClusterName <- gsub("^$", "Rest",df$subClusterName)
          dfCol <- unique(df[,c("subClusterName", "subClusterColor")])
          dfCol[dfCol$subClusterName == "Rest", "subClusterColor"] <- "#d3d3d3"
          colVec <- dfCol$subClusterColor
          names(colVec) <- dfCol$subClusterName
         
          colVec <- colVec[colVec != ""]
          p <- p + scale_colour_manual("Sub-cluster Names" ,values = colVec
          ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
          )
          
        } else if (colorBy == "sampleName"){  
          dfCol <- unique(df[,c("sampleName", "sampleColor")])
          colVec <- dfCol$sampleColor
          names(colVec) <- dfCol$sampleName
          colVec <- colVec[colVec != ""]
          p <- p + scale_colour_manual("Sample Names" ,values = colVec
          ) + guides(col = guide_legend(override.aes = list(shape = 16, size = 5))
          )
          
        }
        
        if (!is.numeric(df$x_axis)){
            p <- p + geom_jitter(height = 0) 
            
            
        }
        
        
        
        if (background == "white"){
          p <- p + theme_bw()
        } else if (background == "minimal"){
          p <- p + theme_minimal()
        } else if (background == "plain"){
          p <- p + theme_void()
        } else {
          p <- p + theme(
            panel.background = element_rect(fill = "lightgrey")
          )
        }
        
        p <- p + theme(
          axis.text.y   = element_text(size=8),
          axis.text.x   = element_text(size=8),
          axis.title.y  = element_text(size=8),
          axis.title.x  = element_text(size=8),
          axis.line = element_line(colour = "black"),
          panel.border = element_rect(colour = "black", fill=NA, size=1),
          plot.title = element_text(hjust = 0.5, size = 12)
        ) 
        
        if (is.numeric(df$x_axis)){
          p <- p + xlim(minX, maxX) 
        }
        
        if (is.numeric(df$y_axis)){
          p <- p + ylim(minY, maxY) 
        }
        
        if (colorBy == "lg10Expr" | x_axis == "lg10Expr" | y_axis == "lg10Expr") {
            titleString <- paste0("Sample: ", plot_name, " ", nExpr, "/", nCellsTotal, " cells (",percExpr,"%) express ", geneSel)
        } else {
            titleString <-paste0("Sample: ", plot_name)
        }
        
        p <- p + ggtitle(titleString) 
        #+ ggtitle(paste0("Gene ", input$gene, " in sample ", conditionVec[i], " (E:",cellsExpressingGene[i],"/NE:",cellsNotExpressingGene[i], ", ",percE[i],"%)")) + scale_size_continuous(limits = c(0, maxExpr)
        #) #+ xlim(minX, maxX) + ylim(minY, maxY)

        posX <- grep("UMAP", x_axis)
        posY <- grep("UMAP", y_axis)
        if ( (length(posX) == 1) & (length(posY) == 1)){
                    p <-  p + coord_fixed()
        }
        
        
        
        
        p
    })
    
    output$my_plot <- renderPlot({
        
        print(plotInput())
        
    })
    
    
}

# -------------------------------------------------------------------------

dfkey <- read.delim("connect/db.txt", header = T, sep="\t", stringsAsFactors = F)
geneDefault = as.character(dfkey$default)

host <- as.character(dfkey$url)
user <- as.character(dfkey$id)
DBpd <- as.character(dfkey$id2)
dbname <- as.character(dfkey$db)
coordinateTbName <- as.character(dfkey$coordTb)
exprTbName <- as.character(dfkey$exprTb)
geneID_TbName <- as.character(dfkey$geneTb)

oldw <- getOption("warn")
options(warn = -1)

dbDB <- dbConnect(MySQL(), user = user, password = DBpd, host = host, dbname=dbname)
query <- paste0("SELECT DISTINCT gene FROM ", geneID_TbName)
allGenes <- as.vector(dbGetQuery(dbDB, query)[,"gene"])
allGenes <- c(geneDefault, allGenes)
dbDisconnect(dbDB)


###############################################################################
##                                                                           ##       


shinyServer(
  function(input, output, session) {
        
      
      
    
      #########################################################################
      ## Handle get requests                                                 ##
    observe({
      query <- parseQueryString(session$clientData$url_search)
      if ((!is.null(query[['gene']]))) {
          if (query[['gene']] %in% allGenes){
              geneSel <- query[['gene']]
          } else {
            geneSel <- geneDefault
          }
        updateSelectizeInput(session, 'gene', choices = allGenes, server = TRUE, selected = geneSel) 
        
      } else {
        geneSel <- geneDefault
        updateSelectizeInput(session, 'gene', choices = allGenes, server = TRUE, selected = geneSel) 
        
      }
      
      if (geneSel == ""){
        geneSel <- geneDefault
      }  
      
        
      
    })  
    
    observeEvent(input$gene, {
      updateQueryString(paste0("?gene=",input$gene), mode = "replace")
    })
    
    
    
      #output$dev_text <- renderPrint({ 
      #  plot_data_names()
      #})
      
      
      ## Done handling inputs                                                ##
      #########################################################################
      
      ###############################################################################
      ## Load dfCoord from db                                                      ##
      
      createDfCoord <- reactive({
          oldw <- getOption("warn")
          options(warn = -1)
          dbDB <- dbConnect(MySQL(), user = user, password = DBpd, host = host, dbname=dbname)
          query <- paste0("SELECT DISTINCT * FROM ", coordinateTbName)
          dfCoordSel <- dbGetQuery(dbDB, query)
          
          dbDisconnect(dbDB)
          
          dfCoordSel$row_names <- NULL
          dfCoordSel[["all"]] <- "all"  
          
          # clusterCols <- unique(
          #   c(
          #     names(dfCoordSel)[grep("cluster", names(dfCoordSel))],
          #     names(dfCoordSel)[grep("Cluster", names(dfCoordSel))]
          #   )
          # )
          # 
          # 
          # 
          # if (length(clusterCols) > 0){
          #     for (m in 1:length(clusterCols)){
          #         clusters <- sort(unique(dfCoordSel[, clusterCols[m]]))
          #         tag <- paste0(clusterCols[m], "_number")
          #         dfCoordSel[[tag]] <- -1
          #         for (k in 1:length(clusters)){
          #             dfCoordSel[dfCoordSel[,clusterCols[m]] == clusters[k],  tag ] <- k
          #         }
          #     }
          # }
          # 
          # output$dev_text <- renderPrint({ 
          #   names(dfCoordSel)
          # })
          
          
          
          dfCoordSel
          
      })
      #end_time <- Sys.time()
      #print(paste0("Q S1 DBQ Coordinates: ",end_time - start_time))
      ##                                                                           ##
      ###############################################################################
      
      #########################################################################
      ## Retrieve Coordinates for this query
      
      ## Done retrieving Coordinates
      #########################################################################
      
      ###########################################################################
      ## Database query for dfExpr                                             ##
      ## create agl315_gene_expr_tb
      #start_time <- Sys.time()
      createDfExprSel <- reactive({
          oldw <- getOption("warn")
          options(warn = -1)
          dbDB <- dbConnect(MySQL(), user = user, password = DBpd, host = host, dbname=dbname)
          
          if ( is.null(input$gene) | input$gene == "" ){
            query <- paste0("SELECT * FROM ",exprTbName," WHERE gene = '",geneDefault,"'" )  
          } else {
            query <- paste0("SELECT * FROM ",exprTbName," WHERE gene = '",input$gene,"'" )
          }
          
          #query <- paste0("SELECT DISTINCT * FROM agl315_gene_expr_tb WHERE gene = 'GFAP'" )
          dfExprSel <- dbGetQuery(dbDB, query)
          dbDisconnect(dbDB)
          
          names(dfExprSel) <- gsub("condition", "cellID", names(dfExprSel))
          names(dfExprSel) <- gsub("^expr$", "lg10Expr", names(dfExprSel))
          dfExprSel$cellID <- gsub("[.]", "-", dfExprSel$cellID)
          dfExprSel$cellID <- gsub("^X", "", dfExprSel$cellID)
          dfExprSel
      })
      
      #end_time <- Sys.time()
      #print(paste0("Q S2 agl315_gene_expr_tb: ",end_time - start_time))
      #paste0("SELECT DISTINCT gene, condition, expr FROM agl315_gene_expr_tb WHERE gene = '",input$gene,"'" )
      ## Done db query                                                         ##
      ###########################################################################
      
      ###############################################################################
      ## Create dfTemp                                                             ##       
      createDfTemp <- reactive({
          
          
          dfTemp <- merge(createDfCoord(), createDfExprSel(), by.x = "cellID", by.y="cellID", all=TRUE)
          dfTemp[is.na(dfTemp)] <- 0
          dfTemp <- data.frame(dfTemp, stringsAsFactors = FALSE)
          dfTemp$gene <- as.character(dfTemp$gene)
          
          conditionVec <- sort(unique(dfTemp[,input$splitByColumn]))   
          
          dfTemp[["Dcolor"]] <- dfTemp[,input$colorBy]
          
          # if (!(input$colorBy %in% c("lg10Expr"))){
          #     dfTemp$Dcolor <- factor(dfTemp$Dcolor) 
          # } else {
          #     dfTemp$Dcolor <- as.numeric(dfTemp$Dcolor)        
          # } 
          
          
          
          # if (input$x_axis == "clusterName"){
          #     clusters <- sort(unique(dfTemp[,input$x_axis]))
          #     
          #     dfTemp[["x_axis"]] <- dfTemp[,paste0( input$x_axis, "_number")]
          #    
          #     
          # } else {
          #     dfTemp[["x_axis"]] <- dfTemp[,input$x_axis]    
          # }
          
          dfTemp[["x_axis"]] <- dfTemp[,input$x_axis]   
          
          if (!is.numeric(dfTemp$x_axis)){
              dfTemp$x_axis <- factor(dfTemp$x_axis, levels = sort(unique(dfTemp$x_axis)))
          }
          
          dfTemp[["y_axis"]] <- dfTemp[,input$y_axis]
          # clusterColorColName <- "clusterName"
          # dfCol <- unique(dfTemp[,c("clusterName", "clusterColor")])
          # colVec <- dfCol$clusterColor
          # names(colVec) <- dfCol$clusterName
          # 
          # subClusterColorColName <- "subClusterName"
          # dfCol <- unique(dfTemp[,c("subClusterName", "subClusterColor")])
          # sColVec <- dfCol$subClusterColor
          # names(sColVec) <- dfCol$subClusterName
          # sColVec <- sColVec[sColVec != ""]
          # 
          # levels <- 
          # dfTemp[["Cluster"]] <- factor(dfTemp[,clusterColorColName], levels = sort(unique(dfTemp[,clusterColorColName])))   
          # #dfTemp$clusterName <- as.numeric(dfTemp$clusterName)
          
          
          # if (input$colorBy == "lg10Expr"){
          #     selVec <- unique(c( "gene", "lg10Expr", "x_axis", "y_axis", "Dcolor", "cellID", "sampleID", input$splitByColumn))
          # } else {
          #     selVec <- unique(c( "gene", "lg10Expr", "x_axis", "y_axis", "Dcolor", "cellID", "sampleID", input$colorBy, input$splitByColumn))
          # }
          # 
          
          
          
          #dfTemp <- dfTemp[,selVec]  
          dfTemp <- dfTemp[(dfTemp$x_axis != 0 | dfTemp$y_axis != 0),] 
          dfTemp
      })
      ##                                                                           ##
      ###############################################################################
      
      
      plot_select <- reactive({
            df <- createDfTemp()
            df[["all"]] <- "all"
            as.vector(unique(df[, input$splitByColumn]))
      })
      
      
      
      
      
      # library(DT)
      # 
      # output$table5 <- DT::renderDataTable({
      #     plot_data()[[1]]
      # }) 
      
     
      
      
      
     
      toListen <- reactive({
          list(
              input$gene,
              input$x_axis,
              input$y_axis,
              input$splitByColumn,
              input$dotsize,
              input$colorBy,
              input$lowColor, 
              input$dotcolor,
              input$background
          )
      })
      
      
      plot_data_names <- reactive({
        dfTemp <- createDfTemp()
        
        plot_select <- sort(as.vector(unique(dfTemp[, input$splitByColumn])))
        
        wtPos <- unique(c(
          grep("wt", plot_select),
          grep("WT", plot_select),
          grep("Wt", plot_select),
          grep("Ctrl", plot_select),
          grep("CTRL", plot_select)
        ))
        
        if (length(wtPos) > 0){
            plot_select <- c(
              plot_select[wtPos],
              plot_select[-wtPos]
            )
        }
        
        plot_select
      })
      
      plot_data <- reactive({
          dfTemp <- createDfTemp()
          
          plot_select <- plot_data_names()
          
          lapply(plot_select, function(x) dfTemp[dfTemp[,input$splitByColumn] == x,])
      })
      
      
      
      
      determinePlotDims <- reactive({
        dfTemp <- createDfTemp()
        
        if (!is.numeric(dfTemp$x_axis)){
          minX <- 0
          maxX <- length(unique(dfTemp$x_axis)) + 1
        } else {
          maxX <- 1.1*max(dfTemp$x_axis, na.rm = T)
          minX <- 1.1*min(dfTemp$x_axis, na.rm = T)
        }
        
        if (!is.numeric(dfTemp$y_axis)){
          minY <- 0
          maxY <- length(unique(dfTemp$y_axis)) + 1
        } else {
          minY <- 1.1*min(dfTemp$y_axis, na.rm = T)
          maxY <- 1.1*max(dfTemp$y_axis, na.rm = T)
        }
        
        
        dimVec <- c(minX, maxX, minY, maxY)
        dimVec
      })
      
      
      
      
      
      
      observeEvent(toListen(), {
          #req(!is.null(input$splitByColumn))
          req(plot_data())
          
         
          dimVec <- determinePlotDims()
          maxX = dimVec[2]
          minX = dimVec[1]
          maxY = dimVec[4]
          minY = dimVec[3]
        
          output$multi_plot_ui <- renderUI({
              
              lapply(seq_along(plot_data() ),
                     function(n) {
                         return(plot_overlay_ui(paste0("n", n)))
                     })
          })
          
          
          lapply(seq_along(plot_data()),
                 function(i){
                     callModule(plot_overlay_server,
                                paste0("n", i),
                                df = plot_data()[[i]],
                                plot_name = paste0(plot_data_names()[i]), 
                                colorBy = input$colorBy,
                                dotsize = input$dotsize,
                                lowColor = input$lowColor, 
                                dotcolor = input$dotcolor,
                                background = input$background,
                                x_axis = input$x_axis,
                                y_axis = input$y_axis,
                                maxX = maxX,
                                minX = minX,
                                maxY = maxY,
                                minY = minY,
                                geneSel = input$gene
                    )
                 }
          )
          
          # for (i in seq_along(input$selected_sample)) {
          #   callModule(plot_overlay_server,
          #              paste0("n", i),
          #              spec = plot_data()[[i]],
          #              plot_name = i)
          # }
          
      }
      
      
      
      
      )
      
      
    }
)
